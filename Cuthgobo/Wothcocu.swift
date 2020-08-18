//
//  Wothcocu.swift
//  Cuthgobo
//  Wothcocu is a World that contains Cuthgobos a.k.a cubes that go boing
//
//  Created by Aiden Freeman on 8/14/20.
//

import Foundation
import UIKit // For CGPoint

public enum WorldItems {
    case cuthgobo
    case focumu
    case wacusi
    case empty
}

class Wothcocu {
    let minSize = 0
    let maxSize = 10
    let initialBeings = 5
    var turn = 0
    
    var beings: [Cuthgobo] = []
    var population: [NSIndexPath: [WorldItems]] = [:]
    // Focumu: Food Cuthgobo Munch
    // Wacusi: Water Cuthgono Sip
    
    func beBorn() {
        createWater()
        for _ in 1...10 {
            growNewFood()
        }
        createBeings()
        printWorld()
    }
    
    func newTurn() {
        turn += 1
        print("Wothcocu Day: \(turn)")
        for being in beings {
            being.doSomething()
        }
    }
    
    func createWater() {}
    func growNewFood() {}
    
    func createBeings() {
        for _ in 1...initialBeings {
            let (x,y) = getLocation()
            let aLocation = CGPoint(x: x, y: y)
            let anIndexPath = NSIndexPath(row: x, section: y)
            let aCuthgobo = Cuthgobo.init()
            aCuthgobo.beBorn(whereBorn: aLocation)
            population[anIndexPath] = [.cuthgobo]
        }
    }
    
    func getLocation() -> (Int, Int) {
        let x = Int(arc4random()) % maxSize
        let y = Int(arc4random()) % maxSize
        return (x,y)
    }
    
    func printWorld() {
        for y in minSize..<maxSize {
            var printString: [String] = ["","","","",""]
            for x in minSize..<maxSize {
                let anIndexPath = NSIndexPath(row: x, section: y)
                let localPopulation = population[anIndexPath]
                printString[0] += "+-------"
                printString[1] += "|       "
                printString[2] += "| "
                printString[3] += "| (\(x),\(y)) "
                if localPopulation != nil {
                    if localPopulation!.contains(.cuthgobo) {
                        printString[2] += "C "
                    } else {
                        printString[2] += "  "
                    }
                    if localPopulation!.contains(.focumu) {
                        printString[2] += "F "
                    } else {
                        printString[2] += "  "
                    }
                    if localPopulation!.contains(.wacusi) {
                        printString[2] += "W "
                    } else {
                        printString[2] += "  "
                    }
                } else {
                    printString[2] += "      "
                }
            }
            printString[0] += "+"
            printString[1] += "|"
            printString[2] += "|"
            printString[3] += "|"
            for index in 0...3 {
                print(printString[index])
            }
        }
        var baseString = ""
        for _ in 0..<maxSize {
            baseString += "+-------"
        }
        baseString += "+"
        print(baseString)
    }
}

