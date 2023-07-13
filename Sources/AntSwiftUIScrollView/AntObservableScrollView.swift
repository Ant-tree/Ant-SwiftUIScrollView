//
//  AntObservableScrollView.swift
//
//
//  Created by HyunseokShim on 2023/07/13.
//

import Foundation
import SwiftUI

// Simple preference that observes a CGFloat.
public struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    public static var defaultValue = CGFloat.zero
    
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

// A ScrollView wrapper that tracks scroll offset changes.
@available(iOS 14.0, *)
public struct AntObservableScrollView<Content>: View where Content : View {
    @Namespace var scrollSpace
    
    let content: (ScrollViewProxy) -> Content
    var onScrollChanged: ((CGFloat) -> Void)? = nil
    
    public init(@ViewBuilder content: @escaping (ScrollViewProxy) -> Content,
         onScrollChanged: ((CGFloat) -> Void)? = nil) {
        self.content = content
        self.onScrollChanged = onScrollChanged
    }
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            ScrollViewReader { proxy in
                content(proxy)
                    .background(GeometryReader { geo in
                        let offset = -geo.frame(in: .named(scrollSpace)).minY
                        Color.clear
                            .preference(key: ScrollViewOffsetPreferenceKey.self,
                                        value: offset)
                    })
            }
        }
        .coordinateSpace(name: scrollSpace)
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
            if let onScrollChanged = self.onScrollChanged {
                onScrollChanged(value)
            }
        }
    }
}
