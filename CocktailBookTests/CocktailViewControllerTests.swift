//
//  CocktailViewControllerTests.swift
//  CocktailBookTests
//
//  Created by Arun Kumar on 12/12/2023.
//

import XCTest
@testable import CocktailBook

final class CocktailViewControllerTests: XCTestCase {

    var sut: CocktailViewController?
    
    override func setUp() {
        super.setUp()
        sut = CocktailViewController()
    }

    func test_outlets_shouldBeConnected() {
        sut?.loadViewIfNeeded()
        XCTAssertNotNil(sut?.filterSegment, "filterSegment")
        XCTAssertNotNil(sut?.tableView, "tableView")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}
