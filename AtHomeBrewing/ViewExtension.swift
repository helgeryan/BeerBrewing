//
//  ViewExtension.swift
//  AtHomeBrewing
//
//  ViewExtension allows for easier access of dimension data for UIViews
//  throughout the app. Helps with readability within the app.
//
//  Created by Ryan Helgeson on 8/9/21.
//

import UIKit

// UIView extension to access dimension data
extension UIView {
    
    // UIView width
    public var width: CGFloat {
        return frame.size.width
    }
    
    // UIView height
    public var height: CGFloat {
        return frame.size.height
    }
    
    // UIView bottom
    public var bottom: CGFloat {
        return frame.origin.y + frame.size.height
    }
    
    // UIView top
    public var top: CGFloat {
        return frame.origin.y
    }
    
    // UIView left
    public var left: CGFloat {
        return frame.origin.x
    }
    
    // UIView right
    public var right: CGFloat {
        return frame.origin.x + frame.size.width
    }
}
