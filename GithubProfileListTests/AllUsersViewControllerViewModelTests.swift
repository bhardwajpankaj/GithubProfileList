//
//  AllUsersViewControllerViewModelTests.swift
//  GithubProfileListTests
//
//  Created by user on 05/08/18.
//  Copyright © 2018 pankajBhardwaj. All rights reserved.
//

import XCTest
@testable import GithubProfileList

class MockAllUsersRequestUseCase: AllUsersRequestUseCase {
    override func initialize(requestDTO : UserRequestDTO,completionHandler:@escaping([UserResponseDTO]?,LimitExceeds?,Error?)->Void) {
        
        let dto = UserResponseDTO(login: nil, id: nil, avatar_url: nil)
        completionHandler([dto],nil,nil);
    }
    
    
}

class AllUsersViewControllerViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        super.tearDown()
    }
    
    func testAllUsersViewControllerViewModel() {
        let viewModel =  AllUsersViewModel()
        let useCase = MockAllUsersRequestUseCase()
        viewModel.getUserInfoFromStarting(completionHandler: { (message) in
            if message != nil{
                //show Alert
                XCTFail(message!)
            }else {
                XCTAssertTrue(true)
            }
        } , useCase : useCase)
    }
    func testGetNextPaginationProducts() {
        let viewModel =  AllUsersViewModel()
        let useCase = MockAllUsersRequestUseCase()
        
        viewModel.getNextUserInfo(completionHandler: { (message) in
            if message != nil{
                //show Alert
                XCTFail(message!)
            }else {
                XCTAssertTrue(true)
            }
        } , useCase : useCase)
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
