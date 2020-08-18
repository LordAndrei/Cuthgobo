//
//  Wothcocu.swift
//  Cuthgobo
//  Wothcocu is a World that contains Cuthgobos a.k.a cubes that go boing
//
//  Created by Aiden Freeman on 8/14/20.
//

import Foundation
import UIKit // For CGPoint

enum WorldItems {
    case cuthgobo
    case focumu
    case wacusi
    case empty
}

class Wothcocu {
    let minSize = 0
    let maxSize = 10
    var turn = 0
    
    var beings: [Cuthgobo] = []
    var population: [NSIndexPath: [WorldItems]] = [:]
    // Focumu: Food Cuthgobo Munch
    // Wacusi: Water Cuthgono Sip
    
    func beBorn() {
        createWater()
        for _ in 1...2 {
            growNewFood()
        }
        createBeings()
    }
    
    func newTurn() {
        for being in beings {
            being.doSomething()
        }
    }
    
    func createWater() {}
    func growNewFood() {}
    func createBeings() {}
}

