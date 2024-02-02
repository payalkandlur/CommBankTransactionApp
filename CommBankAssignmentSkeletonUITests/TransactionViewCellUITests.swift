//
//  TransactionViewCellUITests.swift
//  CommBankAssignmentSkeletonUITests
//
//  Created by Payal Kandlur on 2/1/24.
//

import XCTest
@testable import CommBankAssignmentSkeleton

final class TransactionViewCellUITests: XCTestCase {

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

    func testTransactionCellUI() throws {
        let cell = tableView.cells[AccessibilityIdentifiers.transactionCellIdentifier]

        XCTAssertTrue(cell.exists)
        
        let descriptionLabel = cell.staticTexts[AccessibilityIdentifiers.descriptionLabelIdentifier]
        let amountLabel = cell.staticTexts[AccessibilityIdentifiers.amountLabelIdentifier]
        
        XCTAssertTrue(descriptionLabel.exists)
        XCTAssertTrue(amountLabel.exists)
    }
}
