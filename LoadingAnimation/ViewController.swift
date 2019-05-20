//
//  ViewController.swift
//  LoadingAnimation
//
//  Created by Isaac Raval on 5/19/19.
//  Copyright © 2019 Isaac Raval. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup Core Animation Replicator to make 3 copies of given shape later on
        let replicator = CAReplicatorLayer()
        replicator.instanceCount = 3
        
        //Define shape and color
        let square = CALayer()
        square.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        square.backgroundColor = UIColor.blue.cgColor
        
        //Define the Core Animation Path
        let path = CGMutablePath()
        path.addRoundedRect(in: square.bounds, cornerWidth: 1, cornerHeight: 1)
        
        //Animate shrinking and growing
        let animationResize = CABasicAnimation(keyPath: "transform.scale")
        animationResize.duration = 2
        animationResize.fromValue = 1
        animationResize.toValue = 0.4
        animationResize.autoreverses = true
        animationResize.repeatCount = .infinity
        square.add(animationResize, forKey: "hypnoscale")

        //Animate slow color fade and sudden reappearance
        let animationTintChange = CABasicAnimation(keyPath: "backgroundColor")
        animationTintChange.duration = 5
        animationTintChange.isAdditive = true
        animationTintChange.fromValue = UIColor.blue.cgColor
        animationTintChange.toValue = UIColor.gray.cgColor
        animationTintChange.repeatCount = .infinity
        square.add(animationTintChange, forKey: "backgroundColor")
        
        //Animate moving toward the upper left hand corner of the screen and moving back
        let rotationPoint = CGPoint(x: square.frame.width / 2.0, y: square.frame.height / 2.0) // Define a point to rotate around
        let anchorPoint = CGPoint(x: (rotationPoint.x - square.frame.minX) / square.frame.width, y: (rotationPoint.y - square.frame.minY) / square.frame.height)
        square.anchorPoint = anchorPoint;
        square.position = rotationPoint;
        
        //Replicate the square 3 times and start their respective animations at different times
        let delay = TimeInterval(2) //Configuration 1
        /*let delay = TimeInterval(0.4) //Configuration 2 (for other effect) */
        replicator.instanceDelay = delay
        replicator.addSublayer(square) //Add square to replicator for duplication
        replicator.instanceTransform = CATransform3DMakeTranslation(70, 0, 0) //Move each copy of the square by specified amount from previous square
        replicator.instanceBlueOffset = -0.5 //Make each copy of the square less blue than the previous upon duplication
        
        view.layer.addSublayer(replicator) //Add the replicator's processes (the squares and their animations) to the view
    }
}
