//
//  StepViewController.swift
//  Lab3
//
//  Created by Will Lacey on 10/20/19.
//  Copyright © 2019 Will Lacey. All rights reserved.
//

import UIKit
import CoreMotion

class StepViewController: UIViewController {
    
    //MARK: =====UI Elements=====
    @IBOutlet weak var last48HourLabel: UILabel!
    @IBOutlet weak var last48HourSlider: UISlider!
    @IBOutlet weak var last48HourFlagImage: UIImageView!
    
    @IBOutlet weak var last24HourLabel: UILabel!
    @IBOutlet weak var last24HourSlider: UISlider!
    @IBOutlet weak var last24HourFlagImage: UIImageView!
    
    @IBOutlet weak var currentActivityImage: UIImageView!
    
    //MARK: =====class variables=====
    let activityManager = CMMotionActivityManager()
    let pedometer = CMPedometer()
    let motion = CMMotionManager()
    
    var last24HourSteps: Float = 0.0 {
        willSet(newlast24HourSteps){
            DispatchQueue.main.async{
                self.last24HourLabel.text = "Today, you walked \(newlast24HourSteps) steps!"
                self.last24HourSlider.setValue(newlast24HourSteps, animated: true)
                if (Float(StepModel.getLast24HourGoal()) < newlast24HourSteps)
                {
                    self.last24HourFlagImage.image = UIImage(named:"flag_up.png")
                }
                else
                {
                    self.last24HourFlagImage.image = UIImage(named:"flag_down.png")
                }
            }
        }
    }
    
    var last48HourSteps: Float = 0.0 {
        willSet(newlast48HourSteps){
            DispatchQueue.main.async{
                self.last48HourLabel.text = "Yesterday, you walked \(newlast48HourSteps) steps!"
                self.last48HourSlider.setValue(newlast48HourSteps, animated: true)
                if (Float(StepModel.getLast48HourGoal()) < newlast48HourSteps)
                {
                   self.last48HourFlagImage.image = UIImage(named:"flag_up.png")
                }
                else
                {
                    self.last48HourFlagImage.image = UIImage(named:"flag_down.png")
                }
            }
        }
    }
    
    //MARK: =====View Lifecycle=====
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.last24HourSlider.maximumValue = Float(StepModel.getLast24HourGoal())
        self.last48HourSlider.maximumValue = Float(StepModel.getLast48HourGoal())
        self.last48HourSlider.isEnabled = false
        self.last24HourSlider.isEnabled = false
        self.getLast24HourSteps()
        self.getLast48HourSteps()
        self.startActivityMonitoring()
        self.startPedometerMonitoring()
    }
    
    // MARK: =====Activity Methods=====
    func startActivityMonitoring(){
        // is activity is available
        if CMMotionActivityManager.isActivityAvailable(){
            // update from this queue (should we use the MAIN queue here??.... )
            self.activityManager.startActivityUpdates(to: OperationQueue.init(), withHandler: self.handleActivity)
        }
        
    }
    
    func handleActivity(_ activity:CMMotionActivity?)->Void{
        // unwrap the activity and disp
        if let unwrappedActivity = activity {
            DispatchQueue.main.async{
                if(unwrappedActivity.stationary) {self.currentActivityImage.image = UIImage(named:"still.png")}
                else if (unwrappedActivity.walking) {self.currentActivityImage.image = UIImage(named:"walking.png")}
                else if (unwrappedActivity.running) {self.currentActivityImage.image = UIImage(named:"running.png")}
                else if (unwrappedActivity.cycling) {self.currentActivityImage.image = UIImage(named:"cycling.png")}
                else if (unwrappedActivity.automotive) {self.currentActivityImage.image = UIImage(named:"driving.png")}
                else {
                    NSLog("Unknown Activity Action")
                }
            }
        }
    }
    
    // MARK: =====Pedometer Methods=====
    func startPedometerMonitoring(){
        //separate out the handler for better readability
        if CMPedometer.isStepCountingAvailable(){
            pedometer.startUpdates(from: Date(),
                                   withHandler: handlePedometer)
        }
    }
    
    //ped handler
    func handlePedometer(_ pedData:CMPedometerData?, error:Error?)->(){
        if let steps = pedData?.numberOfSteps {
            self.last24HourSteps += steps.floatValue
        }
    }
    
    public func getLast24HourSteps(){
        let now = Date()
        let last24Hours = now.addingTimeInterval(-60*60*24)
        self.pedometer.queryPedometerData(from: last24Hours, to: now, withHandler: handleLast24HourPedometer)
    }
    
    func handleLast24HourPedometer(_ pedData:CMPedometerData?, error:Error?)->(){
        if let steps = pedData?.numberOfSteps {
            self.last24HourSteps = steps.floatValue
        }
    }
    
    public func getLast48HourSteps(){
        
        let now = Date()
        let last24Hours = now.addingTimeInterval(-60*60*24)
        let last48Hours = last24Hours.addingTimeInterval(-60*60*24)
        self.pedometer.queryPedometerData(from: last48Hours, to: last24Hours, withHandler: handleLast48HourPedometer)
    }
    
    func handleLast48HourPedometer(_ pedData:CMPedometerData?, error:Error?)->(){
        if let steps = pedData?.numberOfSteps {
            self.last48HourSteps = steps.floatValue
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let value = (self.last24HourSteps - StepModel.getLast24HourGoal())/100
        if (value < 0)
        {
            StepModel.setLives(lives:0)
        }
        else
        {
            StepModel.setLives(lives:Int(value)+1)
        }
        
    }
}

