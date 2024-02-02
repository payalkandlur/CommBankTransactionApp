//  Copyright (c) 2022 Commonwealth Bank. All rights reserved.

import UIKit

class AccountDetailsTableHeader: UIView {

    let accountView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: Constants.ColorConstants.backgroundWhite)
        return view
    }()

    let accountInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: Constants.ColorConstants.stackBackgroundColor)
        return view
    }()

    let walletImg : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .center
        return imgView
    }()

    let accountAccessLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: Constants.ColorConstants.textColorBlack)
        lbl.font = Font.helveticaNeue_light18
        return lbl
    }()

    let accountNumber: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: Constants.ColorConstants.accountDetailLabelColor)
        lbl.font = Font.helveticaNeue_light16
        return lbl
    }()

    let availableFunds: UILabel = {
        let lbl = UILabel()
        lbl.text = Constants.StringConstant.available_funds
        lbl.textColor = UIColor(named: Constants.ColorConstants.accountDetailLabelColor)
        lbl.font = Font.helveticaNeue_light16
        lbl.textAlignment = .left
        return lbl
    }()

    let availableBalance: UILabel = {
        let lbl = UILabel()
        lbl.text = Constants.StringConstant.available_balance
        lbl.textColor = UIColor(named: Constants.ColorConstants.accountDetailLabelColor)
        lbl.font = Font.helveticaNeue_light16
        lbl.textAlignment = .left
        return lbl
    }()

    let availableFundsValue: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: Constants.ColorConstants.textColorBlack)
        lbl.font = Font.helveticaNeue_Bold16
        lbl.textAlignment = .right
        return lbl
    }()

    let availableBalanceValue: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: Constants.ColorConstants.accountDetailLabelColor)
        lbl.font = Font.helveticaNeue_Bold16
        lbl.textAlignment = .right
        return lbl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureViews() {
        backgroundColor = UIColor(named: Constants.ColorConstants.headerBackgroundColor)

        let placeholderStackView = UIStackView(arrangedSubviews: [accountView, accountInfoView])
        placeholderStackView.distribution = .fillEqually
        placeholderStackView.axis = .vertical
        placeholderStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderStackView)

        NSLayoutConstraint.activate([
            placeholderStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.OffsetConstants.offset15),
            placeholderStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.OffsetConstants.offset15),
            placeholderStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.OffsetConstants.offset15),
            placeholderStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.OffsetConstants.offset15)
        ])

        let accountStack = UIStackView(arrangedSubviews: [accountAccessLbl, accountNumber])
        accountStack.distribution = .fill
        accountStack.axis = .vertical
        accountStack.spacing = 5
        accountStack.translatesAutoresizingMaskIntoConstraints = false
        walletImg.setContentHuggingPriority(UILayoutPriority.init(rawValue: 1000), for: .horizontal)
        walletImg.image = UIImage(named: "accountsimagetransactional")

        let accountIconStack = UIStackView(arrangedSubviews: [walletImg, accountStack])
        accountIconStack.distribution = .fill
        accountIconStack.axis = .horizontal
        accountIconStack.spacing = 25
        accountIconStack.translatesAutoresizingMaskIntoConstraints = false
        accountView.addSubview(accountIconStack)

        NSLayoutConstraint.activate([
            accountIconStack.leadingAnchor.constraint(equalTo: accountView.leadingAnchor, constant: Constants.OffsetConstants.offset10),
            accountIconStack.trailingAnchor.constraint(equalTo: accountView.trailingAnchor, constant: -Constants.OffsetConstants.offset10),
            accountIconStack.topAnchor.constraint(equalTo: accountView.topAnchor, constant: Constants.OffsetConstants.offset10),
            accountIconStack.bottomAnchor.constraint(equalTo: accountView.bottomAnchor, constant: -Constants.OffsetConstants.offset15)
        ])

        let availableFundStack = UIStackView(arrangedSubviews: [availableFunds, availableFundsValue])
        availableFundStack.distribution = .fillEqually
        availableFundStack.axis = .horizontal

        let availableBalanceStack = UIStackView(arrangedSubviews: [availableBalance, availableBalanceValue])
        availableBalanceStack.distribution = .fillEqually
        availableBalanceStack.axis = .horizontal
        
        let accountInfoViewStack = UIStackView(arrangedSubviews: [availableFundStack, availableBalanceStack])
        accountInfoViewStack.distribution = .fillEqually
        accountInfoViewStack.axis = .vertical
        accountInfoViewStack.translatesAutoresizingMaskIntoConstraints = false
        accountInfoView.addSubview(accountInfoViewStack)

        NSLayoutConstraint.activate([
            accountInfoViewStack.leadingAnchor.constraint(equalTo: accountInfoView.leadingAnchor, constant: 75),
            accountInfoViewStack.topAnchor.constraint(equalTo: accountInfoView.topAnchor, constant: 5),
            accountInfoViewStack.trailingAnchor.constraint(equalTo: accountInfoView.trailingAnchor, constant: -25),
            accountInfoViewStack.bottomAnchor.constraint(equalTo: accountInfoView.bottomAnchor, constant: -5),
        ])
    }

    func updateAccountDetails(account: Account?) {
        if let accountData = account {
            accountAccessLbl.text = accountData.accountName
            accountNumber.text = accountData.accountNumber
            availableFundsValue.text = accountData.available?.formatDoubleAsCurrency()
            availableBalanceValue.text = accountData.balance?.formatDoubleAsCurrency()
        }
    }
}
