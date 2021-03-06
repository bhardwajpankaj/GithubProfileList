//
//  ImageDownloaderTests.swift
//  GithubProfileListTests
//
//  Created by user on 05/08/18.
//  Copyright © 2018 pankajBhardwaj. All rights reserved.
//

import XCTest
@testable import GithubProfileList

class ImageDownloaderTests: XCTestCase {
    
    var sessionTask : URLSessionTask?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        sessionTask?.cancel()
        super.tearDown()
    }
    
    func testImageDownloader() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let imageURL = "https://avatars2.githubusercontent.com/u/44?v=4"
        sessionTask = imageView.downloadImage(from: imageURL, placeholderImageName: "placeholder")
        XCTAssertNotNil(sessionTask)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
