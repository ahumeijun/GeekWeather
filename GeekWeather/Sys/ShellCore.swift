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
            return "~"
        }
    }
    
    var user: String! {
        get {
            return "foobar"
        }
    }
    
    private var workPathImp : String!
    
    var workPath : String! {
        get {
            return try! self.getAbsPath(self.workPathImp)
        }
        set(path) {
            self.workPathImp = path;
        }
    }
    
    var delegate : ShellCoreDelegate?
    
    /**
     command execute
     the result will popup by ShellCoreDelegate
     
     - parameter command: Command object, cannot be nil
     
     - returns: return true if execute cmd succeeded, otherwise false
     */
    func execute(command : Command!) -> Bool {
        
        var result : String!
        do {
            result = try command.execute()
        } catch Command.CmdExecError.DirNotFound(let dir) {
            result = "\(dir) not found"
        } catch {
            result = "unknown error"
        }
        
        self.delegate?.didReturnResult(result)
        
        return true
    }
    
    
    enum PathError : ErrorType {
        case UnavailableComponent(component : String)
        case PathNotFound(path : String)
        case InvalidComponent(cmpnt : String)
    }
    
    /**
     get absolute path from original path which contains alias, varible or abbreviation
     for example: ., .., $WORK_PATH
     
     - parameter originalPath: original path
     
     - throws: PathError enums
     
     - returns: absolute path
     */
    func getAbsPath(originalPath : String!) throws -> String {
        var absPath : [String] = [String]()
        let cmpnts = preprocessing(originalPath).componentsSeparatedByString("/")
        for cmpnt in cmpnts {
            guard isValid(cmpnt) else {
                throw PathError.InvalidComponent(cmpnt: cmpnt)
            }
            
            if cmpnt.isEmpty {
                continue
            } else if cmpnt == "." {
                continue
            } else if cmpnt == ".." {
                if absPath.count == 0 {
                    throw PathError.UnavailableComponent(component: "/..")
                } else {
                    absPath.removeLast()
                }
            } else {
                absPath.append(cmpnt)
            }
        }
        var path = "/"
        path += absPath.joinWithSeparator("/")
        return path
    }
    
    /**
     check the filename or path component is valid or not
     
     - parameter filename: filename or path component
    
     - returns: return true if valid, otherwise false
     */
    func isValid(filename : String) -> Bool {
        //TODO: is file name valid?
        return true
    }
    
    /**
     translate alias, macro or varible to it's reality value
     
     - parameter path: oringinal path
     
     - returns: pure path
     */
    func preprocessing(path : String) -> String {
        //TODO: process alias, macro, varible and so on
        var temp = path
        temp = temp.stringByReplacingOccurrencesOfString("~", withString: "/User/\(user)")
        return temp
    }
    
    /**
     transform shell path to ios system path
     
     - parameter shellPath: shell path, like "/Users/xxx/Documents/myfile.txt"
     
     - returns: system sanbox path
     */
    func systemPath(shellPath : String) -> String! {
        let prefix = NSHomeDirectory().stringByAppendingString("/Documents/Shell")
        let absShellPath = try! getAbsPath(shellPath)
        let fullpath = prefix + "/\(absShellPath)"
        return fullpath
    }
    
    override init() {
        super.init()
        self.workPath = homepath
        let fullHomepath = systemPath(try! getAbsPath(homepath))
        if !NSFileManager.defaultManager().fileExistsAtPath(fullHomepath) {
            try! NSFileManager.defaultManager().createDirectoryAtPath(fullHomepath, withIntermediateDirectories: true, attributes: nil)
        }
    }
}
