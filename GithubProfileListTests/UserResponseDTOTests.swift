//
//  UserResponseDTOTests.swift
//  GithubProfileListTests
//
//  Created by user on 05/08/18.
//  Copyright © 2018 pankajBhardwaj. All rights reserved.
//

import XCTest
@testable import GithubProfileList

class UserResponseDTOTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_UserResponseDTO() {
        
        let sut = UserResponseDTO(login: "Daiji", id: 12, avatar_url: nil)
        
        XCTAssertEqual(sut.login, "Daiji")
        XCTAssertEqual(sut.id, 12)
    }
    func test_UserRequestDTO() {
        
        let sut = UserRequestDTO(pageSize: 30, page: 0)
        
        XCTAssertEqual(sut.createGetRequestUrl(url: Constants.gitAllUsersUrl)?.absoluteString, "https://api.github.com/users?since=30")
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
