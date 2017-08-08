//
//  SpinerLayer.swift
//  swiftTEST
//
//  Created by 鹏程 on 17/8/3.
//  Copyright © 2017年 CPC-Coder. All rights reserved.
//

import UIKit

class SpinerLayer: CAShapeLayer {

    
    init(frame: CGRect) {
        super.init()
        let radius = frame.height / 4;
        self.frame = CGRect(x: 0, y: 0, width: frame.height, height: frame.height)
        let  center = CGPoint(x: frame.height/2, y: bounds.midY)
        let startAngle =  -(CGFloat)(M_PI_2);
        let endAngle = CGFloat(M_PI_2 * 2 - M_PI_2);
        let clockwise = true;
        
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        self.path = path.cgPath
        self.fillColor = nil;
        self.strokeColor = UIColor.white.cgColor
        self.lineWidth = 1
        self.strokeEnd = 0.4
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func beginAnimation(){
        isHidden = false
        let rotate = CABasicAnimation(keyPath: "transform.rotation.z")
        rotate.fromValue = 0;
        rotate.toValue = M_PI * 2
        rotate.duration = 0.4;
        rotate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        rotate.repeatCount = MAXFLOAT
        rotate.fillMode = kCAFillModeForwards
        rotate.isRemovedOnCompletion = false
        add(rotate, forKey: rotate.keyPath)
    }
    

    func stopAnimation() -> () {
        isHidden = true
        removeAllAnimations()
    }
    
    
    

}

