//
//  RegExTest.swift
//  GeekWeather
//
//  Created by 梅俊 on 15/12/31.
//  Copyright © 2015年 RangerStudio. All rights reserved.
//

import XCTest
@testable import GeekWeather

class RegExTest: XCTestCase {
    
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
    
    func testFilename() {
        let filenameRegEx = RegEx.filenameRegEx
        XCTAssertTrue(filenameRegEx.isMatching("hello"))
        XCTAssertTrue(filenameRegEx.isMatching(".hello"))
        XCTAssertTrue(filenameRegEx.isMatching("hello.a"))
        XCTAssertTrue(filenameRegEx.isMatching(".hello.a"))
        
        XCTAssertFalse(filenameRegEx.isMatching("hello.a."))
        XCTAssertFalse(filenameRegEx.isMatching("hello.a.a"))
        XCTAssertFalse(filenameRegEx.isMatching("hello.a.a"))
        XCTAssertFalse(filenameRegEx.isMatching("hello.asadjflhashdf"))
    }
    
    func testDirname() {
        let dirnameRegEx = RegEx.dirnameRegEx
        XCTAssertTrue(dirnameRegEx.isMatching("hello"))
        XCTAssertTrue(dirnameRegEx.isMatching(".hello"))
        XCTAssertFalse(dirnameRegEx.isMatching("hello.a"))
        XCTAssertFalse(dirnameRegEx.isMatching(".hello.a"))
        
        XCTAssertFalse(dirnameRegEx.isMatching("hello.a."))
        XCTAssertFalse(dirnameRegEx.isMatching("hello.a.a"))
        XCTAssertFalse(dirnameRegEx.isMatching("hello.a.a"))
        XCTAssertFalse(dirnameRegEx.isMatching("hello.asadjflhashdf"))
    }
    
}
