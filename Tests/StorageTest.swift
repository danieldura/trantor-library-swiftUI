//
//  StorageTest.swift
//  Tests
//
//  Created by Dani Durà on 15/3/23.
//

import XCTest
@testable import DDura_Libreria_Trantor

final class StorageTest: XCTestCase {
    let storage = Storage.shared
    
    override func setUpWithError() throws {
       print("setUpWithError")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        print("tearDownWithError")
    }

    func testSaveAndGet() {
        print("testSaveAndGet")
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
        print("testPerformanceExample")
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
        
    }


}
