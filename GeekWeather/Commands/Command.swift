//
//  Command.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/17.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import UIKit

class Command: NSObject {
    private(set) var workPath : String {
        get {
            return self.workPath
        }
        set(path) {
            self.workPath = path
        }
    }
    
    init(path : String) {
        super.init()
        workPath = path
    }
}
