//
//  ContentView.swift
//  AntSwiftUIScrollViewExamples
//
//  Created by HyunseokShim on 2023/07/13.
//

import SwiftUI
import AntSwiftUIScrollView

enum ViewInsets {
    static let safeAreaInsets: UIEdgeInsets? = UIApplication.shared.windows.first?.safeAreaInsets
    static let offsetOfObstacleBase: CGFloat      = 44
    static let heightOfObstacleBase: CGFloat    = 80
    static let heightOfTopSafeArea: CGFloat     = safeAreaInsets?.top ?? 0
    static let heightOfBottomSafeArea: CGFloat  = safeAreaInsets?.bottom ?? 0
}

struct ContentView: View {
    @EnvironmentObject var observedRoot: MainObservedView
    let urlString: String = "https://github.com"
    
    @State var showProgressCircle: Bool = false
    @State var scrollDownOnly: Bool = false
    @State var scrollEnabled: Bool = true
    @State var scrollPosition: CGPoint = CGPoint.zero
    @State var rootScrollPosition: CGFloat = CGFloat.zero
    
    init() {
        
    }
    
    var body: some View {
        ZStack {
            AntObservableScrollView(content: { proxy in
                VStack {
                    Text("Scroll Demo")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.black)
                        .fillWidthFixedHeight(
                            alignment: .leading,
                            height: 80
                        ).padding(EdgeInsets(
                            top: 10,
                            leading: 20,
                            bottom: 0,
                            trailing: 20
                        ))
                    
                    VStack {
                        
                    }
                    
                    AntWebView(
                        urlString,
                        isScrollable: $scrollEnabled
                    ) { loading, error in
                        print("loading status : \(loading)")
                        showProgressCircle = loading
                    } onScroll: { point, isScrollingUp in
                        print("Where am I : \(point)")
                        print("Am I going up ? : \(isScrollingUp)")
                        scrollPosition = point
                    }.frame(
                        height: calculateScrollHeight()
                    )
                    
                }.fillParent(alignment: .center)
                
            }, onScrollChanged: { point in
                rootScrollPosition = point
                if rootScrollPosition <= (
                    ViewInsets.heightOfObstacleBase +
                    ViewInsets.offsetOfObstacleBase
                ) {
                    scrollEnabled = false
                } else {
                    scrollEnabled = true
                }
            }, isScrollable: Binding.constant(true)
            ).frame(
                width: observedRoot.rootWindowRect.size.width,
                height: observedRoot.rootWindowRect.size.height,
                alignment: .center
            )
            
            if showProgressCircle {
                VStack {
                    ProgressView().progressViewStyle(
                        CircularProgressViewStyle(tint: .white)
                    )
                }
                .fillParent(alignment: .center)
                .background(Color.black.opacity(0.5))
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
            }
        }.toolbar {
            ToolbarItem(placement: ToolbarItemPlacement.automatic) {
                VStack {
                    Text("Scroll Demo")
                }
            }
        }
    }
    
    private func calculateScrollHeight() -> CGFloat {
        let visibleArea = observedRoot.rootWindowRect.size.height
            - ViewInsets.heightOfTopSafeArea
            - ViewInsets.heightOfBottomSafeArea
        
        var calculted = visibleArea
            - ViewInsets.heightOfObstacleBase
            - ViewInsets.offsetOfObstacleBase
        
        return calculted
    }
}

