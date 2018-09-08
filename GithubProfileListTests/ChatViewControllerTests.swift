//
//  ChatViewControllerTests.swift
//  GithubProfileListTests
//
//  Created by user on 05/08/18.
//  Copyright © 2018 pankajBhardwaj. All rights reserved.
//

import XCTest
@testable import GithubProfileList

class ChatViewControllerTests: XCTestCase {
    
    var ChatViewController: ChatViewController!
    
    override func setUp() {
        
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller:ChatViewController? = storyboard.instantiateVC()
        
        ChatViewController = controller
        ChatViewController.alert(message: ChatViewController.self.description)
        XCTAssertNotNil(ChatViewController.view)
    }
    
    override func tearDown() {
        ChatViewController = nil
        super.tearDown()
    }
    func testSUT_CanPostViewController() {
        let sutMessage = MessagesData(message: "Ram", userType: MessageOwner.User.rawValue)
        ChatViewController.viewModel?.dataArray.append(sutMessage)
        XCTAssertNotNil(ChatViewController.postButtonTapped(sutMessage))
        XCTAssertNotNil(ChatViewController.updateCounting())
        XCTAssertNotNil(ChatViewController.updateDataSource(msg: sutMessage))
        XCTAssertNotNil(ChatViewController.keyboardNotification(notification: NSNotification(name: NSNotification.Name(rawValue: ""), object: nil, userInfo: nil)))

        XCTAssertNotNil(ChatViewController.keyboardHeightLayoutConstraint)
        let textfield = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        ChatViewController.view.addSubview(textfield)
        XCTAssertNotNil(ChatViewController.textFieldShouldReturn(textfield))
    }
    func testSUT_CanInstantiateViewController() {
        XCTAssertNotNil(ChatViewController)
    }
    
    func testSUT_TableViewIsNotNilAfterViewDidLoad() {
        
        XCTAssertNotNil(ChatViewController.tableView)
    }
    
    func testSUT_ShouldSetTableViewDataSource() {
        
        XCTAssertNotNil(ChatViewController.tableView?.dataSource)
    }
    
    func testSUT_ConformsToTableViewDataSource() {
        XCTAssert(ChatViewController.responds(to: #selector(ChatViewController.tableView(_:cellForRowAt:))))
        XCTAssert(ChatViewController.responds(to: #selector(ChatViewController.tableView(_:numberOfRowsInSection:))))
    }
    
    func testSUT_ShouldSetTableViewDelegate() {
        XCTAssertNotNil(ChatViewController.tableView?.delegate)
    }
}
