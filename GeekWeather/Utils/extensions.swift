//
//  extensions.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/21.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import Foundation

extension NSObject {
    class func swiftClassFromString(className : String) -> AnyClass! {
        if let appName : String? = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as! String? {
            let classStringName = "_TtC\(appName?.characters.count)\(appName)\(className.characters.count)\(className)"
            return NSClassFromString(classStringName)
        }
        return nil;
    }
}