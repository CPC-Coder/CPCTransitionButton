//
//  CPCLoginBtn.swift
//  swiftTEST
//
//  Created by 鹏程 on 17/8/3.
//  Copyright © 2017年 CPC-Coder. All rights reserved.
//

import UIKit


public typealias LoginBtnCompletionClosure = ()->()

open class CPCLoginBtn: UIButton {
    
    open var expandDuration : TimeInterval = 0.3
    open var shrinkDuration : TimeInterval = 0.1
    open var errorColor : UIColor = UIColor.red
    
    fileprivate lazy var spinner: SpinerLayer = {
        let s = SpinerLayer(frame: self.frame)
        
        return s
    }()
    fileprivate var successComplection : LoginBtnCompletionClosure?
    fileprivate var failComplection : LoginBtnCompletionClosure?
    fileprivate var shrinkCurve : CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    fileprivate var expandCurve : CAMediaTimingFunction = CAMediaTimingFunction(controlPoints: 0.95, 0.02, 1, 0.05)
    fileprivate var defaultBGcolor : UIColor?
    
    

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        //fatalError("init(coder:) has not been implemented")
    }
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    
}

//MARK: - *** UI ***
private extension CPCLoginBtn{
    
    func setupUI(){
        
        self.layer.addSublayer(spinner)
        
        layer.cornerRadius = bounds.height/2
        layer.masksToBounds  = true
        
        
        addTarget(self, action: #selector(CPCLoginBtn.scaleToSmall), for: [.touchDown,.touchDragEnter])
        addTarget(self, action: #selector(CPCLoginBtn.scaleAnimation), for: .touchUpInside)
        addTarget(self, action: #selector(CPCLoginBtn.scaleToDefault), for: .touchDragExit)
    }
    
    
}

//MARK: - *** 公开方法 ***
public extension CPCLoginBtn{
    
    
    func succeedAnimation(completion:LoginBtnCompletionClosure?){
        
        
        
        //
        successComplection = completion
        
        //
        spinner.stopAnimation()
        
        //放大
        let  expandAnim = CABasicAnimation(keyPath: "transform.scale")
        expandAnim.fromValue = 1
        expandAnim.toValue = 33
        expandAnim.duration = expandDuration
        expandAnim.timingFunction = expandCurve
        expandAnim.fillMode = kCAFillModeForwards
        expandAnim.isRemovedOnCompletion = false
        expandAnim.delegate = self
        layer.add(expandAnim, forKey: expandAnim.keyPath)
        
        
        
    }
    
    
    func failedAnimation(completion:LoginBtnCompletionClosure?){
        
        
        
        
        failComplection = completion
        
        //
        self.spinner.stopAnimation()
        
        //背景色动画
        defaultBGcolor = self.backgroundColor
        
        let  backgroundColor = CABasicAnimation(keyPath: "backgroundColor")
        backgroundColor.toValue = errorColor.cgColor
        backgroundColor.duration = 0.1
        backgroundColor.timingFunction = shrinkCurve
        backgroundColor.fillMode = kCAFillModeForwards
        backgroundColor.isRemovedOnCompletion = false
        layer.add(backgroundColor, forKey: backgroundColor.keyPath)
        
        //变长形变动画
        let  shrinkAnim = CABasicAnimation(keyPath: "bounds.size.width")
        shrinkAnim.fromValue = bounds.height
        shrinkAnim.toValue = bounds.width
        shrinkAnim.duration = shrinkDuration
        shrinkAnim.timingFunction = shrinkCurve
        shrinkAnim.fillMode = kCAFillModeForwards
        shrinkAnim.isRemovedOnCompletion = false
        layer.add(shrinkAnim, forKey: shrinkAnim.keyPath)
        
        
        
        
        
        

        
        
        //创建关键帧动画
        let kfa = CAKeyframeAnimation(keyPath: "position"
        )
        let point = layer.position
        let smallP = CGPoint(x: point.x-10, y: point.y)
        let bigP = CGPoint(x: point.x+10, y: point.y)
        let arr = [point,smallP,bigP,smallP,bigP,smallP,bigP,point]
        kfa.values = arr
        kfa.duration = 0.5
        kfa.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        layer.position = point
        
        
        
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+shrinkDuration) {
            
            self.layer.add(kfa, forKey: kfa.keyPath)
            self.isUserInteractionEnabled = true
            completion?()
        }
        
        
        
        
        
        
        
        

 

    }
    
    
    

    

    
    
    
    
    
}

//MARK: - *** 事件 ***
private extension CPCLoginBtn{
    @objc func scaleToSmall(){
        
        transform = CGAffineTransform(scaleX: 1, y: 1)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .layoutSubviews, animations: {[unowned self] in
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
            }, completion: nil)
        
    }
    
    
    @objc func scaleAnimation(){
        
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .layoutSubviews, animations: {[unowned self] in
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            }, completion: nil)
        
        beginAnimation()
        
    }
    
    @objc func scaleToDefault(){
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.4, options: .layoutSubviews, animations: {[unowned self] in
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
            
            }, completion: nil)
        
    }
    func beginAnimation(){
        
        
        //添加弧线layer
        
        spinner.beginAnimation()
        
        //背景色
        if let defaultBG = self.defaultBGcolor{
            
            let  backgroundColor = CABasicAnimation(keyPath: "backgroundColor")
            backgroundColor.toValue = defaultBG.cgColor
            backgroundColor.duration = 0.1
            backgroundColor.timingFunction = shrinkCurve
            backgroundColor.fillMode = kCAFillModeForwards
            backgroundColor.isRemovedOnCompletion = false
            layer.add(backgroundColor, forKey: backgroundColor.keyPath)
            
            
        }
        
        
        
        
       

        
        
        //收缩 成 圆形
        let  shrinkAnim = CABasicAnimation(keyPath: "bounds.size.width")
        shrinkAnim.fromValue = bounds.width
        shrinkAnim.toValue = bounds.height
        shrinkAnim.duration = shrinkDuration
        shrinkAnim.timingFunction = shrinkCurve
        shrinkAnim.fillMode = kCAFillModeForwards
        shrinkAnim.isRemovedOnCompletion = false
        layer.add(shrinkAnim, forKey: shrinkAnim.keyPath)
        
        // [_spinerLayer beginAnimation];
        isUserInteractionEnabled = false
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}








//MARK: - *** CAAnimationDelegate ***
extension CPCLoginBtn:CAAnimationDelegate{
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        
        let cab = anim as! CABasicAnimation
        if cab.keyPath == "transform.scale" {
            
            isUserInteractionEnabled = true
            successComplection?()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) { [weak self] in
                self?.layer.removeAllAnimations()
            }
            
        }
        
        
        
        
        
    }
    
    
}




