//
//  DropperCellCustomizations.swift
//  Pods
//
//  Created by Ozzie Kirkby on 2016-07-21.
//
//

import UIKit

public class DropperCellCustomizations {
    // MARK: - View Customizations
    /// Background color
    public var backgroundColor: UIColor = UIColor.whiteColor()
    
    // MARK: - Border
    /// Adds a border to the bottom of the cells in order to act has a separators
    public var addSeparators: Bool = true
    /// Customizations points for Cell Seperators
    public var separators: Separators = Separators()
    /// Customizations points to adjust the look of the seperators
    public class Separators {
        /// Color of the seperator
        public var color: UIColor = UIColor.blackColor()
        /// Height of the seperator
        public var height: CGFloat = 1
    }
    
    // MARK: - Selected Iten
    /// Customizations points for when a cell is selected
    public var selectedItem: SelectedItem = SelectedItem()
    /// Customizations points to adjust the look for when a cell is selected
    public class SelectedItem {
        /// Adjusts the background color on the cell type. Ex: Text cells have their background color changed.
        public var backgroundColor: UIColor = UIColor.whiteColor()
        /// Corner radius of the selected view.
        public var cornerRadius: CGFloat = 2
        /// Amont of spacing between the text or icon and the cell.
        public var boxPadding: CGFloat = 12
        /// Trim corners on selected view. (Defaults to true)
        public var trimCorners: Bool = true
    }
    
    // MARK: - Label
    /// Customizations points for when a cell is of type text.
    public var label: Label = Label()
    /// Customizations points to adjust the look of the text when a cell is of type text.
    public class Label {
        /// Overrides the default label and will ignore any changes made to the customization points.
        public var customLabel: UILabel?
        /// Adjusts the font size of the label
        public var fontSize: CGFloat = 12
        /// Adjusts the font name of the label
        public var fontName: String = "Helvetica"
        /// UIFont of the label
        public var font: UIFont {
            guard let font = UIFont(name: fontName, size: fontSize) else {
                print("[Dropper] &Error:101: Font could not be constructed. Please report this issue @ https://github.com/kirkbyo/Dropper/issues")
                return UIFont()
            }
            return font
        }
        /// Alignment of the text
        public var alignment: NSTextAlignment = .Center
        /// Adjust the text size so that it'll fit inside the frame. (Defaults to true)
        public var adjustsFontSizeToFitWidth: Bool = true
        /// color of the text
        public var textColor: UIColor = UIColor.blackColor()
    }
    
    // MARK: - Image
    /// Customizations points for when a cell is of type image.
    public var image: Image = Image()
    /// Customizations points to adjust the look of the text when a cell is of type image.
    public class Image {
        /// Overrides the default image view and will ignore any changes made to the customization points.
        public var customImage: UIImageView?
        /// Image content mode
        public var contentMode: UIViewContentMode = UIViewContentMode.ScaleAspectFit
        /// Tint color
        public var tintColor: UIColor = UIColor.blackColor()
    }
}