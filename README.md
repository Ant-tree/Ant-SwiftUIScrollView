# Ant-WebView
SwiftUI-usable WKWebView with advanced scroll
Makes you able to enables / disables the scroll, tracks the current scroll position.
Plus, you can check for the loading state of the webview.

## Usage
Simple call the AntWebView and it will be there.
```Swift
FixedWebView(
    urlString,
    isScrollable: $scrollEnabled
) { loading, error in
    viewModel.showProgressCircle = loading
} onScroll: { point, isScrollingUp in
    print("Where am I : \(point)")
    print("Am I going up ? : \(isScrollingUp)")
}.frame(
    minWidth: 0,
    maxWidth: .infinity,
    minHeight: 0,
    maxHeight: .infinity,
    alignment: alignment
)
```
