//
//  LeftMessageTableViewCellTests.swift
//  GithubProfileListTests
//
//  Created by Pankaj Bhardwaj on 22/08/18.
//  Copyright © 2018 pankajBhardwaj. All rights reserved.
//

import XCTest
@testable import GithubProfileList

class LeftMessageTableViewCellTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: LeftMessageTableViewCell.self)
        guard let cell = bundle.loadNibNamed("LeftMessageTableViewCell", owner: nil)?.first as? LeftMessageTableViewCell else {
            return XCTFail()
        }
        cell.changeImage(Constants.leftImage, message: "Hello")
        XCTAssertEqual(cell.messageLbl.text!, "Hello")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
