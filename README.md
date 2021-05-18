<p align="center">
    <i>This repository has been archived. It is now a part of <a href="https://github.com/pawello2222/PhantomKit">PhantomKit.</i>
</p>
<h1></h1>

![Language: Swift](https://img.shields.io/badge/language-swift-orange.svg)
![Framework: SwiftUI](https://img.shields.io/badge/framework-swiftui-brightgreen.svg)
![platforms](https://img.shields.io/badge/platforms-iPhone%20%7C%20iPad%20%7C%20macOS-lightgrey)

# UIUtils

A collection of useful SwiftUI components.

## Installation

UIUtils is available as a Swift Package.

``` Swift
import UIUtils
```

## Components

### ActivityIndicator

``` Swift
ActivityIndicator()
    .frame(width: 50)
    .foregroundColor(.orange)
```

### BackgroundNavigationLink

``` Swift
NavigationView {
    BackgroundNavigationLink(
        destination: Text("Destination"), 
        action: { print("Navigating...") }, 
        content: Text("Go to...")
    )
}
```

### LabelButton

``` Swift
LabelButton(text: "Label", imageName: "plus.circle.fill", color: .red)
```

### NetworkImage

``` Swift
NetworkImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png"))
```

``` Swift
NetworkImage(
    url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png"),
    loadingContent: Text("Loading..."),
    errorContent: Text("Error")
)
```

### PageView

``` Swift
@State private var selection = 2

// ...

PageView(selection: $selection) {
    Text("Tab 1")
    Text("Tab 2")
    Text("Tab 3")
}
```

### SplitPicker

``` Swift
@State private var selection = 2

let items = (1 ... 5)
    .map {
        PickerItem(
            selection: $0,
            short: "Short: \($0)",
            long: "Long text of: \($0)"
        )
    }
    
// ...

NavigationView {
    Form {
        SplitPicker(selection: $selection, items: items, showMultiLabels: true) {
            Text("Picker")
        }
    }
}
```

### TabViewItem

``` Swift
@State private var selection = 1

// ...

TabView {
    Text("Tab 1")
        .tabItem(index: 1, text: "Calendar", imageName: "calendar")
    Text("Tab 2")
        .tabItem(index: 2, text: "Add", imageName: "plus.circle")
    Text("Tab 3")
        .tabItem(index: 3, text: "Cancel", imageName: "xmark")
}
.tabSelection($selection)
```

### WebView

``` Swift
WebView(link: "https://google.com", blockOutgoingRequests: true)
```

## License

UIUtils is available under the MIT license. See the LICENSE file for more info.
