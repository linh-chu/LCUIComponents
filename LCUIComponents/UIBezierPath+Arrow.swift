//
//  UIBezierPath+Arrow.swift
//  LCUIComponents
//
//  Created by Linh Chu on 23/6/17.
//  Copyright © 2017 Linh Chu. All rights reserved.
//

import Foundation
import UIKit

extension UIBezierPath {
    
    public static func withArrowFromPoint(startPoint:CGPoint,
                                          endPoint:CGPoint,
                                          tailWidth:CGFloat,
                                          headWidth:CGFloat,
                                          headLength:CGFloat) -> UIBezierPath {
        let kArrowPointCount = 7
        let length = CGFloat(hypotf(Float(endPoint.x) - Float(startPoint.x), Float(endPoint.y) - Float(startPoint.y)))
        
        
        var points = [CGPoint]()
        
        axisAlignedArrowPoints(points: &points, length: length, tailWidth: tailWidth, headWidth: headWidth, headLength: headLength)
        var transform = transformFor(startPoint: startPoint, endPoint: endPoint, length: length)
        
        let cgPath = CGMutablePath()
        
//        cgPath.addLines(&transform, between: points, count: kArrowPointCount)
        
        cgPath.addLines(between: points, transform: transform)
        cgPath.closeSubpath()
        let uiPath = UIBezierPath(cgPath: cgPath)
        return uiPath
        
    }
    
    // ===================================================================================================
    
    private static func axisAlignedArrowPoints(points:inout [CGPoint],
                                               length:CGFloat,
                                               tailWidth:CGFloat,
                                               headWidth:CGFloat,
                                               headLength:CGFloat) {
        let tailLength = length - headLength
        
        points.append(CGPoint(x: 0, y: tailWidth/2))
        points.append(CGPoint(x: tailLength, y: tailWidth/2))
        points.append(CGPoint(x: tailLength, y: headLength/2))
        points.append(CGPoint(x: length, y: 0))
        points.append(CGPoint(x: tailLength, y: -headWidth/2))
        points.append(CGPoint(x: tailLength, y: -tailWidth/2))
        points.append(CGPoint(x: 0, y: -tailWidth/2))
        
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    private static func transformFor(startPoint:CGPoint, endPoint:CGPoint, length:CGFloat) -> CGAffineTransform {
        let cosine = (endPoint.x - startPoint.x)/length
        let sine = (endPoint.y - startPoint.y)/length
        
        var myAffineTransform = CGAffineTransform()
        myAffineTransform.a = cosine
        myAffineTransform.b = sine
        myAffineTransform.c = -sine
        myAffineTransform.d = cosine
        myAffineTransform.tx = startPoint.x
        myAffineTransform.ty = startPoint.y
        
        return myAffineTransform
    }
}
