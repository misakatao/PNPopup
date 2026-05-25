# PNPopup

[![Version](https://img.shields.io/cocoapods/v/PNPopup.svg?style=flat)](https://cocoapods.org/pods/PNPopup)
[![License](https://img.shields.io/cocoapods/l/PNPopup.svg?style=flat)](https://cocoapods.org/pods/PNPopup)
[![Platform](https://img.shields.io/cocoapods/p/PNPopup.svg?style=flat)](https://cocoapods.org/pods/PNPopup)

A lightweight, customizable popup presentation library for iOS. Provides ActionSheet-style and Alert-style popup animations with flexible configuration options.

## Features

- ActionSheet (bottom slide-up) and Alert (center pop-in) presentation styles
- Customizable show/dismiss animations with spring effects
- Touch-outside-to-dismiss support
- Lifecycle callbacks (willPresent / didPresent / willDismiss / didDismiss)
- Optional UINavigationController wrapping
- Configurable background overlay and corner radius
- Pure UIKit, zero dependencies

## Requirements

- iOS 10.0+
- Swift 5.0+

## Installation

PNPopup is available through [CocoaPods](https://cocoapods.org). Add the following line to your Podfile:

```ruby
pod 'PNPopup'
```

## Usage

### Basic Popup

```swift
let popup = PopupViewController()
popup.touchAutoDismiss = true
popup.presentPopupViewController(self)
```

### Alert Style

```swift
let popup = PopupViewController()
popup.setShowAnimation(ActionAlertShowAnimation())
popup.setDismissAnimation(ActionAlertDismissAnimation())
popup.presentPopupViewController(self)
```

### Lifecycle Callbacks

```swift
popup.willPresentBlock { vc in
    print("Popup will present")
}
popup.didDismissBlock { vc in
    print("Popup did dismiss")
}
```

### With Navigation Controller

```swift
let popup = PopupViewController()
popup.useNavigationController = true
popup.presentPopupViewController(self)
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

misaka, misakatao@gmail.com

## License

PNPopup is available under the MIT license. See the LICENSE file for more info.
