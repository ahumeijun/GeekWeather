//
//  RegEx.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/31.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import UIKit
import CocoaLumberjack

class RegEx: NSObject {
    
    private let internalExpression: NSRegularExpression?
    private let internalPattern: String
    
    static let filenameRegEx : RegEx = RegEx("^\\.?[0-9a-zA-Z]{1,16}(\\.[0-9a-zA-Z]{1,8})?$")!
    
    static let dirnameRegEx : RegEx = RegEx("^\\.?[0-9a-zA-Z]{1,16}$")!
    
    init?(_ pattern: String) {
        internalPattern = pattern
        var expression : NSRegularExpression?
        do {
            expression = try NSRegularExpression(pattern: pattern, options: [NSRegularExpressionOptions.CaseInsensitive])
        } catch {
            DDLogError("init regular expression error:\(error)")
        }
        internalExpression = expression
        super.init()
        guard let _ = internalExpression else {
            DDLogWarn("RegEx init faided, will return nil");
            return nil
        }
    }
    
    func isMatching(input: String) -> Bool {
        let matching = self.internalExpression!.firstMatchInString(input, options: [], range: NSMakeRange(0, input.characters.count))
        let v : NSTextCheckingResult! = matching
        return v != nil
    }
}
