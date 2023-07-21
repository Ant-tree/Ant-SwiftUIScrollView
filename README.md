# Ant-SwiftUIScrollView
> SwiftUI-usable WKWebView and UIScrollView with advanced scroll

Makes you able to enables / disables the scroll, tracks the current scroll position.

Plus, you can check for the loading state of the webview.

## Usage
Simply call the AntWebView or AntObservableScrollView and it will be there.
| Function | AntWebView | AntObservableScrollView | AntControllableScrollView |
| -------- | ---------- | ----------------------- | ----------------------- |
| Enables / disables the scroll    | O | O | X (Use introspect) |
| Scroll position tracking         | O | O | O |
| Scrolls to specific point        | X | O | O |
| Loading completion listening     | O | X | X |

> Currently, the `AntControllableScrollView` is unstable due to its UIKit feature.
> 
> Thus, use the `AntObservableScrollView` instead and use [SwiftUI-Introspect](https://github.com/siteline/SwiftUI-Introspect) to enable or disable the scroll event.

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
For the AntObservableScrollView, 
```Swift
AntObservableScrollView(content: { proxy in
    //Contents to be scrolled
    VStack {
    }
}, onScrollChanged: { point in
    print("Where am I : \(point)")
}, isScrollable: $scrollEnabled)
```
## Preview

![screen](https://github.com/Ant-tree/Ant-SwiftUIScrollView/assets/88021994/c00ec052-e816-46bc-897c-6fa3922471be)

