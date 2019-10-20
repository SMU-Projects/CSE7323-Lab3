//
//  GameViewController.swift
//  Lab3
//
//  Created by Will Lacey on 10/20/19.
//  Copyright © 2019 Will Lacey. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setup game scene
        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView // the view in storyboard must be an SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }

    
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    


}
