//
//  UserTableViewCellTests.swift
//  GithubProfileListTests
//
//  Created by user on 05/08/18.
//  Copyright © 2018 pankajBhardwaj. All rights reserved.
//

import XCTest
@testable import GithubProfileList

class UserTableViewCellTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        let bundle = Bundle(for: UserTableViewCell.self)
        guard let cell = bundle.loadNibNamed("UserTableViewCell", owner: nil)?.first as? UserTableViewCell else {
            return XCTFail()
        }
        cell.prepareForReuse()
        cell.updateInterface(title: "Github")
        XCTAssertEqual(cell.userLabel.text!, "@Github")
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
