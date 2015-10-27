//
//  SupraCell.swift
//  ___PROJECTNAME___
//
//  Created by Richard Fox on 10/18/15.
//  Copyright © 2015 OpenSource. All rights reserved.
//

import UIKit


let kThresholdMin:CGFloat = 12
let kThrsholdMax:CGFloat  = 22
let kLockSlack:CGFloat    = 100


extension UITableView {
    func useCell(identifier:String){
        let nib = UINib(nibName: identifier, bundle: nil)
        self.registerNib(nib, forCellReuseIdentifier: identifier)
    }
}


enum FitStyle {
    case Fixed, Flex, Spaced
}

enum LockLocation{
    case Left, Center, Right
    
    func adjust(pos:CGFloat) -> CGFloat{
        switch self{
        case .Left,.Right:
            return 0
        case .Center:
            return pos
        }
    }
    
    func transformDif(var dif:CGPoint) -> CGPoint{
        switch self{
        case .Left:
            dif.x *= -1
            return dif
        case.Right:
            dif.x *= -1
            return dif
        case .Center:
            return dif
        }
    }
}

class ___FILEBASENAMEASIDENTIFIER___ : UITableViewCell {
    
    @IBOutlet weak var leftView:  UIView!
    @IBOutlet weak var mainView:  UIView!
    @IBOutlet weak var rightView: UIView!
    
    @IBOutlet weak var mainViewAxisX: NSLayoutConstraint!
    @IBOutlet weak var mainViewWidth: NSLayoutConstraint!

    
    var leftAnchorPos:CGFloat   = 0
    var rightAnchorPos:CGFloat  = 0
    var centerAnchorPos:CGFloat = 0
    
    var longGest:UILongPressGestureRecognizer?
    var threshold = false
    var startPoint:CGPoint = CGPoint(x: 0, y: 0)
    
    var lockPos = LockLocation.Center
    
    override var frame:CGRect{
        didSet{
            layoutIfNeeded()
            adjustFramePositioning()
            layoutIfNeeded()
        }
    }
    
    //MARK: - Setup -
    
    override func awakeFromNib(){
        super.awakeFromNib()
        setupGestures()
    }
    
    
    func setupGestures(){
        
        longGest = UILongPressGestureRecognizer(
            target: self,
            action: "cellDidSwipe:")
        
        guard let longGest = longGest else{
            return
        }
        
        longGest.minimumPressDuration = 0.01
        longGest.cancelsTouchesInView = false
        longGest.delegate = self
        
        addGestureRecognizer(longGest)
    }
    
    
    //MARK: - Frame/Anchor positioning -
    
    func adjustFramePositioning(){
        mainViewWidth?.constant = frame.width
        leftAnchorPos  =  self.frame.width
        rightAnchorPos = -self.frame.width
        print(rightAnchorPos)
    }

    

    func offsetLock() -> CGFloat{
        
        let constant = mainViewAxisX.constant
        
        let left = self.frame.width - kLockSlack
        if constant >  left{
            print("con = ", constant, "left = ",left)
            print(leftAnchorPos)
            lockPos = .Left
            return leftAnchorPos
        }
        
        let right = -self.frame.width + kLockSlack
        if constant < right{
            print("con = ", constant, "right = ",right)
            print(rightAnchorPos)
            lockPos = .Right
            return rightAnchorPos
        }
        
        lockPos = .Center
        return centerAnchorPos
    }
    
    
    func centerXReset(animated:Bool = true, reset:Bool = false){
        mainViewAxisX?.constant = offsetLock()
        if reset{
            mainViewAxisX?.constant = centerAnchorPos
        }
        if !animated{
            return
        }
        UIView.animateWithDuration(0.3){
            self.layoutIfNeeded()
        }
    }
    
    
    
    func brokenThreshold(dif:CGPoint) -> Bool{
        
        if threshold{
            return false
        }
        if (fabs(dif.y) > kThresholdMin){
            cancelSwipe()
            return true
        }
        
        if (fabs(dif.x) < kThrsholdMax){
            return true
        }
        return false
    }
    
    
    //MARK: - Swiping -
    
    func cancelSwipe(){
        longGest?.enabled = false;
        longGest?.enabled = true;
        threshold = false;
        centerXReset(true, reset: true)
    }
    
    
    
    func cellDidSwipe(gest:UIGestureRecognizer){
        
        let p = gest.locationInView(self)
        
        if (gest.state == .Began){
            
            threshold  = false
            startPoint = p
            switch lockPos{
            case .Left:
                startPoint.x -= leftAnchorPos
            case .Right:
                startPoint.x -= rightAnchorPos
            case .Center:
                startPoint.x += 0
            }

            if let width = mainViewAxisX?.constant{
                startPoint.x += width
            }
            layoutIfNeeded()
        }
        
        var dif = CGPoint.zero
        dif.x   = p.x - startPoint.x;
        dif.y   = p.y - startPoint.y;
        
        if brokenThreshold(dif){
            return
        }
        
        if !threshold {
            threshold = true
        }
        print("dif = ",dif.x)
        mainViewAxisX.constant = dif.x
        
        if gest.state == .Ended {
            centerXReset()
        }
    }
    
    
    //MARK: - override select highlighting
    
    
    override func setSelected(selected: Bool, animated: Bool){
        
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool){
        
    }
    
    
    //MARK: - Multi-Gesture Delegate -
    
    
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool{
        return true
    }
    
    override func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        return true
    }
    
    override func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool{
        return true
    }
    
    
}
