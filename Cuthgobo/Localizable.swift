//
//  Localizable.swift
//  Cuthgobo
//
//  Created by Andrei Freeman on 8/15/20.
//

import Foundation
import UIKit

public protocol Localizable {
    var location: CGPoint {get set}
    var canMove: Bool {get}
    var itemType: WorldItems {get}
}

public protocol Movable: Localizable {
    func move(stepCount: Int, xDirection: Int, yDirection: Int)
}

struct Focumu: Localizable {
    var location: CGPoint
    var canMove = false
    var itemType: WorldItems = .focumu
}

struct Wacusi: Localizable {
    var location: CGPoint
    var canMove = false
    var itemType: WorldItems = .wacusi
}
