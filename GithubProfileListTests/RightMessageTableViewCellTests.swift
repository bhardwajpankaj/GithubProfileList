//
//  RightMessageTableViewCellTests.swift
//  GithubProfileListTests
//
//  Created by Pankaj Bhardwaj on 22/08/18.
//  Copyright © 2018 pankajBhardwaj. All rights reserved.
//

import XCTest
@testable import GithubProfileList

class RightMessageTableViewCellTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: RightMessageTableViewCell.self)
        guard let cell = bundle.loadNibNamed("RightMessageTableViewCell", owner: nil)?.first as? RightMessageTableViewCell else {
            return XCTFail()
        }
        cell.changeImage(Constants.rightImage, message: "Hello")
        XCTAssertEqual(cell.messageLbl.text!, "Hello")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
