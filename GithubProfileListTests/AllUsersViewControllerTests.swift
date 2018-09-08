//
//  AllUsersViewControllerTests.swift
//  GithubProfileListTests
//
//  Created by user on 05/08/18.
//  Copyright © 2018 pankajBhardwaj. All rights reserved.
//

import XCTest
@testable import GithubProfileList

class AllUsersViewControllerTests: XCTestCase,UserDetailRouter {
    func routeToUserDetailController(selectedUser: UserResponseDTO) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let chatViewModel = ChatViewModel()
        chatViewModel.userSelected = selectedUser
        let controller:ChatViewController? = storyboard.instantiateVC()
        controller?.viewModel = chatViewModel
        allUsersViewController.navigationController?.pushViewController(controller ?? UIViewController(), animated: true)
    }
    
    
    var allUsersViewController: AllUsersViewController!

    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        allUsersViewController = navigationController.topViewController as! AllUsersViewController

        XCTAssertNotNil(navigationController.view)
        XCTAssertNotNil(allUsersViewController.view)

    }
    
    override func tearDown() {
        allUsersViewController = nil
        super.tearDown()
    }
    
    func testSUT_RoutingViewController() {
        let dto = UserResponseDTO(login: "Hello", id: 5, avatar_url: nil)

        allUsersViewController.routeToUserDetailController(selectedUser: dto)
        XCTAssertNotNil(allUsersViewController)
    }
    
    func testSUT_CanInstantiateViewController() {
        
        XCTAssertNotNil(allUsersViewController)
    }
    
    func testSUT_TableViewIsNotNilAfterViewDidLoad() {
        
        XCTAssertNotNil(allUsersViewController.tableView)
    }
    
    func testSUT_HasItemsForTableView() {
        
        XCTAssertNotNil(allUsersViewController.viewModel)
    }
    
    func testSUT_ShouldSetTableViewDataSource() {
        
        XCTAssertNotNil(allUsersViewController.tableView?.dataSource)
    }
    
    func testSUT_ConformsToTableViewDataSource() {
        
        XCTAssert(allUsersViewController.responds(to: #selector(allUsersViewController.tableView(_:numberOfRowsInSection:))))
      XCTAssert(allUsersViewController.responds(to: #selector(allUsersViewController.tableView(_:cellForRowAt:))))
    }
    func testSUT_ConformsToTableViewDelegate() {
        XCTAssert(allUsersViewController.responds(to: #selector(allUsersViewController.tableView(_:didSelectRowAt:))))
        
        XCTAssert(allUsersViewController.responds(to: #selector(allUsersViewController.tableView(_:willDisplay:forRowAt:))))
    }
    
    func testSUT_ShouldSetTableViewDelegate() {
        
        XCTAssertNotNil(allUsersViewController.tableView?.delegate)
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
