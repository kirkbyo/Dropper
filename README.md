# Dropper
Dropper is a simple Dropdown menu for iOS. Built with customizability in mind and is flexible on how it can be used. Also, it is easy to setup and use in your projects. If you are looking for some complex dropdown menu, this is not for you. This was more built to be used as an accessory to a view. For example being able to change your currency in a shopping cart app. 

![Basic demo of how Dropper looks](https://raw.githubusercontent.com/kirkbyo/Dropper/master/Pod/Assets/White-DropdownBasic.mov.gif)
![Outflow Demo for how Dropper is used in the app](https://raw.githubusercontent.com/kirkbyo/Dropper/master/Pod/Assets/DropperOutflowDemo.mov.gif)

Left demo of a basic Dropper menu. Right is how Dropper is used in [Outflow](http://outflowapp.com/).

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
Shows the Dropdown Menu
- `show(options: Alignment, button: UIButton)`
  - options *Dropper.Alignment*: Position of the dropdown corresponding of the button (Left, Center, Right)
  - button *UIButton*: Button that button will be position relative too
Shows the Dropdown menu with a fade animation
- `showWithAnimation(time: NSTimeInterval, options: Alignment, button: UIButton)`
  - time *NSTimeInterval*: Time taken for the fade animation
  - options *Dropper.Alignment*: Position of the dropdown corresponding of the button (Left, Center, Right)
  - button *UIButton*: Button that button will be position relative too

#### Hide
Hides the Dropdown Menu
- `hide()`
Hides the Dropdown menu with an fade out animation
- `hideWithAnimation(time: NSTimeInterval)`
    - time *NSTimeInterval*: Time taken for the fade out animation

#### Properties 
- `trimCorners` *Bool*: Automaticly applies border radius of 10 to Dropdown (Defaults to False)
- `defaultAnimationTime` *NSTimeInterval*: The default time for animations to take (Defaults to 0.1)
- `delegate` *DropperDelegate*: Delegate property, must be initialized for the functions to be called
    - `DropperSelectedRow`: Called everytime a Dropper row is selected
- `status` *Status (Enum)*: The current state of the view
- `spacing` *CGFloat*: The distance from the button to the Dropper
- `maxHeight` *CGFloat*: The maximum possible height of the Dropper
- `cellBackgroundColor` *UIColor*: Sets the cell background color (Defaults to theme color if not set)
- `cellColor` *UIColor*: Sets the cell tint color and text color (Defaults to theme color if not set)
- `cellTextSize` *CGFloat*: Sets the size of the text to provided value (Defaults to UILabel Font Size)
- `TableMenu` *UITableView*: Table View that the Dropper is built on
- `items` *[String]*: The items to be dispalyed in the tableview
- `height` *CGFloat*: Height of the Dropdown
- `width` *CGFloat*: Width of the Dropdown
- `cornerRadius` *CGFloat*: Corner Radius of the Dropdown
- `theme` *Themes (Enum)*: Theme of dropdown menu (Defaults to White theme)
    - `.White`: Black text color, White background Color and black border color
    - `.Black(UIColor)`: White Text, Dark background color, you can also specify your own color, or use the default by passing **nil** to the enum case
```Swift
dropper.theme = Dropper.Themes.Black(nil) // Uses default dark color
// OR
dropper.theme = Dropper.Themes.Black(UIColor.blackColor()) // Uses default dark color
```
- `border` *(width: CGFloat, color: UIColor)*: Specify the border width and the color of the Dropper
- `refresh()`: Refresh the Dropper. For specifically calling .reloadData() on the Table View

## License

Dropper is available under the MIT license. See the LICENSE file for more info.

Built by [Ozzie Kirkby](http://kirkbyo.com/), if you have any question feel free to contact. [Twitter](https://twitter.com/kirkbyo_)
