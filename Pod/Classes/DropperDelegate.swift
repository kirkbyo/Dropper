//
//  DropperDelegate.swift
//  Pods
//
//  Created by Ozzie Kirkby on 2016-05-14.
//
//

import Foundation

public protocol DropperDelegate {
    func DropperSelectedRow(path: NSIndexPath, contents: String)
    func DropperSelectedRow(path: NSIndexPath, contents: String, tag: Int)
}

public extension DropperDelegate {
    func DropperSelectedRow(path: NSIndexPath, contents: String) {}
    func DropperSelectedRow(path: NSIndexPath, contents: String, tag: Int) {}
}