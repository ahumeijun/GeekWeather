//
//  ViewController.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/15.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import UIKit
import CocoaLumberjack

class ViewController: UIViewController, ShellCoreDelegate {

    var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Hack Weather"
        self.view.backgroundColor = UIColor.whiteColor()
        self.edgesForExtendedLayout = UIRectEdge.None
        
        textView = UITextView(frame: self.view.bounds)
        textView.backgroundColor = UIColor.blackColor()
        textView.textColor = UIColor.greenColor()
        textView.font = UIFont.systemFontOfSize(14.0)
        self.view .addSubview(textView)
        
//        self.testPathTree()
        self.testCmdExec()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func testPathTree() {
        DDLogInfo("\(PathTree(user: "geek"))")
    }

    func testCmdExec() {
        ShellCore.defaultShellCore.delegate = self
        ShellCore.defaultShellCore.execute("ls -1")
        ShellCore.defaultShellCore.execute("ls -1 aaa")
        ShellCore.defaultShellCore.execute("cd aaa")
        ShellCore.defaultShellCore.execute("ls -1")
        ShellCore.defaultShellCore.execute("cd ./../bbb")
        ShellCore.defaultShellCore.execute("ls -1")
        ShellCore.defaultShellCore.execute("ls -1 ../aaa")
        ShellCore.defaultShellCore.execute("git status")
        ShellCore.defaultShellCore.execute("ls -b")
        ShellCore.defaultShellCore.execute("cd bbb")
        ShellCore.defaultShellCore.execute("mkdir ppp ooo iii sadf dsfr wrio")
        ShellCore.defaultShellCore.execute("touch file")
        ShellCore.defaultShellCore.execute("ls -1")
    }
    
    func didReturnResult(result: String!) {
        DDLogInfo("\n\(result)");
    }
}

