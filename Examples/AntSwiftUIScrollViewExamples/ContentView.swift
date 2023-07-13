//
//  ContentView.swift
//  AntSwiftUIScrollViewExamples
//
//  Created by HyunseokShim on 2023/07/13.
//

import SwiftUI
import SwiftUIScrollView

struct ContentView: View {
    let urlString: String = "https://github.com"
    
    @State var showProgressCircle: Bool = false
    @State var scrollDownOnly: Bool = false
    @State var scrollEnabled: Bool = true
    @State var scrollPosition: CGPoint = CGPoint.zero
    
    var body: some View {
        ZStack {
            VStack {
                Text("Scroll")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.black)
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        alignment: .leading
                    ).padding(EdgeInsets(
                        top: 10,
                        leading: 20,
                        bottom: 0,
                        trailing: 20
                    ))
                
                HStack {
                    Text("Enable scroll")
                        .font(.system(size: 14))
                        .foregroundColor(Color.gray)
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                    
                    Button(action: {
                        scrollEnabled = !scrollEnabled
                    }, label: {
                        Image(
                            systemName: scrollEnabled
                            ? "checkmark.square.fill"
                            : "square"
                        ).foregroundColor(Color.black)
                    })
                }.padding(EdgeInsets(
                    top: 10,
                    leading: 20,
                    bottom: 5,
                    trailing: 20
                ))
                
                HStack {
                    Text("Current position")
                        .font(.system(size: 14))
                        .foregroundColor(Color.gray)
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                    
                    Text("\(scrollPosition.x),\(scrollPosition.y)")
                        .frame(alignment: .trailing)
                        .font(.system(size: 14))
                        .foregroundColor(Color.black)
                    
                }.padding(EdgeInsets(
                    top: 5,
                    leading: 20,
                    bottom: 10,
                    trailing: 20)
                )
                
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
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .center
                )
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
            }
            
            if showProgressCircle {
                VStack {
                    ProgressView().progressViewStyle(
                        CircularProgressViewStyle(tint: .white)
                    )
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .center
                ).background(Color.black.opacity(0.5))
                    .ignoresSafeArea()
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

