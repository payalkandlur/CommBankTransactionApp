//
//  AccountDetailsViewModel.swift
//  CommBankAssignmentSkeleton
//
//  Created by Payal Kandlur on 1/31/24.
//

import Foundation

protocol AccountDetailsViewModelDelegate: AnyObject {
    func dataFetchedSuccessfully(data: AccountDetail?)
}

struct AccountDetailTableViewModel {
    var key         : String
    var transaction : [Transaction]
}

final class AccountDetailsViewModel {
    
    weak var delegate: AccountDetailsViewModelDelegate?
    private let networkService: NetworkServiceProtocol
    var accountDetails: AccountDetail?
    var transactionsArray: [Transaction] = []
    var data: [AccountDetailTableViewModel] = []
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchData() {
        accountDetails = networkService.fetchDataFromJson(from: "Sample", type: AccountDetail.self)
        delegate?.dataFetchedSuccessfully(data: accountDetails)
    }
    
    func getTransactions() {
        guard let accountTransactions = accountDetails?.transactions,
              let accountPendingTransactions = accountDetails?.pending,
              !accountTransactions.isEmpty, !accountPendingTransactions.isEmpty else {
            return
        }
        
        let completedTransactions = updatePendingStatus(for: accountTransactions, isPending: false)
        let pendingTransactions = updatePendingStatus(for: accountPendingTransactions, isPending: true)
        
        transactionsArray = completedTransactions + pendingTransactions
        groupTransactionsWithEffectiveDate()
    }
    
    private func updatePendingStatus(for transactions: [Transaction], isPending: Bool) -> [Transaction] {
        return transactions.map {
            var mutableElement = $0
            mutableElement.isPending = isPending
            return mutableElement
        }
    }
    
    func getCoordinates(forATM atmId: String) -> [(latitude: Double?, longitude: Double?)] {
        guard let atms = accountDetails?.atms else {
            return []
        }
        
        if let coordinates = atms.first(where: { $0.id == atmId })?.location {
            return [(latitude: coordinates.lat, longitude: coordinates.lng)]
        } else {
            return []
        }
    }
    
    func groupTransactionsWithEffectiveDate() {
        var tempDict: [String: [Transaction]] = [:]
        transactionsArray.forEach {
            if let key = $0.effectiveDate {
                if var existingValues = tempDict[key] {
                    existingValues.append($0)
                    tempDict[key] = existingValues
                } else {
                    tempDict[key] = [$0]
                }
            }
        }
        
        for (key, value) in tempDict {
            data.append(AccountDetailTableViewModel(key: key, transaction: value))
        }
        data.sort {
            $0.key.calculateDaysFromNow() ?? "" < $1.key.calculateDaysFromNow() ?? ""
        }
    }
}
