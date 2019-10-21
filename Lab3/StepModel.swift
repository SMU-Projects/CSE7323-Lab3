//
//  StepModel.swift
//  Lab3
//
//  Created by Will Lacey on 10/20/19.
//  Copyright © 2019 Will Lacey. All rights reserved.
//

import UIKit

class StepModel: NSObject {
    
    static public func getLast24HourGoal() -> Float {
        
        let defaults = UserDefaults.standard
        let goal = defaults.float(forKey: "24HourGoal")
        return goal
    }
    
    static public func setLast24HourGoal(goal:Float) {
        
        let defaults = UserDefaults.standard
        defaults.set(goal, forKey: "24HourGoal")
    }
    
    static public func getLast48HourGoal() -> Float {
        
        let defaults = UserDefaults.standard
        let goal = defaults.float(forKey: "48HourGoal")
        return goal
    }
    
    static public func setLast48HourGoal(goal:Float) {
        
        let defaults = UserDefaults.standard
        defaults.set(goal, forKey: "48HourGoal")
    }
    
    static public func getLives() -> Int {
        
        let defaults = UserDefaults.standard
        let lives = defaults.integer(forKey: "lives")
        return lives
    }
    
    static public func setLives(lives:Int) {
        
        let defaults = UserDefaults.standard
        defaults.set(lives, forKey: "lives")
    }

}
