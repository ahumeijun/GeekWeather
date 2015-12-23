//
//  ShellCoreTest.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/17.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import XCTest
@testable import GeekWeather

class ShellCoreTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAbsPath() {
        let shellCore = ShellCore.defaultShellCore
        let path = "~/hello/.././world/doc/../release"
        do {
            let absPath = try shellCore.getAbsPath(path);
            let expect = "/User/foobar/world/release"
            XCTAssertTrue(absPath == expect)
        } catch {
            XCTFail()
            print("thrown error")
        }
        
        let oripath1 = "~"
        let abspath1 = try! shellCore.getAbsPath(oripath1)
        let exppath1 = "/User/foobar"
        XCTAssertEqual(abspath1, exppath1)
        
        let oripath2 = "~"
        let abspath2 = try! shellCore.getAbsPath(oripath2)
        let exppath2 = "/User/foobar"
        XCTAssertEqual(abspath2, exppath2)
        
        let oripath3 = "~/.."
        let abspath3 = try! shellCore.getAbsPath(oripath3)
        let exppath3 = "/User"
        XCTAssertEqual(abspath3, exppath3)
        
        let oripath4 = "~/../.."
        let abspath4 = try! shellCore.getAbsPath(oripath4)
        let exppath4 = "/"
        XCTAssertEqual(abspath4, exppath4)
    }
    
}
