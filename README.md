# Ant-WebView
SwiftUI-usable WKWebView with advanced scroll

Makes you able to enables / disables the scroll, tracks the current scroll position.

Plus, you can check for the loading state of the webview.

## Preview

![screen](https://github.com/Ant-tree/Ant-WebView/assets/88021994/195161da-6a15-4d59-b5fc-6cceeceff65f)


## Usage
Simple call the AntWebView and it will be there.
```Swift
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
```
