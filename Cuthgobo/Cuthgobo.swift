//
//  Cuthgobo.swift
//  Cuthgobo
//  Cuthgobo is a Cube that goes Boing
//
//  Created by Andrei Freeman on 8/13/20.
//

import Foundation
import UIKit

enum CuthgoboState: String {
    case hungry
    case thirsty
    case needy
}

class Cuthgobo: Movable {
    // MARK: - Localizable
    var canMove = true
    var itemType: WorldItems = .cuthgobo
    var location: CGPoint = .zero

    var sightRadius = 2
    var name: String = "Unnamed"
    var hunger: Float = 0.0
    var thirst: Float = 0.0
    var reproUrge: Float = 0.0
    var canGiveBirth: Bool = true
    var alive: Bool = false
    var currentState: CuthgoboState = .thirsty
    weak var wothcocu: Wothcocu!
    
    func doSomething() {
        guard alive else { return }
        if hunger <= 0 || thirst <= 0 {
            die()
        }
        currentState = myPriority()

        // ask world what is within sensory radius.
        let viableTargets = wothcocu.look(origin: self.location,
                                          radius: sightRadius,
                                          target: targetForPriority())

        // get direction of closest target
        let sortedTargets = viableTargets.sorted { (item1, item2) -> Bool in
            item1.distance > item2.distance
        }
        
        // if result == nil move randomly
        // else move to target

        // for now we're randomly going to walk or 1 in 4 chance jump.
        let random = Int(arc4random()) % 4
        if random != 0 {
            walkRandomly()
        } else {
            jumpRandomly()
        }
    }
    
    func myPriority() -> CuthgoboState {// Some State
        var state: CuthgoboState = .thirsty
        
        if hunger > thirst {
            state = .hungry
        }
        
        if reproUrge > hunger {
            state = .needy
        }
        print("\(name) is \(state)")
        return state
    }
    
    func targetForPriority() -> WorldItems {
        return Cuthgobo.targetForPriority(priority: currentState)
    }
    
    static func targetForPriority(priority: CuthgoboState) -> WorldItems {
        var returnTarget: WorldItems = .empty
        
        switch priority {
        case .hungry:
            returnTarget = .focumu
        
        case .thirsty:
            returnTarget = .wacusi
        
        case .needy:
            returnTarget = .cuthgobo
        }
        return returnTarget
    }
    
    func beBorn(whereBorn: CGPoint) {
        alive = true
        hunger = 50.0
        thirst = 50.0
        reproUrge = 0.0
        location = whereBorn
        let birthable = Int(arc4random())
        if birthable % 2 == 0 {
            canGiveBirth = false
        }
        nameMe()
        identifyYourself()
    }
    
    func nameMe() {
        let consonant = "BCDFGHJKLMNPRSTVWZ"
        let vowel = "AEIOUY"
        name = ""
        
        var random = Int(arc4random()) % consonant.count
        var index = consonant.index(consonant.startIndex, offsetBy: random)
        name += consonant[index...index]
        
        random = Int(arc4random()) % vowel.count
        index = vowel.index(consonant.startIndex, offsetBy: random)
        name += vowel[index...index]
        
        random = Int(arc4random()) % consonant.count
        index = consonant.index(consonant.startIndex, offsetBy: random)
        name += consonant[index...index]
        
        name += "\(Int(arc4random()) % 10)"
        name += "\(Int(arc4random()) % 10)"
        name += "\(Int(arc4random()) % 10)"
    }

    // MARK: - Movement
    func walkRandomly() {
        hunger += 1
        thirst += 1
        print("I walk")
        moveRandomly(stepCount: 1)
    }
    
    func jumpRandomly() {
        hunger += 3
        thirst += 3
        print("BOOOOOOING")
        moveRandomly(stepCount: 3)
    }
    
    func moveRandomly(stepCount:Int) {
        var xMotion = 0 ; var yMotion = 0
        repeat {
            xMotion = Int(arc4random() % 3) - 1
            yMotion = Int(arc4random() % 3) - 1
        } while xMotion == 0 && yMotion == 0
        move(stepCount: stepCount, xDirection: xMotion, yDirection: yMotion)
    }
    
    func move(stepCount: Int, xDirection: Int, yDirection: Int) {
        guard xDirection >= -1,
              xDirection <= 1,
              yDirection >= -1,
              yDirection <= 1 else {
            print("Error: Can not move in direction: (\(xDirection),\(yDirection))")
            return
        }
        
        print("I was at: x:\(location.x), y:\(location.y)")
        print("I'm moving \(stepCount) spaces in direction (\(xDirection),\(yDirection))")
        var xMotion = xDirection
        var yMotion = yDirection
        xMotion *= stepCount
        yMotion *= stepCount
        location = CGPoint(x: Int(location.x) + xMotion, y: Int(location.y) + yMotion)
        print("Now I'm at: x:\(location.x), y:\(location.y)")
        if !isSafe() {
            print("I have fallen off the world!")
            die()
        }
    }
    
    func isSafe() -> Bool {
        return wothcocu.isSafe(location: location)
    }
    
    func eat() {
        hunger -= 20
        print ("nom nom, now I am only \(hunger)% hungry")
    }
    
    func drink() {
        thirst -= 20
        print ("slurp, now I am only \(thirst)% thirsty")
    }
        
    func reproduce() {}
    
    func die() {
        print("I AM DEAD")
        alive = false
    }
    
    func identifyYourself() {
        if alive {
            print("Hi, I am a Cuthgobo!")
            print("My name is \(name)")
            print("I am \(hunger)% hungry")
            print("I am \(thirst)% thirsty")
            print("I am \(reproUrge)% in need of a mate")
            print("I am at x:\(location.x), y:\(location.y)")
            print("I can\(canGiveBirth ? "" : " not") give birth\r\r")
        }
    }
}
