//
//  DropdownExtensions.swift
//  Pods
//
//  Created by Ozzie Kirkby on 2015-10-10.
//
//

import UIKit

internal protocol DropperExtentsions {
    func toImage(_ name: String) -> UIImage?
}

internal extension DropperExtentsions {
    /**
    Finds image from passed String and returns the UIImage
    
    @param: (name: String)
    @return: UIImage or Nil depending on if image is found
    */
    internal func toImage(_ name: String) -> UIImage? {
        if let image = UIImage(named: name) {
            return image
        }
        return nil
    }
}
