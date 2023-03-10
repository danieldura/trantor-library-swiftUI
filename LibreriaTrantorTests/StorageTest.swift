//
//  StorageTest.swift
//  LibreriaTrantorTests
//
//  Created by Dani Durà on 10/3/23.
//

import XCTest
@testable import DDura_Libreria_Trantor

final class StorageTest: XCTestCase {
    let storage = Storage.shared
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSaveAndGet() {
        let userData = User.test
        let key = StorageKeys.user
            
        do {
            try storage.save(userData, key: key)
            let retrievedData:User? = storage.get(key: key, type: User.self)
            
            XCTAssertNotNil(retrievedData)
            XCTAssertEqual(retrievedData,userData)
            
        } catch {
            XCTFail("Failed to save item: \(error.localizedDescription)")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
