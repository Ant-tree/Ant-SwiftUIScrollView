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
    static let offsetOfHeaderBase: CGFloat          = 44
    static let heightOfBigTitleView: CGFloat        = 80
    static let heightOfObstacleBase: CGFloat        = 100
    static let heightOfTopSafeArea: CGFloat         = safeAreaInsets?.top ?? 0
    static let heightOfBottomSafeArea: CGFloat      = safeAreaInsets?.bottom ?? 0
}

struct ContentView: View {
    @EnvironmentObject var observedRoot: MainObservedView
    let urlString: String = "https://github.com"
    
    let title: String = "Scroll Demo"
    let subTitle: String = "That makes you able to do these"
    let description: String = "https://github.com/Ant-tree/Ant-SwiftUIScrollView"
    
    @State var state: Int = 0
    
    @State var showProgressCircle: Bool = false
    @State var scrollDownOnly: Bool = false
    @State var scrollEnabled: Bool = false
    @State var webViewScrollPosition: CGPoint = CGPoint.zero
    @State var rootScrollPosition: CGFloat = CGFloat.zero
    
    init() {
        
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text("AntSwiftUIScrollView")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.black
                    ).opacity(
                        calculateOpacity()
                    )
                    .fillWidth(alignment: .leading)
                    .padding(.leading, 20)
                
                SmallTitleView.opacity(
                    1 - calculateOpacity()
                )
            }.fillWidthFixedHeight(
                alignment: .center,
                height: 44
            )
            
            ZStack {
                AntObservableScrollView(content: { proxy in
                    VStack(spacing: 0) {
                        BigTitleView.padding(EdgeInsets(
                            top: 10,
                            leading: 20,
                            bottom: 10,
                            trailing: 20
                        ))
                        
                        ObstacleBetweenScrolls.padding(EdgeInsets(
                            top: 0,
                            leading: 20,
                            bottom: 20,
                            trailing: 20
                        ))
                        
                        ControlPanel.padding(EdgeInsets(
                            top: 0,
                            leading: 20,
                            bottom: 20,
                            trailing: 20
                        ))
                        
                        AntWebView(
                            urlString,
                            isScrollable: $scrollEnabled
                        ) { loading, error in
                            print("loading status : \(loading)")
                            showProgressCircle = loading
                        } onScroll: { point, isScrollingUp in
                            print("Where am I : \(point)")
                            print("Am I going up ? : \(isScrollingUp)")
                            webViewScrollPosition = point
                        }.frame(
                            height: calculateScrollHeight()
                        )
                        
                    }.fillParent(alignment: .center)
                    
                }, onScrollChanged: { point in
                    rootScrollPosition = point
                    if point >= ViewInsets.heightOfBigTitleView {
                        scrollEnabled = true
                    } else {
                        scrollEnabled = false
                    }
                }, isScrollable: Binding.constant(true))
                
                if showProgressCircle {
                    VStack {
                        ProgressView().progressViewStyle(
                            CircularProgressViewStyle(tint: .white)
                        )
                    }
                    .fillParent(alignment: .center)
                    .background(Color.black.opacity(0.5))
                }
            }.onAppear {
                modifyGlobalAppearances()
            }
        }
    }
    
    var BigTitleView: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.gray)
            
            Text(subTitle)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color.gray)
            
        }.fillWidthFixedHeight(
            alignment: .leading,
            height: ViewInsets.heightOfBigTitleView
        )
    }
    
    var SmallTitleView: some View {
        VStack(alignment: .center) {
            Text(title)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(Color.black)
            
            Text(description)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(Color.black)
            
        }.fillWidth(alignment: .center)
    }
    
    var ObstacleBetweenScrolls: some View {
        VStack(alignment: .center) {
            Text("- Enables / disables the scroll")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(Color.black)
                .fillWidth(alignment: .leading)
            
            Text("- Scroll position tracking")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(Color.black)
                .fillWidth(alignment: .leading)
            
            Text("- Scrolls to specific point")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(Color.black)
                .fillWidth(alignment: .leading)
            
            Text("- Loading completion listening")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(Color.black)
                .fillWidth(alignment: .leading)
        }
        .padding(.horizontal, 20)
        .fillWidthFixedHeight(
            alignment: .leading,
            height: ViewInsets.heightOfObstacleBase
        ).background(
            RoundedRectangle(
                cornerRadius: 8
            ).fill(Color(UIColor(white: 0.9, alpha: 0.5)))
        )
    }
    
    var ControlPanel: some View {
        VStack(alignment: .center) {
            Text("States")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color.black)
                .fillWidth(alignment: .leading)
            
            HStack {
                Text("Root scroll offset")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color.black)
                    .fillWidth(alignment: .leading)
                
                Text("\(Int(rootScrollPosition))")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color.black)
            }
            HStack {
                Text("WebView scroll position")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color.black)
                    .fillWidth(alignment: .leading)
                
                Text("x : \(Int(webViewScrollPosition.x))")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color.black)
                    .frame(width: 60, alignment: .trailing)
                    
                
                Text("y : \(Int(webViewScrollPosition.y))")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color.black)
                    .frame(width: 60, alignment: .trailing)
            }
            
            HStack {
                Text("WebView loading")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color.black)
                    .fillWidth(alignment: .leading)
                
                Text(String(describing: showProgressCircle))
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color.black)
            }
        }
        .padding(.horizontal, 20)
        .fillWidthFixedHeight(
            alignment: .leading,
            height: ViewInsets.heightOfObstacleBase
        ).background(
            RoundedRectangle(
                cornerRadius: 8
            ).fill(Color(UIColor(white: 0.9, alpha: 0.5)))
        )
    }
    
    private func calculateOpacity() -> Double {
        return (
            ViewInsets.heightOfBigTitleView - rootScrollPosition
        ) / ViewInsets.heightOfBigTitleView
    }
    private func calculateScrollHeight() -> CGFloat {
        let visibleArea = observedRoot.rootWindowRect.size.height
            - ViewInsets.heightOfTopSafeArea
            - ViewInsets.heightOfBottomSafeArea
        
        return visibleArea
            - ViewInsets.heightOfObstacleBase
            - ViewInsets.heightOfBigTitleView
    }
    
    private func modifyGlobalAppearances() {
        UIScrollView.appearance().bounces = false
    }
}

