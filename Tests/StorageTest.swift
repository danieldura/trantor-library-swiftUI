//
//  StorageTest.swift
//  Tests
//
//  Created by Dani Durà on 15/3/23.
//

import XCTest
@testable import DDura_Libreria_Trantor

final class StorageTest: XCTestCase {
    let storage = DataEncryptionManager.shared
    
    override func setUpWithError() throws {
       print("setUpWithError")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        print("tearDownWithError")
    }

    func testSaveAndGet() {
        print("testSaveAndGet")
        let testData = "HelloWorld"
        let key = StorageKeys.test
            
        do {
            try storage.save(testData, key: key)
            let retrievedData = storage.get(key: key, type: String.self)
            
            XCTAssertNotNil(retrievedData)
            XCTAssertEqual(retrievedData,testData)
            
        } catch {
            XCTFail("Failed to save item: \(error.localizedDescription)")
        }
        
        storage.cleanAll()
    }
    func testPerformanceExample() throws {
        print("testPerformanceExample")
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
        
    }


}
