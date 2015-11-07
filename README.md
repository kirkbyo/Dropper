# Dropper

[![Version](https://img.shields.io/cocoapods/v/Dropper.svg?style=flat)](http://cocoapods.org/pods/Dropper)
[![License](https://img.shields.io/cocoapods/l/Dropper.svg?style=flat)](http://cocoapods.org/pods/Dropper)
[![Platform](https://img.shields.io/cocoapods/p/Dropper.svg?style=flat)](http://cocoapods.org/pods/Dropper)

## Installation

Dropper is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Dropper"
```

## Usage

Setting up is easy, after installing the library, initialize a Dropper menu in your view
```swift
let dropper = Dropper(width: 75, height: 200)
```
After your Dropper view is initialized, you gotta specify which items to be displayed inside the Dropper
```swift
dropper.items = ["Item 1", "Item 2", "Item 3", "Item 4"] // Items to be displayed 
// Dropper also supports images
dropper.items = ["Item 1", "ImageOne.png", "Item 3", "ImageTwo.png"] // Images can be mixed with text items 
```
When you are ready to show your Dropper menu you have two options for how to display it: `show()` or `showWithAnimation()`.
```Swift
dropper.show(options: .Alignment.Center, button: UIButton)
// OR
dropper.showWithAnimation(0.15, options: .Alignment.Center, button: UIButton)
```
When you are ready to get back what Dropper item was selected, confrom your class to the `DropperDelegate` and implement the `DropperSelectedRow` method, it is also importent that you initialize the `dropper.delegate` property to your class before showing your view.
```Swift
dropper.delegate = self // Insert this before you show your Dropper

extension ViewController: DropperDelegate {
    func DropperSelectedRow(path: NSIndexPath, contents: String) {
        /* Do something */
    }
}
```

#### Simple Example Usage
```swift
class ViewController: UIViewController {
    let dropper = Dropper(width: 75, height: 200)
    @IBOutlet var dropdownButton: UIButton!

    @IBAction func DropdownAction() {
        if dropper.status == .Hidden {
            dropper.items = ["Item 1", "Item 2", "Item 3", "Item 4"] // Item displayed
            dropper.theme = Dropper.Themes.White
            dropper.delegate = self
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, button: dropdownButton)
        } else {
            dropper.hideWithAnimation(0.1)
        }
    }
}
```

## Documentation

#### Show

- `show(options: Alignment, button: UIButton)`
  - options *Dropper.Alignment*: Position of the dropdown corresponding of the button (Left, Center, Right)
  - button *UIButton*: Button that button will be position relative too
- `showWithAnimation(time: NSTimeInterval, options: Alignment, button: UIButton)`
  - time *NSTimeInterval*: Time taken for the fade animation
  - options *Dropper.Alignment*: Position of the dropdown corresponding of the button (Left, Center, Right)
  - button *UIButton*: Button that button will be position relative too

## License

Dropper is available under the MIT license. See the LICENSE file for more info.
