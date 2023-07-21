# Ant-SwiftUIScrollView
> SwiftUI-usable WKWebView and UIScrollView with advanced scroll

Makes you able to enables / disables the scroll, tracks the current scroll position.

Plus, you can check for the loading state of the webview.

## Previews
| WebView loading | Scroll position tracking | Nested scroll control |
|-----------------|--------------------------|-----------------------|
| ![1](https://github.com/Ant-tree/Ant-SwiftUIScrollView/assets/88021994/0d44c665-be19-450f-b787-0d2980f99c77) | ![2](https://github.com/Ant-tree/Ant-SwiftUIScrollView/assets/88021994/6a00a106-ba67-489a-ab07-cb937eb2bd7b) | ![3](https://github.com/Ant-tree/Ant-SwiftUIScrollView/assets/88021994/403c7f0a-8315-43c7-a9ee-6db3e9697855) |

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
```ㅌ

![screen](https://github.com/Ant-tree/Ant-SwiftUIScrollView/assets/88021994/c00ec052-e816-46bc-897c-6fa3922471be)

