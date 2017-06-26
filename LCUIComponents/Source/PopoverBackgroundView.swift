//
//  PopoverBackgroundView.swift
//  LCUIComponents
//
//  Created by Linh Chu on 20/6/17.
//  Copyright © 2017 Linh Chu. All rights reserved.
//

import UIKit

class PopoverBackgroundView: UIPopoverBackgroundView {
    
    static let ARROW_BASE : CGFloat = 20
    static let ARROW_HEIGHT : CGFloat = 20
    fileprivate var _arrowOffset : CGFloat
    fileprivate var _arrowDirection : UIPopoverArrowDirection
    
    override class func arrowBase() -> CGFloat {
        return self.ARROW_BASE
    }
    
    override class func arrowHeight() -> CGFloat {
        return self.ARROW_HEIGHT
    }
    
    override var arrowOffset : CGFloat {
        get { return self._arrowOffset }
        set { self._arrowOffset = newValue }
    }
    
    override var arrowDirection : UIPopoverArrowDirection {
        get { return self._arrowDirection }
        set { self._arrowDirection = newValue }
    }    
    
    override init(frame:CGRect) {
        self._arrowOffset = 0
        self._arrowDirection = .any
        super.init(frame:frame)
        self.isOpaque = false
        
        

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(self.inputView?.backgroundColor)
        print(self.superview?.backgroundColor)
        
        self.layer.cornerRadius = 20
        self.backgroundColor = self.inputView?.backgroundColor
        self.layer.borderColor = self.superview?.backgroundColor?.cgColor
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Determines the margins for the popover content
    override class func contentViewInsets() -> UIEdgeInsets {
        return UIEdgeInsetsMake(20, 20, 20, 20)
    }
    
    // Determines whether the default content appearance should be used for the popover
    override class var wantsDefaultContentAppearance : Bool {
        return false
    }
    
//    override func draw(_ rect: CGRect) {
//        
//        
//        let con = UIGraphicsGetCurrentContext()!
//        con.saveGState()
//        // clamp offset
//        var propX = self.arrowOffset
//        let limit : CGFloat = 22.0
//        let maxX = rect.size.width/2.0 - limit
//        propX = min(max(propX, limit), maxX)
//        
//        let klass = type(of:self)        
//        
//        con.translateBy(x: rect.size.width/2.0 + propX - klass.ARROW_BASE/2.0, y: 0)
//        con.move(to:CGPoint(x: 0, y: klass.ARROW_HEIGHT))
//        con.addLine(to:CGPoint(x: klass.ARROW_BASE / 2.0, y: 0))
//        con.addLine(to:CGPoint(x: klass.ARROW_BASE, y: klass.ARROW_HEIGHT))
//        con.closePath()
//        con.addRect(CGRect(x: 0, y: klass.ARROW_HEIGHT, width: klass.ARROW_BASE, height: 15))
//        con.clip()
////        lin.draw(at:CGPoint(x: -40, y: -40))
//        con.restoreGState()
//    }
    
//    override func draw(_ rect: CGRect) {
//        // WARNING: this code is sort of a cheat:
//        // I should be checking self.arrowDirection and changing what I do depending on that...
//        // but instead I am just *assuming* that the arrowDirection is UIPopoverArrowDirectionUp
//        
//        let linOrig = UIImage(named: "linen.png")!
//        let capw = linOrig.size.width / 2.0 - 1
//        let caph = linOrig.size.height / 2.0 - 1
//        let lin = linOrig.resizableImage(withCapInsets:UIEdgeInsetsMake(caph, capw, caph, capw),resizingMode:.tile)
//        
//        
//        // draw the arrow
//        // I'm just going to make a triangle filled with our linen background...
//        // ...extended by a rectangle so it joins to our "pinked" corner drawing
//        
//        var arrow : Bool {return true} // false to omit arrow, cute technique
//        if arrow {
//            
//            let con = UIGraphicsGetCurrentContext()!
//            con.saveGState()
//            // clamp offset
//            var propX = self.arrowOffset
//            let limit : CGFloat = 22.0
//            let maxX = rect.size.width/2.0 - limit
//            //            if propX > maxX { propX = maxX }
//            //            if propX < limit { propX = limit }
//            propX = min(max(propX, limit), maxX)
//            let klass = type(of:self)
//            con.translateBy(x: rect.size.width/2.0 + propX - klass.ARBASE/2.0, y: 0)
//            con.move(to:CGPoint(x: 0, y: klass.ARHEIGHT))
//            con.addLine(to:CGPoint(x: klass.ARBASE / 2.0, y: 0))
//            con.addLine(to:CGPoint(x: klass.ARBASE, y: klass.ARHEIGHT))
//            con.closePath()
//            con.addRect(CGRect(x: 0, y: klass.ARHEIGHT, width: klass.ARBASE, height: 15))
//            con.clip()
//            lin.draw(at:CGPoint(x: -40, y: -40))
//            con.restoreGState()
//            
//        }
//        
//        // draw the body, to go behind the view part of our rectangle (i.e. rect minus arrow)
//        //        var arrow = CGRect.zero
//        //        var body = CGRect.zero
//        //        rect.__divided(slice: &arrow, remainder: &body, atDistance: klass.ARHEIGHT, from: .minYEdge)
//        let (_,body) = rect.divided(atDistance: type(of:self).ARHEIGHT, from: .minYEdge)
//        lin.draw(in:body)
//        
//    }
    
    
}
