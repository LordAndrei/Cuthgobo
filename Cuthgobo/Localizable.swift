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
    var canMove: Bool {get set}
    var itemType: WorldItems {get}
}

public protocol Movable: Localizable {
    func move()
}
