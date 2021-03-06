//
//  ObjectFactory.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/30.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import UIKit

class ObjectFactory<T : NSObject> {
    class func creatInstance(className : String!) -> T? {
        return OBJCObjectFactory.create(className) as! T?
    }
}
