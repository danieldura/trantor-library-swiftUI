//
//  TestStrings.swift
//  Tests
//
//  Created by Dani Durà on 15/3/23.
//

import XCTest
@testable import DDura_Libreria_Trantor

final class TestStrings: XCTestCase {

    func testEmailValidator(){
        let mail = "hola@ddura.es"
        let badMail = "heyQuefeu@as"
        
        XCTAssertTrue(mail.isEmail)
        XCTAssertFalse(badMail.isEmail)
    }


}
