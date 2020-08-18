//
//  Cuthgobo.swift
//  Cuthgobo
//  Cuthgobo is a Cube that goes Boing
//
//  Created by Andrei Freeman on 8/13/20.
//

import Foundation
import UIKit

let worldMin = 0
let worldMax = 5

class Cuthgobo {
    var name: String = "Unnamed"
    var hunger: Float = 0.0
    var thirst: Float = 0.0
    var reproUrge: Float = 0.0
    var location: CGPoint = .zero
    var canGiveBirth: Bool = true
    var alive: Bool = false
    weak var wothcocu: Wothcocu?
    
    func doSomething() {
        guard alive else { return }
        if hunger <= 0 || thirst <= 0 {
            die()
        }
    }
    
    func beBorn(whereBorn: CGPoint) {
        alive = true
        hunger = 50.0
        thirst = 50.0
        reproUrge = 0.0
        location = whereBorn
        let birthable = Int(Date.timeIntervalSinceReferenceDate * 1000)
        if birthable % 2 == 0 {
            canGiveBirth = false
        }
        nameMe()
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
    
    func walk() {
        hunger += 1
        thirst += 1
        print("I walk")
        move(stepCount: 1)
    }
    
    func jump() {
        hunger += 3
        thirst += 3
        print("BOOOOOOING")
        move(stepCount: 3)
    }
    
    func move(stepCount:Int) {
        print("I was at: x:\(location.x), y:\(location.y)")
        var xMotion = 0 ; var yMotion = 0
        repeat {
            xMotion = Int(arc4random() % 3) - 1
            yMotion = Int(arc4random() % 3) - 1
        } while xMotion == 0 && yMotion == 0
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
        let x = Int(location.x)
        let y = Int(location.y)
        guard x >= worldMin,
              x <= worldMax,
              y >= worldMin,
              y <= worldMax
              else {
            return false
        }
        return true
    }
    
    func eat() {
        hunger -= 20
        print ("nom nom, now I am only \(hunger)% hungry")
    }
    
    func drink() {
        thirst -= 20
        print ("slurp, now I am only \(thirst)% thirsty")
    }
    
    func look() {}
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
