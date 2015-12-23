//
//  ShellCore.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/17.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import UIKit

protocol ShellCoreDelegate {
    func didReturnResult(result : String!)
}

class ShellCore: NSObject {
    
    static let defaultShellCore : ShellCore = ShellCore()
    
    var homepath : String! {
        get {
            return NSHomeDirectory().stringByAppendingString("/Documents/root")
        }
    }
    
    var workPath : String!
    
    var delegate : ShellCoreDelegate?
    
    
    func execute(command : Command!) -> Bool {
        
        var result : String!
        switch command {
        case let cmd as ls:
            do {
                result = try cmd.execute()
            } catch ls.LsCmdExecError.DirNotFound(let dir) {
                result = "\(dir) not found"
            } catch {
                result = "unknown error"
            }
        case let cmd as cd:
            print("cmd is \(cmd)")
            break
        default:
            break
        }
        
        self.delegate?.didReturnResult(result)
        
        return true
    }
    
    
    enum PathError : ErrorType {
        case UnavailableComponent(component : String)
        case PathNotFound(path : String)
    }
    
    func getAbsPath() throws -> String {
        var absPath : [String] = [String]()
        let cmpnts = preprocessing(workPath).componentsSeparatedByString("/")
        for cmpnt in cmpnts {
            if absPath.count == 0 {
                if cmpnt == "~" {
                    absPath.append(cmpnt)
                } else {
                    absPath.removeAll()
                    throw PathError.UnavailableComponent(component: homepath)
                }
            } else {
                if cmpnt == ".." {
                    if absPath.count == 1 {
                        throw PathError.PathNotFound(path: "~/..")
                    } else {
                        absPath.removeLast()
                    }
                } else if cmpnt == "." {
                    continue
                } else if islegal(cmpnt) {
                    absPath.append(cmpnt)
                } else {
                    throw PathError.UnavailableComponent(component: cmpnt)
                }
            }
        }
        return absPath.joinWithSeparator("/")
    }
    
    func islegal(filename : String) -> Bool {
        //TODO: is file name legal?
        return true
    }
    
    func preprocessing(path : String) -> String {
        //TODO: process alias, macro, varible and so on
        return path
    }
    
    override init() {
        super.init()
        workPath = "~"
        if !NSFileManager.defaultManager().fileExistsAtPath(homepath) {
            try! NSFileManager.defaultManager().createDirectoryAtPath(homepath, withIntermediateDirectories: true, attributes: nil)
        }
    }
}
