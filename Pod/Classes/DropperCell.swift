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
    
    internal var cellType: Options = .Text /// Default Cell type
    internal var imageItem: UIImageView = UIImageView() /// Cell Image View
    internal var textItem: UILabel = UILabel() /// Text item
    internal var last: Int? /// Last Item in array (Helps to determine weather or not to add another line)
    internal var indexPath: NSIndexPath? /// Index path of current cellForRow
    internal var borderColor: UIColor? /// Border Color of custom Border
    private var seperator: UIView = UIView() /// Seperator of cells
    
    override func layoutSubviews() {
        self.layoutMargins = UIEdgeInsetsZero
        self.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        super.layoutSubviews()
        switch cellType {
        case .Icon:
            let height = self.frame.size.height - 20
            imageItem.frame = CGRect(x: 0, y: (self.frame.height - height)/2, width: self.frame.width, height: height)
            imageItem.contentMode = UIViewContentMode.ScaleAspectFit
            addSubview(imageItem)
        case .Text:
            textItem.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            textItem.textAlignment = .Center
            textItem.adjustsFontSizeToFitWidth = true
            textItem.numberOfLines = 0
            addSubview(textItem)
        }
        
        addBottomBorder()
    }
    
    private func addBottomBorder() {
        if let index = indexPath, lastItem = last {
            if (index.row != lastItem) {
                seperator.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1)
                seperator.backgroundColor = borderColor ?? UIColor.blackColor()
                addSubview(seperator)
            }
        }
    }
}
