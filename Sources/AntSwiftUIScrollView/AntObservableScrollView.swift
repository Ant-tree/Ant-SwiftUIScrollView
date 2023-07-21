//
//  AntObservableScrollView.swift
//
//
//  Created by HyunseokShim on 2023/07/13.
//
// Inspired by https://swiftuirecipes.com/blog/swiftui-scrollview-scroll-offset
// and https://gist.github.com/timothycosta/0d8f64afeca0b6cc29665d87de0d94d2
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
    @Binding var isScrollable: Bool
    
    public init(@ViewBuilder content: @escaping (ScrollViewProxy) -> Content,
         onScrollChanged: ((CGFloat) -> Void)? = nil,
         isScrollable: Binding<Bool>) {
        self.content = content
        self.onScrollChanged = onScrollChanged
        _isScrollable = isScrollable
    }
    
    public var body: some View {
        ScrollView(content: {
            ScrollViewReader { proxy in
                content(proxy)
                    .background(GeometryReader { geo in
                        let offset = -geo.frame(in: .named(scrollSpace)).minY
                        Color.clear
                            .preference(key: ScrollViewOffsetPreferenceKey.self,
                                        value: offset)
                    })
            }
        })
        .coordinateSpace(name: scrollSpace)
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
            if let onScrollChanged = self.onScrollChanged {
                onScrollChanged(value)
            }
        }
    }
}

// A ScrollView wrapper that tracks scroll offset changes.
@available(iOS 14.0, *)
public struct AntControllableScrollView<Content>: View where Content : View {
    @Namespace var scrollSpace
    
    let content: (ScrollViewProxy) -> Content
    var onScrollChanged: ((CGFloat) -> Void)? = nil
    @Binding var isScrollable: Bool
    
    public init(@ViewBuilder content: @escaping (ScrollViewProxy) -> Content,
         onScrollChanged: ((CGFloat) -> Void)? = nil,
         isScrollable: Binding<Bool>) {
        self.content = content
        self.onScrollChanged = onScrollChanged
        _isScrollable = isScrollable
    }
    
    public var body: some View {
        UIScrollViewWrapper(content: {
            ScrollViewReader { proxy in
                content(proxy)
                    .background(GeometryReader { geo in
                        let offset = -geo.frame(in: .named(scrollSpace)).minY
                        Color.clear
                            .preference(key: ScrollViewOffsetPreferenceKey.self,
                                        value: offset)
                    })
            }
        }, isScrollable: $isScrollable)
        .coordinateSpace(name: scrollSpace)
        .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
            if let onScrollChanged = self.onScrollChanged {
                onScrollChanged(value)
            }
        }
    }
}

@available(iOS 13.0, *)
struct UIScrollViewWrapper<Content: View>: UIViewControllerRepresentable {

    var content: () -> Content
    @Binding var isScrollable: Bool

    public init(@ViewBuilder content: @escaping () -> Content, isScrollable: Binding<Bool>) {
        self.content = content
        _isScrollable = isScrollable
    }

    public func makeUIViewController(context: Context) -> UIScrollViewViewController {
        let viewController = UIScrollViewViewController()
        viewController.hostingController.rootView = AnyView(self.content())
        viewController.scrollView.isScrollEnabled = isScrollable
        return viewController
    }

    public func updateUIViewController(_ viewController: UIScrollViewViewController, context: Context) {
        viewController.hostingController.rootView = AnyView(self.content())
        if isScrollable {
            viewController.scrollView.isScrollEnabled = true
        } else {
            viewController.scrollView.isScrollEnabled = false
        }
    }
}

@available(iOS 13.0, *)
class UIScrollViewViewController: UIViewController {

    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.isPagingEnabled = true
        return v
    }()

    var hostingController: UIHostingController<AnyView> = UIHostingController(rootView: AnyView(EmptyView()))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.scrollView)
        self.pinEdges(of: self.scrollView, to: self.view)

        self.hostingController.willMove(toParent: self)
        self.scrollView.addSubview(self.hostingController.view)
        self.pinEdges(of: self.hostingController.view, to: self.scrollView)
        self.hostingController.didMove(toParent: self)

    }

    func pinEdges(of viewA: UIView, to viewB: UIView) {
        viewA.translatesAutoresizingMaskIntoConstraints = false
        viewB.addConstraints([
            viewA.leadingAnchor.constraint(equalTo: viewB.leadingAnchor),
            viewA.trailingAnchor.constraint(equalTo: viewB.trailingAnchor),
            viewA.topAnchor.constraint(equalTo: viewB.topAnchor),
            viewA.bottomAnchor.constraint(equalTo: viewB.bottomAnchor),
        ])
    }

}
