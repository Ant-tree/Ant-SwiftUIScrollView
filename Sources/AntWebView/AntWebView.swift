//
//  AntWebView.swift
//
//
//  Created by HyunseokShim on 2023/07/12.
//

import Foundation
import SwiftUI
import WebKit

@available(iOS 13, *)
public struct AntWebView: UIViewRepresentable {
    var urlString: String
    var loadStatusChanged: ((Bool, Error?) -> Void)? = nil
    var onScroll: ((CGPoint, Bool) -> Void)? = nil
    @Binding var isScrollable: Bool
    
    init(_ urlString: String,
         isScrollable: Binding<Bool>,
         loadStatusChanged: ((Bool, Error?) -> Void)? = nil,
         onScroll: ((CGPoint, Bool) -> Void)? = nil
    ) {
        self.urlString = urlString
        self.loadStatusChanged = loadStatusChanged
        self.onScroll = onScroll
        _isScrollable = isScrollable
    }
    
    public func makeCoordinator() -> AntWebView.Coordinator {
        Coordinator(self)
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: urlString)
        else {
            return WKWebView()
        }
        
        let webView = WKWebView(frame: CGRect(x: 0.0, y: 0.0, width: 0.1, height: 0.1))
        webView.scrollView.bounces = false
        webView.navigationDelegate = context.coordinator
        if onScroll != nil {
            webView.scrollView.delegate = context.coordinator
        }
        
        DispatchQueue.main.async {
            webView.load(URLRequest(url: url))
        }
        
        return webView
    }
    
    public func updateUIView(
        _ uiView: WKWebView,
        context: UIViewRepresentableContext<AntWebView>
    ) {
        if isScrollable {
            uiView.scrollView.isScrollEnabled = true
        } else {
            uiView.scrollView.isScrollEnabled = false
        }
    }
    
    func onLoadStatusChanged(perform: ((Bool, Error?) -> Void)?) -> some View {
        var copy = self
        copy.loadStatusChanged = perform
        return copy
    }

    public class Coordinator: NSObject, WKNavigationDelegate, UIScrollViewDelegate {
        let parent: AntWebView
        var lastContentOffsetY: CGFloat = 0
        init(_ parent: AntWebView) {
            self.parent = parent
        }

        public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            parent.loadStatusChanged?(true, nil)
        }

        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.loadStatusChanged?(false, nil)
        }

        public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.loadStatusChanged?(false, error)
        }
        
        public func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if (lastContentOffsetY != scrollView.contentOffset.y) {
                parent.onScroll?(
                    scrollView.contentOffset,
                    lastContentOffsetY < scrollView.contentOffset.y
                )
                lastContentOffsetY = scrollView.contentOffset.y
            }
        }
    }
}
