//
//  ContentView.swift
//  AntWebViewExamples
//
//  Created by HyunseokShim on 2023/07/12.
//

import SwiftUI
import AntWebView

struct ContentView: View {
    let urlString: String = "https://google.com"
    @State var scrollEnabled: Bool = true
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
            Text("Hello, world!")
        }
        .padding()
        
        AntWebView(
            urlString,
            isScrollable: $scrollEnabled
        ) { loading, error in
            print("loading status : \(loading)")
        } onScroll: { point, isScrollingUp in
            print("Where am I : \(point)")
            print("Am I going up ? : \(isScrollingUp)")
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .center
        )
    }
}

