//
//  LibreriaTrantorTests.swift
//  LibreriaTrantorTests
//
//  Created by Dani Durà on 16/2/23.
//

import XCTest
@testable import DDura_Libreria_Trantor

final class LibreriaTrantorTests: XCTestCase {
    let persistence = ModelPersistence()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadBooks() throws {
        let books = persistence.fetchBooks()
        XCTAssertEqual(books.count, 970)
    }
    
    func testFetchAuthors() throws {
        let authors = persistence.fetchAuthors()
        XCTAssertEqual(authors.count, 293)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
