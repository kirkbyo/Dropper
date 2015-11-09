//
//  ViewController.swift
//  Dropper
//
//  Created by kirkbyo on 11/06/2015.
//  Copyright (c) 2015 kirkbyo. All rights reserved.
//

import UIKit
import Dropper

class ViewController: UIViewController {
    let dropper = Dropper(width: 75, height: 200)
    @IBOutlet var dropdown: UIButton!
    
    @IBOutlet weak var shortDropdown: UIButton!
    
    @IBOutlet weak var selectedLabel: UILabel!
    
    override func viewDidLoad() {
        
//        uncomment to test when maxHeight has been set
//        dropper.maxHeight = 200
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func DropdownAction() {
        if dropper.status == .Hidden {
            dropper.items = ["Item 1", "Item 2", "circle.png", "Item 3", "Item 4", "Item 5","Item 1", "Item 2", "circle.png", "Item 3", "Item 4", "Item 5","Item 1", "Item 2", "circle.png", "Item 3", "Item 4", "Item 5","Item 1", "Item 2", "circle.png", "Item 3", "Item 4", "Item 5","Item 1", "Item 2", "circle.png", "Item 3", "Item 4", "Item 5","Item 1", "Item 2", "circle.png", "Item 3", "Item 4", "Item 5"]
            dropper.theme = Dropper.Themes.White
            dropper.delegate = self
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, button: dropdown)
        } else {
            dropper.hideWithAnimation(0.1)
        }
    }
    
    @IBAction func ShortDropdownAction() {
        if dropper.status == .Hidden {
            dropper.items = ["Larger, Longer, Item 1"]
            dropper.theme = Dropper.Themes.White
            dropper.delegate = self
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, button: shortDropdown)
        } else {
            dropper.hideWithAnimation(0.1)
        }
    }
}

extension ViewController: DropperDelegate {
    func DropperSelectedRow(path: NSIndexPath, contents: String) {
        selectedLabel.text = "Selected Row: \(contents)"
    }
}
