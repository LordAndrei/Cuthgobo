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
    var food: [Localizable] = []
    var water: [Localizable] = []
    var population: [NSIndexPath: [WorldItems]] = [:]
    // Focumu: Food Cuthgobo Munch
    // Wacusi: Water Cuthgobo Sip
    
    func beBorn() {
        for _ in 1...3 {
            createWater()
        }
        for _ in 1...10 {
            growNewFood()
        }
        for _ in 1...initialBeings {
            createBeings()
        }
        updateLand()
        printWorld()
    }
    
    func newTurn() {
        turn += 1
        print("Wothcocu Day: \(turn)")
        for being in beings {
            being.doSomething()
        }
        updateLand()
        printWorld()
    }
    
    func clearLand() {
        for x in minSize..<maxSize {
            for y in minSize..<maxSize {
                let anIndexPath = NSIndexPath(row: x, section: y)
                population[anIndexPath] = []
            }
        }
    }
    
    func updateLand() {
        clearLand()
        for edible in food {
            let anIndexPath = NSIndexPath(row: Int(edible.location.x),
                                          section: Int(edible.location.y))
            population[anIndexPath] = [.focumu]
        }
        for drinkable in water {
            let anIndexPath = NSIndexPath(row: Int(drinkable.location.x),
                                          section: Int(drinkable.location.y))
            if population[anIndexPath] == nil {
                population[anIndexPath] = [.wacusi]
            } else {
                population[anIndexPath]!.append(.wacusi)
            }
        }
        for cuthgobo in beings {
            let anIndexPath = NSIndexPath(row: Int(cuthgobo.location.x),
                                          section: Int(cuthgobo.location.y))
            if population[anIndexPath] == nil {
                population[anIndexPath] = [.cuthgobo]
            } else {
                population[anIndexPath]!.append(.cuthgobo)
            }
        }
    }
    
    func createWater() {
        let (x,y) = getLocation()
        let aLocation = CGPoint(x: x, y: y)
        let aWacusi = Wacusi(location: aLocation)
        water.append(aWacusi)

        for xShift in -1...1 {
            for yShift in -1...1 {
                if x == 0 && y == 0 {
                    continue
                }
                if Int(arc4random()) % 3 == 0 {
                    continue
                } 
                if x + xShift < minSize{
                    continue
                }
                if y + yShift < minSize{
                    continue
                }
                if x + xShift >= maxSize{
                    continue
                }
                if y + yShift >= maxSize{
                    continue
                }
                let aLocation = CGPoint (x: x + xShift,
                                         y: y + yShift)
                let aWacusi = Wacusi(location: aLocation)
                
                water.append(aWacusi)
            }
        }
    }
    
    func growNewFood() {
        let (x,y) = getLocation()
        let aLocation = CGPoint(x: x, y: y)
        let aFocumu = Focumu(location: aLocation)
        food.append(aFocumu)
    }
    
    func createBeings() {
        let (x,y) = getLocation()
        let aLocation = CGPoint(x: x, y: y)
        let aCuthgobo = Cuthgobo.init()
        aCuthgobo.beBorn(whereBorn: aLocation)
        aCuthgobo.wothcocu = self
        beings.append(aCuthgobo)
    }
    
    func getLocation() -> (Int, Int) {
        let x = Int(arc4random()) % maxSize
        let y = Int(arc4random()) % maxSize
        return (x,y)
    }
    
    func isSafe(location: CGPoint) -> Bool {
        let x = Int(location.x)
        let y = Int(location.y)
        guard x >= minSize,
              x <= maxSize,
              y >= minSize,
              y <= maxSize
              else {
            return false
        }
        return true
    }

    
    /// Look turns information about the Cuthgobo into information about local available targets
    /// - Parameters:
    ///   - origin: Where the Cuthgobo is
    ///   - radius: How far it can see
    ///   - target: What it is going to
    /// - Returns: A List of [Direction, and Distance] to avaialbe targets
    func look(origin:CGPoint,
              radius:Int,
              target:WorldItems) -> [(CGPoint,Float)] {
        
        var potentials:[Localizable] = []
        var currentTargets:[(CGPoint, Float)] = []
        
        switch target {
        case .focumu:
            //get list of food
            potentials = food
            
        case .wacusi:
            //get list of water
            potentials = water
            
        case .cuthgobo:
            //get list off cuthgobo
            potentials = beings
            
        default:
            break
        }
        
        for aTarget in potentials {
            // Get distance between cuthgobo and a Target in coordinate(|x-y|,|x-y|)
            let distanceC = CGPoint(x:origin.x - aTarget.location.x,
                                    y:origin.y - aTarget.location.y)
            
            
            // convert distance to simple float. (3,4) -> 5.0
            let distanceF: Float = Float.squareRoot(
                Float(distanceC.x * distanceC.x) +
                    Float(distanceC.y * distanceC.y))()
            
            // make sure distance is within radius
            if distanceF <= Float(radius) {
                // get direction
                let dirX = convertToDirection(distance: distanceC.x)
                let dirY = convertToDirection(distance: distanceC.y)
                // add to output list
                currentTargets.append((CGPoint(x: dirX, y: dirY), distanceF))
            }
        }
        return currentTargets
    }
    
    func convertToDirection(distance: CGFloat) -> Int {
        // convert distanceC to a direction
        // if the number is negative then -1
        // if the number is positive then 1
        // if the number is zero... then... well.. zero
        let dist = Int(distance)
        var dir = 0
        if dist < 0 {
            dir = -1
        } else if dist > 0 {
            dir = 1
        }
        return dir
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

