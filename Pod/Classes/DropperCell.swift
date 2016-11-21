//
//  DropdownCell.swift
//  Pods
//
//  Created by Ozzie Kirkby on 2015-10-10.
//
//

import UIKit

internal class DropperCell: UITableViewCell {
    /**
    Cell Type Options
    
    - Icon: Cell contains a UIImage
    - Text: Cell contains text
    */
    enum Options {
        case Icon, Text
    }
    /// Theme of the cell
    internal var theme: Dropper.Themes = .White {
        didSet {
            switch theme {
            case .White:
                customize = DropperCellCustomizations()
            case .Black(let backgroundColor):
                customize = DropperCellCustomizations()
                if let backgroundColor = backgroundColor {
                    customize.backgroundColor = backgroundColor
                }
                customize.backgroundColor = UIColor.blackColor()
                customize.label.textColor = UIColor.whiteColor()
                customize.image.tintColor = UIColor.whiteColor()
            }
        }
    }
     /// Default Cell type
    internal var cellType: Options = .Text
    /// Cell Image View
    internal var imageItem: UIImageView = UIImageView()
    /// Text item
    internal var textItem: UILabel = UILabel()
    // Last Item in array (Helps to determine weather or not to add another line)
    internal var last: Int?
    /// Index path of current cellForRow
    internal var indexPath: NSIndexPath?
    /// Border Color of custom Border
    @available(iOS, deprecated=3.0, message="[Dropper]: border will be deprecated in Dropper 4.0, use cellCustomizations.seperator instead.")
    internal var borderColor: UIColor?
    /// Cell customization points
    internal var customize: DropperCellCustomizations = DropperCellCustomizations()
    /// Seperator of cells
    private var seperator: UIView = UIView()
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        // Removes separator
        self.layoutMargins = UIEdgeInsetsZero
        self.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.backgroundColor = customize.backgroundColor
        
        // Lays out the cell depending if it's an image or text
        switch cellType {
        case .Icon:
            let height = self.frame.size.height - 20
            self.imageItem.contentMode = customize.image.contentMode
            self.imageItem.tintColor = self.customize.image.tintColor
            if let image = customize.image.customImage {
                self.imageItem = image
            }
            self.imageItem.frame = CGRect(x: 0, y: (self.frame.height - height)/2, width: self.frame.width, height: height)
            
            if (self.selected) {
                imageItem.backgroundColor = self.customize.selectedItem.backgroundColor
            }
            
            addSubview(imageItem)
        case .Text:
            textItem.layer.cornerRadius = self.customize.selectedItem.cornerRadius
            textItem.clipsToBounds = self.customize.selectedItem.trimCorners
            textItem.numberOfLines = 0
            textItem.adjustsFontSizeToFitWidth = self.customize.label.adjustsFontSizeToFitWidth
            textItem.textAlignment = self.customize.label.alignment
            if let image = customize.image.customImage {
                self.imageItem = image
            }
            textItem.frame = CGRect(x: self.customize.selectedItem.boxPadding / 2, y: self.customize.selectedItem.boxPadding / 2, width: self.frame.width - self.customize.selectedItem.boxPadding, height: self.frame.height - self.customize.selectedItem.boxPadding)
            if (self.selected) {
                textItem.backgroundColor = self.customize.selectedItem.backgroundColor
            }
            addSubview(textItem)
        }
        
        addBottomBorder()
    }
    
    private func addBottomBorder() {
        guard customize.addSeparators == true else { return }
        
        if let index = indexPath, lastItem = last {
            if (index.row != lastItem) {
                seperator.frame = CGRect(x: 0, y: self.frame.height - customize.separators.height, width: self.frame.width, height: customize.separators.height)
                seperator.backgroundColor = self.customize.separators.color
                addSubview(seperator)
            }
        }
    }
}
