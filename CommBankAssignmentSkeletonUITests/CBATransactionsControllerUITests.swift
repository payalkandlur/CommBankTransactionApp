//
//  CBATransactionsController.swift
//  CommBankAssignmentSkeletonUITests
//
//  Created by Payal Kandlur on 2/1/24.
//

import XCTest
@testable import CommBankAssignmentSkeleton

final class CBATransactionsControllerUITests: XCTestCase {
    
    var app: XCUIApplication!
    var tableView: XCUIElement!
    var cell: TransactionViewCell!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
        tableView = app.tables[AccessibilityIdentifiers.tableViewIdentifier]
    }
    
    override func tearDownWithError() throws {
        app.terminate()
    }
    
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }
    
    func testInitialStateIsCorrect() {
        let table = app.tables[AccessibilityIdentifiers.tableViewIdentifier]
        XCTAssertTrue(table.exists)
    }
    
    func testTransactionCellUI() {
        let transactionCell = app.tables.cells.staticTexts[AccessibilityIdentifiers.descriptionLabelIdentifier]
        
        XCTAssertTrue(transactionCell.exists)
        
        let locationButton = app.buttons[AccessibilityIdentifiers.locationButtonIdentifier]
        XCTAssertTrue(locationButton.exists)
        app.buttons[AccessibilityIdentifiers.locationButtonIdentifier].firstMatch.tap()
        let mapView = app.maps.firstMatch
        XCTAssertTrue(mapView.exists)
    }
}
