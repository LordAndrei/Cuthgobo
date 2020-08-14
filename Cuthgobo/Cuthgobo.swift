//
//  Cuthgobo.swift
//  Cuthgobo
//
//  Created by Andrei Freeman on 8/13/20.
//

import Foundation
import UIKit

class Cuthgobo {
    var hunger: Float = 0.0
    var thirst: Float = 0.0
    var reproUrge: Float = 0.0
    var location: CGPoint = .zero
    var canGiveBirth: Bool = true
    
    func doSomething() {
        if hunger == 0 || thirst == 0 {
            die()
        }
    }
    func beBorn(whereBorn: CGPoint) {
        hunger = 50.0
        thirst = 50.0
        reproUrge = 0.0
        location = whereBorn
        let birthable = Int(Date.timeIntervalSinceReferenceDate)
        if birthable % 2 == 0 {
            canGiveBirth = false
        }
    }
    func walk() {
        hunger += 1
        thirst += 1
        move(stepCount: 1)
        print("i move")
    }
    func jump() {
        hunger += 3
        thirst += 3
        move(stepCount: 3)
        print("BOOOOOOING")
    }
    func move(stepCount:Int) {
    }
    func eat() {
        hunger -= 20
        print ("nom nom now i am only \(hunger)% hungry")
    }
    func drink() {
        thirst -= 20
        print ("slurp now i am only \(thirst)% thirsty")
    }
    func look() {}
    func reproduce() {}
    func die() {
        print("I AM DEAD")
    }
    func identifyYourself() {
        print("Hi, I am a Cuthgobo!")
        print("I am \(hunger)% hungry")
        print("I am \(thirst)% thirsty")
        print("I am \(reproUrge)% in need of a mate")
        print("I am at x:\(location.x), y:\(location.y), ")
        print("I can\(canGiveBirth ? "" : " not") give birth")
    }
}
