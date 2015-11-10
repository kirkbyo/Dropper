//
//  Dropdown.swift
//  SwiftyDropdown
//
//  Created by Ozzie Kirkby on 2015-09-26.
//  Copyright © 2015 kirkbyo. All rights reserved.
//

import UIKit

public protocol DropperDelegate {
    func DropperSelectedRow(path: NSIndexPath, contents: String)
}

public class Dropper: UIView {
    public let TableMenu: UITableView = UITableView()
    /**
    Alignment of the dropdown menu compared to the button
    
    - Left: Dropdown is aligned to the left side the corresponding button
    
    - Center: Dropdown is aligned to the center of the corresponding button
    
    - Right: Dropdown is aligned to the right of the corresponding button
    */
    public enum Alignment {
        case Left, Center, Right
    }
    
    /**
    The current status of the dropdowns state
    
    - Displayed: The dropdown is visible on screen
    - Hidden: The dropdwon is hidden or offscreen.
    
    */
    public enum Status {
        case Displayed, Hidden, Shown
    }
    
    /**
    Default themes for dropdown menu
    
    - Black: Black theme for dropdown. Black background, white text
    - White: White theme for dropdown. White background, black text
    */
    public enum Themes {
        case Black(UIColor?), White
    }
    
    // MARK: - Public Properties
    public var trimCorners: Bool = false /// Automaticly applies border radius of 10 to Dropdown
    public var defaultAnimationTime: NSTimeInterval = 0.1 /// The default time for animations to take
    public var delegate: DropperDelegate? /// Delegate Property
    public var status: Status = .Hidden /// The current state of the view
    public var spacing: CGFloat = 10 /// The distance from the button to the dropdown
    public var maxHeight: CGFloat? /// The maximum possible height of the dropdown
    public var cellBackgroundColor: UIColor? /// Sets the cell background color
    public var cellColor: UIColor? /// Sets the cell tint color and text color
    public var cellTextSize: CGFloat? /// Sets the size of the text to provided value
    
    // MARK: - Public Computed Properties
    /// The items to be dispalyed in the tableview
    public var items = [String]() {
        didSet {
            refreshHeight()
        }
    }
    
    /// Height of the Dropdown
    public var height: CGFloat {
        get { return self.frame.size.height }
        set { self.frame.size.height = newValue }
    }
    
    /// Width of the Dropdown
    public var width: CGFloat {
        get { return self.frame.size.width }
        set { self.frame.size.width = newValue }
    }
    
