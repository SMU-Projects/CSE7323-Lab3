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
    @IBOutlet weak var yesterdayLabel: UILabel!
    @IBOutlet weak var yesterdaySlider: UISlider!
    @IBOutlet weak var yesterdayFlagImage: UIImageView!
    
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var todaySlider: UISlider!
    @IBOutlet weak var todayFlagImage: UIImageView!
    
    @IBOutlet weak var currentActivityImage: UIImageView!
    
    //MARK: =====class variables=====
    let activityManager = CMMotionActivityManager()
    let pedometer = CMPedometer()
    let motion = CMMotionManager()
    let model = StepModel()
    
    var totalSteps: Float = 0.0 {
        willSet(newtotalSteps){
            DispatchQueue.main.async{
                self.todaySlider.setValue(newtotalSteps, animated: true)
                self.todayLabel.text = "Today's Steps: \(newtotalSteps)"
            }
        }
    }
    
    //MARK: =====View Lifecycle=====
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.yesterdaySlider.isEnabled = false
        self.todaySlider.isEnabled = false
        
        // TODO: Set up yesterday Steps
        let yesterdaySteps = self.getYesterdaySteps()
        let yesterdayGoal = self.model.getYesterdayGoal()
        self.yesterdaySlider.maximumValue = Float(yesterdayGoal)
        self.yesterdaySlider.value = StepViewController.clamp(val: Float(yesterdaySteps), leftBounds: 0, rightBounds: Float(yesterdayGoal))
        self.yesterdayLabel.text = "Yesterday's Steps: \(yesterdaySteps)"
        if (yesterdaySteps >= yesterdayGoal)
        {
            self.yesterdayFlagImage.image = UIImage(named:"flag_up.png")
        }
        
        self.totalSteps = 0.0
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
            self.totalSteps = steps.floatValue
        }
    }
    
    public func getYesterdaySteps() -> Int {
        
        return 100
    }
    
    public func getTodaySteps() -> Int {
        return 0
    }
    
    // MARK: =====Static Methods=====
    // Float Clamp Function
    static func clamp(val: Float, leftBounds:Float, rightBounds:Float) -> Float
    {
        if (val < leftBounds) {return leftBounds}
        if (val > rightBounds) {return rightBounds}
        return val
    }


}

