//
//  ViewController.swift
//  demo
//
//  Created by 鹏程 on 17/8/3.
//  Copyright © 2017年 鹏程. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate lazy var bgV : UIImageView = UIImageView()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bgV.frame = view.frame
        bgV.image = UIImage(named: "login")
        
        view.insertSubview(bgV, at: 0)
    }
    fileprivate lazy var swi : UISwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = CPCLoginBtn(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width - 64, height: 44))
        btn.setTitle("登陆", for: .normal)
        btn.backgroundColor = UIColor.green
        btn.addTarget(self, action: #selector(click), for: .touchUpInside)
        
        view.addSubview(btn)
        
        
        swi.frame = CGRect(x: 0, y: 300, width: 0, height: 0)
        swi.sizeToFit()
        swi.addTarget(self, action: #selector(siwClick), for: .valueChanged)
        view.addSubview(swi)
    }
    
    func siwClick(swi: UISwitch){
        
        swi.isOn = !swi.isOn
    }
    func click(btn:CPCLoginBtn){
        
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
            
            if self.swi.isOn {
                btn.succeedAnimation(completion: {
                    let secondVC = SecondViewController()
                    secondVC.transitioningDelegate = self
                    print("成功")
                    self.present(secondVC, animated: true, completion: nil)
                })
            } else {
                btn.failedAnimation(completion: {
                    print("失败")
                })
            }
            
            
            
            
            
        }
        
        
        
    }
    
    
}



extension ViewController : UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeInAnimator(transitionDuration: 0.5, startingAlpha: 0.8)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeInAnimator(transitionDuration: 0.5, startingAlpha: 0.8)
    }
}