    /// Corner Radius of the Dropdown
    public var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set {
            TableMenu.layer.cornerRadius = newValue
            TableMenu.clipsToBounds = true
        }
    }
    
    /// Theme of dropdown menu (Defaults to White theme)
    public var theme: Themes = .White {
        didSet {
            switch theme {
            case .White:
                cellColor = UIColor.blackColor()
                cellBackgroundColor = UIColor.whiteColor()
                border = (1, UIColor.blackColor())
            case .Black(let backgroundColor):
                let defaultColor = UIColor(red:0.149,  green:0.149,  blue:0.149, alpha:1)
                cellBackgroundColor = backgroundColor ?? defaultColor
                cellColor = UIColor.whiteColor()
                border = (1, backgroundColor ?? defaultColor)
            }
        }
    }
    
    /**
    Dropdown border styling
    
    - (width: CGFloat) Border Width
    - (color: UIColor) Color of Border
    
    */
    public var border: (width: CGFloat, color: UIColor) {
        get { return (TableMenu.layer.borderWidth, UIColor(CGColor: TableMenu.layer.borderColor!)) }
        set {
            let (borderWidth, borderColor) = newValue
            TableMenu.layer.borderWidth = borderWidth
            TableMenu.layer.borderColor = borderColor.CGColor
        }
    }
    
    // MARK: - Private Computed Properties
    /// Private property used to determine if the user has set a max height or if no max height is provided then make sure its less then the height of the view
    private var max_Height: CGFloat {
        get {
            if let height = maxHeight { // Determines if max_height is provided
                return height
            }

            if let containingView = self.superview { // restrict to containing views height
                return containingView.frame.size.height - self.frame.origin.y
            }
            
            return self.frame.size.height // catch all returns the current height
        }
        set {
            maxHeight = newValue
        }
    }
    
    /// Gets the current root view of where the dropdown is
    private var root: UIView? {
        guard let current = UIApplication.sharedApplication().keyWindow?.subviews.last else {
            print("[Dropper] &Error:100: Could not find current view. Please report this issue @ https://github.com/kirkbyo/Dropper/issues")
            return nil
        }
        return current
    }
    
    // MARK: - Layout & Setup
    override public func layoutSubviews() {
        super.layoutSubviews()
        // Size of table menu
        TableMenu.frame.size.height = self.frame.size.height + 0.1
        TableMenu.frame.size.width = self.frame.size.width + 0.1
        // Delegates and data Source
        TableMenu.dataSource = self
        TableMenu.delegate = self
        TableMenu.registerClass(DropperCell.self, forCellReuseIdentifier: "cell")
        // Styling
        TableMenu.backgroundColor = UIColor.lightGrayColor()
        TableMenu.separatorStyle = UITableViewCellSeparatorStyle.None
        TableMenu.bounces = false
        if (trimCorners) {
            TableMenu.layer.cornerRadius = 9.0
            TableMenu.clipsToBounds = true
        }
    }
    
    // MARK: - Private Properties
    /// Defines if the view has been shown yet
    private var shown: Status = .Hidden
    
    // MARK: - Init
    public init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        TableMenu.rowHeight = 50
        TableMenu.layer.borderColor = UIColor.lightGrayColor().CGColor
        TableMenu.layer.borderWidth = 1
        self.superview?.addSubview(self)
        
        self.tag = 2038 // Year + Month + Day of Birthday. Used to distinguish the dropper from the rest of the views
    }
    
    convenience public init(width: CGFloat, height: CGFloat) {
        self.init(x: 0, y: 0, width: width, height: height)
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - API
    
    /**
    Displays the dropdown
    
    - parameter options: Position of the dropdown corresponding of the button
    - parameter button: Button to which the dropdown will be aligned to
    
    */
    public func show(options: Alignment, button: UIButton) {
        switch options {
        case .Left:
            self.frame.origin.x = button.frame.origin.x
            self.frame.origin.y = button.frame.origin.y + button.frame.size.height + spacing
        case .Right:
            self.frame.origin.x = button.frame.origin.x + button.frame.width
            self.frame.origin.y = button.frame.origin.y + button.frame.height + spacing
        case .Center:
            self.frame.origin.x = button.frame.origin.x + (button.frame.width - self.frame.width)/2
            self.frame.origin.y = button.frame.origin.y + button.frame.height + spacing
        }
    
        if (!self.hidden) {
            self.addSubview(TableMenu)
            if let buttonRoot = findButtonFromSubviews((button.superview?.subviews)!, button: button) {
                buttonRoot.superview?.addSubview(self)
            } else {
                if let rootView = root {
                    rootView.addSubview(self)
                }
            }
        } else {
            self.TableMenu.hidden = false
            self.hidden = false
        }
        status = .Displayed
        
        refreshHeight()
    }
    
    /**
    Displays the dropdown with fade in type of aniamtion
    
    - parameter time:    Time taken for the fade animation
    - parameter options: Position of the dropdown corresponding of the button
    - parameter button:  Button to which the dropdown will be aligned to
    */
    public func showWithAnimation(time: NSTimeInterval, options: Alignment, button: UIButton) {
        if (self.hidden) {
            refresh()
            height = self.TableMenu.frame.height
        }
        
        self.TableMenu.alpha = 0.0
        self.show(options, button: button)
        UIView.animateWithDuration(time, animations: {
            self.TableMenu.alpha = 1.0
        })
    }
    
    /**
    Hides the dropdown from the view
    */
    public func hide() {
        status = .Hidden
        self.hidden = true
        if shown == .Hidden {
            shown = .Shown
        }
    }
    
    /**
    Fades out and hides the dropdown from the view
    
    - parameter time: Time taken to fade out the dropdown
    */
    public func hideWithAnimation(time: NSTimeInterval) {
        UIView.animateWithDuration(time, delay: 0.0, options: .CurveEaseOut, animations: {
            self.TableMenu.alpha = 0.0
            }, completion: { finished in
                self.hide()
        })
    }
    
    /**
    Refresh the Tablemenu. For specifically calling .reloadData() on the TableView
    */
    public func refresh() {
        TableMenu.reloadData()
    }
    
    /**
    Refreshes the table view height
    */
    private func refreshHeight() {
        // Updates the height of the view depending on the amount of item
        let tempHeight: CGFloat = CGFloat(items.count) * TableMenu.rowHeight // Height of TableView
        if (tempHeight <= max_Height) { // Determines if tempHeight is greater then max height
            height = tempHeight
        } else {
            height = max_Height
        }
    }
    
    /**
    Find corresponding button to which the dropdown is aligned too
    
    - parameter subviews: All subviews of where the button is.
    - parameter button: Button to find
    
    - returns: Found button or nil
    */
    private func findButtonFromSubviews(subviews: [UIView], button: UIButton) -> UIView? {
        for subview in subviews {
            if (subview is UIButton && subview == button) {
                return button
            }
        }
        return nil
    }
}

extension Dropper: UITableViewDelegate, UITableViewDataSource, DropperExtentsions {
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! DropperCell
        // Sets up Cell
        // Removes image and text just in case the cell still contains the view
        cell.imageItem.removeFromSuperview()
        cell.textItem.removeFromSuperview()
        cell.last = items.count - 1  // Sets the last item to the cell
        cell.indexPath = indexPath // Sets index path to the cell
        cell.borderColor = border.color // Sets the border color for the seperator
        let item = items[indexPath.row]
        
        if let color = cellBackgroundColor {
            cell.backgroundColor = color
        }
        
        if let color = cellColor {
            cell.textItem.textColor = color
            cell.imageItem.tintColor = color
        }
        
        if let size = cellTextSize {
            cell.textItem.font = UIFont.systemFontOfSize(size)
        }
        
        if let image = toImage(item) { // Determines if item is an image or not
            cell.cellType = .Icon
            cell.imageItem.image = image
        } else {
            cell.cellType = .Text
            cell.textItem.text = item
        }
        
        return cell
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.DropperSelectedRow(indexPath, contents: items[indexPath.row])
        self.hideWithAnimation(defaultAnimationTime)
    }
}