//  Copyright (c) 2022 Commonwealth Bank. All rights reserved.

import Foundation

// MARK: - AccountDetail
struct AccountDetail: Codable {
    let account: Account
    let transactions: [Transaction]
    let pending: [Transaction]
    let atms: [ATM]
}

// MARK: - Account
struct Account: Codable {
    let accountName: String?
    let accountNumber: String?
    let available: Double?
    let balance: Double?
}

// MARK: - ATM
struct ATM: Codable {
    let id: String?
    let name: String?
    let address: String?
    let location: Location
}

// MARK: - Location
struct Location: Codable {
    let lat: Double?
    let lng: Double?
}

// MARK: - Pending
struct Transaction: Codable {
    let id: String?
    let description: String?
    let effectiveDate: String?
    let amount: Double?
    let atmID: String?
    var isPending: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, description, effectiveDate, amount
        case atmID = "atmId"
    }
}
