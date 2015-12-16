//
//  CommandOption.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/15.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import UIKit

public class CommandOption: NSObject {
    
    public var option : String!
    public var argument : String?
    
    override init() {
        option = ""
    }
    
    override public var description: String {
        return "{option:\(option) arguments:\(argument)}"
    }
    
    override public func isEqual(object: AnyObject?) -> Bool {
        if let other = object as? CommandOption {
            return self.option == other.option && self.argument == other.argument
        } else {
            return false
        }
    }
}
