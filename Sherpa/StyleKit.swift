//
//  StyleKit.swift
//  Iris
//
//  Created by Arun Rawlani on 4/14/16.
//  Copyright © 2016 Arun Rawlani. All rights reserved.
//

import UIKit

enum ClusterSize {
    case Small, Medium, Large
}

class StyleKit: NSObject {
    
    //MARK: - Colors
    
    static let red = UIColor(hue: 0.98, saturation: 0.991, brightness: 0.816, alpha: 1)
    
    //MARK: - Canvas Drawings
    
    class func drawCluster(clusterSize: ClusterSize, color: UIColor) {
        
        let circle: CGRect
        let borderWidth: CGFloat
        
        switch clusterSize {
        case .Small:
            circle = CGRect(x: 0, y: 0, width: 26, height: 26)
            borderWidth = 3
        case .Medium:
            circle = CGRect(x: 0, y: 0, width: 36, height: 36)
            borderWidth = 4
        case .Large:
            circle = CGRect(x: 0, y: 0, width: 44, height: 44)
            borderWidth = 4
        }
        
        let context = UIGraphicsGetCurrentContext()!
        CGContextSaveGState(context)
        
        let cluster = UIBezierPath(ovalInRect: circle)
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 2, 2)
        color.setFill()
        cluster.fill()
        cluster.lineWidth = borderWidth
        UIColor.whiteColor().setStroke()
        cluster.stroke()
        CGContextRestoreGState(context)
        CGContextRestoreGState(context)
    }
    
    class func drawMarker(color color: UIColor, frame: CGRect = CGRect(x: 0, y: 0, width: 20, height: 30)) {
        /// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        /// Resize To Frame
        CGContextSaveGState(context)
        
        /// Combined Shape
        let combinedShape = UIBezierPath()
        combinedShape.moveToPoint(CGPoint(x: 7.51, y: 26.47))
        combinedShape.addCurveToPoint(CGPoint(x: 10.49, y: 26.47), controlPoint1: CGPoint(x: 8.34, y: 27.91), controlPoint2: CGPoint(x: 9.67, y: 27.92))
        combinedShape.addCurveToPoint(CGPoint(x: 18, y: 8.88), controlPoint1: CGPoint(x: 10.49, y: 26.47), controlPoint2: CGPoint(x: 18, y: 13.79))
        combinedShape.addCurveToPoint(CGPoint(x: 9, y: 0), controlPoint1: CGPoint(x: 18, y: 3.98), controlPoint2: CGPoint(x: 13.97, y: 0))
        combinedShape.addCurveToPoint(CGPoint(x: 0, y: 8.88), controlPoint1: CGPoint(x: 4.03, y: 0), controlPoint2: CGPoint(x: 0, y: 3.98))
        combinedShape.addCurveToPoint(CGPoint(x: 7.51, y: 26.47), controlPoint1: CGPoint(x: 0, y: 13.79), controlPoint2: CGPoint(x: 7.51, y: 26.47))
        combinedShape.closePath()
        combinedShape.moveToPoint(CGPoint(x: 9, y: 13.5))
        combinedShape.addCurveToPoint(CGPoint(x: 13.5, y: 9), controlPoint1: CGPoint(x: 11.49, y: 13.5), controlPoint2: CGPoint(x: 13.5, y: 11.49))
        combinedShape.addCurveToPoint(CGPoint(x: 9, y: 4.5), controlPoint1: CGPoint(x: 13.5, y: 6.52), controlPoint2: CGPoint(x: 11.49, y: 4.5))
        combinedShape.addCurveToPoint(CGPoint(x: 4.5, y: 9), controlPoint1: CGPoint(x: 6.52, y: 4.5), controlPoint2: CGPoint(x: 4.5, y: 6.52))
        combinedShape.addCurveToPoint(CGPoint(x: 9, y: 13.5), controlPoint1: CGPoint(x: 4.5, y: 11.49), controlPoint2: CGPoint(x: 6.52, y: 13.5))
        combinedShape.closePath()
        combinedShape.moveToPoint(CGPoint(x: 9, y: 13.5))
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 1, 1)
        combinedShape.usesEvenOddFillRule = true
        color.setFill()
        combinedShape.fill()
        CGContextRestoreGState(context)
        
        CGContextRestoreGState(context)
    }
    
    //MARK: - Canvas Images
    
    class func imageOfCluster(clusterSize clusterSize: ClusterSize, color: UIColor = red) -> UIImage {
        var image: UIImage
        let size:CGSize
        switch clusterSize {
        case .Small:
            size = CGSize(width: 30, height: 30)
        case .Medium:
            size = CGSize(width: 40, height: 40)
        case .Large:
            size = CGSize(width: 50, height: 50)
        }
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        StyleKit.drawCluster(clusterSize, color: color)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func imageOfMarker(color color: UIColor, size: CGSize = CGSize(width: 20, height: 30)) -> UIImage {
        var image: UIImage
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        StyleKit.drawMarker(color: color, frame: CGRect(origin: CGPoint.zero, size: size))
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
