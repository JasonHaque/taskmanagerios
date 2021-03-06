//
//  Extensions.swift
//  TaskManageriOS
//
//  Created by Sanviraj Zahin Haque on 12/9/20.
//  Copyright © 2020 Sanviraj Zahin Haque. All rights reserved.
//

import Foundation

import UIKit

extension UIView{
    
    public var width : CGFloat{
        return self.frame.size.width
    }
    
    public var height : CGFloat{
        return self.frame.size.height
    }
    
    public var top : CGFloat{
        return self.frame.origin.y
    }
    
    public var bottom : CGFloat{
        return self.frame.size.height + self.frame.origin.y
    }
    
    public var left : CGFloat{
        return self.frame.origin.x
    }
    
    public var righ : CGFloat{
        return self.frame.size.width + self.frame.origin.x
    }
}

extension String{
    func safeDatabaseKey() -> String{
        
        return self.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
        
        
        
    }
}
