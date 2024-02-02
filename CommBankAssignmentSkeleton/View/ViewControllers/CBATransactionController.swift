//  Copyright (c) 2022 Commonwealth Bank. All rights reserved.

import UIKit

class CBATransactionController: UIViewController, AccountDetailsViewModelDelegate {
    
    private let tableView = UITableView()
    private let tableHeaderView = AccountDetailsTableHeader()
    private let viewModel = AccountDetailsViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchData()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.accessibilityIdentifier = AccessibilityIdentifiers.tableViewIdentifier
        tableView.sectionHeaderTopPadding = .zero
        view.addSubview(tableView)
        setupTableViewHeaderFooter()
        registerTableViews()
    }
    
    private func setupTableViewHeaderFooter() {
        tableHeaderView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        tableHeaderView.updateAccountDetails(account: viewModel.accountDetails?.account)
        tableView.tableHeaderView = tableHeaderView
        tableView.tableHeaderView?.accessibilityIdentifier = AccessibilityIdentifiers.tableViewHeaderIdentifier
        tableView.tableFooterView = UIView()
    }
    
    private func registerTableViews() {
        tableView.register(DateDetailsHeader.self, forHeaderFooterViewReuseIdentifier: "DateDetailsHeader")
        tableView.register(TransactionViewCell.self, forCellReuseIdentifier: "TransactionViewCell")
    }
    
    func dataFetchedSuccessfully(data: AccountDetail?) {
        viewModel.getTransactions()
        tableView.reloadData()
    }
}


extension CBATransactionController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       viewModel.data[section].transaction.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DateDetailsHeader") as? DateDetailsHeader
        else { return UIView() }
        headerView.setupUI(viewModel.data[section].key)
        headerView.accessibilityIdentifier = AccessibilityIdentifiers.sectionHeaderViewIdentifier
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionViewCell", for: indexPath) as? TransactionViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.setupUI(viewModel.data[indexPath.section].transaction[indexPath.row], viewModel.accountDetails?.atms)
        cell.delegate = self
        cell.accessibilityIdentifier = AccessibilityIdentifiers.transactionCellIdentifier
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension CBATransactionController: TransactionViewCellDelegate {
    func showMapView(_ atm: String) {
        let mapVC = MapViewController()
        let coordinates = viewModel.getCoordinates(forATM: atm)
        if let firstCoordinate = coordinates.first {
            mapVC.latitude = firstCoordinate.latitude
            mapVC.longitude = firstCoordinate.longitude
        } else {
            print("No coordinates available for the ATM.")
        }
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.navigationController?.pushViewController(mapVC, animated: false)
        }
    }
}
