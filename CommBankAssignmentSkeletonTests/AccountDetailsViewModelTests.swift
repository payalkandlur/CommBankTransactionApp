//
//  AccountDetailsViewModelTests.swift
//  CommBankAssignmentSkeletonTests
//
//  Created by Payal Kandlur on 2/1/24.
//

import XCTest
@testable import CommBankAssignmentSkeleton

final class AccountDetailsViewModelTests: XCTestCase {
    
    class MockNetworkService: NetworkServiceProtocol {
        var mockData: AccountDetail?
        
        func fetchDataFromJson<T: Decodable>(from fileName: String, type: T.Type) -> T? {
            return mockData as? T
        }
    }
    
    class MockDelegate: AccountDetailsViewModelDelegate {
        var expectation: XCTestExpectation?
        
        func dataFetchedSuccessfully(data: AccountDetail?) {
            expectation?.fulfill()
        }
    }
    
    var viewModel: AccountDetailsViewModel!
    var mockNetworkService: MockNetworkService!
    
    override func setUpWithError() throws {
        super.setUp()
        
        mockNetworkService = MockNetworkService()
        viewModel = AccountDetailsViewModel(networkService: mockNetworkService)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockNetworkService = nil
        
        super.tearDown()
    }
    
    func testFetchData() {
        let mockDelegate = MockDelegate()
        mockDelegate.expectation = expectation(description: "Data Fetched Successfully")
        
        viewModel.delegate = mockDelegate
        
        let transaction1 = Transaction(id: "1", description: "Sample description", effectiveDate: "04/12/2015", amount: 100.00, atmID: "1234", isPending: false)
        let transaction2 = Transaction(id: "2", description: "Sample description", effectiveDate: "10/12/2015", amount: 250.00, atmID: "1101", isPending: true)
        let account = Account(accountName: "sample", accountNumber: "1123", available: 254.22, balance: 234.00)
        
        let accountDetail = AccountDetail(account: account, transactions: [transaction1], pending: [transaction2], atms: [])
        
        let mockData = accountDetail
        mockNetworkService.mockData = mockData
        
        viewModel.fetchData()
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertNotNil(viewModel.accountDetails)
    }
    
    func testGetTransactionsNotNil() {
        
        // mock data
        let transaction1 = Transaction(id: "1", description: "Sample description", effectiveDate: "04/12/2015", amount: 100.00, atmID: "1234", isPending: false)
        let transaction2 = Transaction(id: "2", description: "Sample description", effectiveDate: "10/12/2015", amount: 250.00, atmID: "1101", isPending: true)
        let account = Account(accountName: "sample", accountNumber: "1123", available: 254.22, balance: 234.00)
        
        let accountDetail = AccountDetail(account: account, transactions: [transaction1], pending: [transaction2], atms: [])
        viewModel.accountDetails = accountDetail
                
        XCTAssertNotNil(viewModel.getTransactions())
    }
    
    func testGetTransactionsNil() {
        
        let pending = Transaction(id: "2", description: "Sample description", effectiveDate: "10/12/2015", amount: 250.00, atmID: "1101", isPending: true)
        let account = Account(accountName: "sample", accountNumber: "1123", available: 254.22, balance: 234.00)
        
        let accountDetail = AccountDetail(account: account, transactions: [], pending: [pending], atms: [])
        viewModel.accountDetails = accountDetail
        viewModel.getTransactions()
        XCTAssertTrue(viewModel.transactionsArray.isEmpty)
    }
    
    func testGetPendingTransactionsNil() {
        
        let transaction = Transaction(id: "2", description: "Sample description", effectiveDate: "10/12/2015", amount: 250.00, atmID: "1101", isPending: true)
        let account = Account(accountName: "sample", accountNumber: "1123", available: 254.22, balance: 234.00)
        
        let accountDetail = AccountDetail(account: account, transactions: [transaction], pending: [], atms: [])
        viewModel.accountDetails = accountDetail
                
        viewModel.getTransactions()
        XCTAssertTrue(viewModel.transactionsArray.isEmpty)
    }
    
    func testGetCoordinatesForExistingATM() {
        //movk data
        let atmId = "1897"
        let transaction = Transaction(id: "2", description: "Sample description", effectiveDate: "10/12/2015", amount: 250.00, atmID: "1897", isPending: true)
        let account = Account(accountName: "sample", accountNumber: "1123", available: 254.22, balance: 234.00)
        
        let accountDetail = AccountDetail(account: account, transactions: [transaction], pending: [], atms: [])
        viewModel.accountDetails = accountDetail
                
        XCTAssertNotNil(viewModel.getCoordinates(forATM: atmId))
    }
    
    func testGetCoordinatesForNonexistentATM() {
        let atmId = "1111"
        let transaction = Transaction(id: "2", description: "Sample description", effectiveDate: "10/12/2015", amount: 250.00, atmID: "1101", isPending: true)
        let account = Account(accountName: "sample", accountNumber: "1123", available: 254.22, balance: 234.00)
        
        let accountDetail = AccountDetail(account: account, transactions: [transaction], pending: [], atms: [])
        viewModel.accountDetails = accountDetail
                
        XCTAssertTrue(viewModel.getCoordinates(forATM: atmId).isEmpty)
    }
    
    func testGroupTransactionsWithEffectiveDate() {
            // Create a sample Transaction for testing
            let transaction1 = Transaction(id: "2", description: "Sample description", effectiveDate: "10/12/2015", amount: 250.00, atmID: "1897", isPending: true)
            let transaction2 = Transaction(id: "6", description: "Sample description 2", effectiveDate: "10/01/2015", amount: 250.00, atmID: "1347", isPending: true)
        let transaction3 = Transaction(id: "3", description: "Sample description 3", effectiveDate: "10/01/2015", amount: 250.00, atmID: "1347", isPending: true)

            viewModel.transactionsArray = [transaction1, transaction2, transaction3]

            viewModel.groupTransactionsWithEffectiveDate()

            XCTAssertFalse(viewModel.data.isEmpty)

            XCTAssertEqual(viewModel.data[0].key, "10/12/2015")
            XCTAssertEqual(viewModel.data[1].key, "10/01/2015")

            XCTAssertEqual(viewModel.data[0].transaction.count, 1)
            XCTAssertEqual(viewModel.data[1].transaction.count, 2)

            XCTAssertEqual(viewModel.data[0].transaction[0].description, "Sample description")
            XCTAssertEqual(viewModel.data[1].transaction[0].description, "Sample description 2")
        XCTAssertEqual(viewModel.data[1].transaction[1].description, "Sample description 3")
        }

    
}
