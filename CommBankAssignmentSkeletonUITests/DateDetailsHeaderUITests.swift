//
//  DateDetailsHeaderUITests.swift
//  CommBankAssignmentSkeletonUITests
//
//  Created by Payal Kandlur on 2/1/24.
//

import XCTest
@testable import CommBankAssignmentSkeleton

final class DateDetailsHeaderUITests: XCTestCase {
    var app: XCUIApplication!
    var tableView: XCUIElement!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
        tableView = app.tables[AccessibilityIdentifiers.tableViewIdentifier]
    }

    override func tearDownWithError() throws {
        app.terminate()
    }

    func testDateDetailsHeaderUI() throws {
            // Access the DateDetailsHeader instance
        let dateDetailsHeader = tableView.otherElements[AccessibilityIdentifiers.sectionHeaderViewIdentifier].firstMatch

        XCTAssertTrue(dateDetailsHeader.exists)
        
        let dateLabel = app.staticTexts[AccessibilityIdentifiers.dateLabelIdentifier]
        let daysLabel = app.staticTexts[AccessibilityIdentifiers.daysLabelIdentifier]
        
        XCTAssertTrue(dateLabel.exists)
        XCTAssertTrue(daysLabel.exists)
    }
}
