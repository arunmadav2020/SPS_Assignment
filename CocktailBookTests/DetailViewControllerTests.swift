//
//  DetailViewControllerTests.swift
//  CocktailBookTests
//
//  Created by Arun Kumar on 12/12/2023.
//

import XCTest
@testable import CocktailBook

final class DetailViewControllerTests: XCTestCase {

    var sut: DetailViewController?
    
    override func setUp() {
        super.setUp()
        sut = DetailViewController()
    }
   
    func test_outlets_shouldBeConnected() {
        sut?.loadViewIfNeeded()
        XCTAssertNotNil(sut?.prepTimeLabel, "prepTimeLabel")
        XCTAssertNotNil(sut?.cocktailImageView, "cocktailImageView")
        XCTAssertNotNil(sut?.longDescriptionLabel, "longDescriptionLabel")
        XCTAssertNotNil(sut?.tableView , "tableView")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

}
