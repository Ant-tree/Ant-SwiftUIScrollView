# Ant-SwiftUIScrollView
> SwiftUI-usable WKWebView and UIScrollView with advanced scroll

Makes you able to enables / disables the scroll, tracks the current scroll position.

Plus, you can check for the loading state of the webview.

## Usage
Simple call the AntWebView or AntObservableScrollView and it will be there.
| Function | AntWebView | AntObservableScrollView |
| -------- | ---------- | ----------------------- |
| Enables / disables the scroll    | O | O |
| Scroll position tracking         | O | O |
| Scrolls to specific point        | X | O |
| Loading completion listening     | O | X |

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

