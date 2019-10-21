//
//  GoalViewController.swift
//  Lab3
//
//  Created by Will Lacey on 10/20/19.
//  Copyright © 2019 Will Lacey. All rights reserved.
//

import UIKit

class GoalViewController: UIViewController {

    @IBOutlet weak var last24HourGoalLabel: UILabel!
    @IBOutlet weak var last24HourGoalSlider: UISlider!
    @IBOutlet weak var last48HourGoalLabel: UILabel!
    @IBOutlet weak var last48HourGoalSlider: UISlider!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func last24HourGoalSliderAction(_ sender: Any) {
        self.last24HourGoalLabel.text = "Today's Goal: \(self.last24HourGoalSlider.value) Steps"
    }
    
    @IBAction func last48HourGoalSliderAction(_ sender: Any) {
        self.last48HourGoalLabel.text = "Yesterday's Goal: \(self.last48HourGoalSlider.value) Steps"
    }
    @IBAction func enterButtonPressed(_ sender: Any) {
        StepModel.setLast24HourGoal(goal:self.last24HourGoalSlider.value)
        StepModel.setLast48HourGoal(goal:self.last48HourGoalSlider.value)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
