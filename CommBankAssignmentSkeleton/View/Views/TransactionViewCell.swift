//
//  TransactionCellView.swift
//  CommBankAssignmentSkeleton
//
//  Created by Payal Kandlur on 1/31/24.
//

import Foundation
import UIKit

protocol TransactionViewCellDelegate: AnyObject {
    func showMapView(_ atmId: String)
}

class TransactionViewCell: UITableViewCell {
    
    weak var delegate: TransactionViewCellDelegate?
    private var transactionAtmId: String = ""
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var locationButton : UIButton = {
        let button = UIButton(type: .system)
        button.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            self.showMapView()
        }), for: .touchUpInside)
        button.tintColor = .systemGray
        button.accessibilityIdentifier = AccessibilityIdentifiers.locationButtonIdentifier
        return button
    }()
    
    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var pendingLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = UIColor(named: Constants.ColorConstants.textColorBlack)
        label.font = Font.helveticaNeue_Bold16
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.accessibilityIdentifier = AccessibilityIdentifiers.pendingLabelIdentifier
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = UIColor(named: Constants.ColorConstants.textColorBlack)
        label.font = Font.helveticaNeue_light16
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.accessibilityIdentifier = AccessibilityIdentifiers.descriptionLabelIdentifier
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = UIColor(named: Constants.ColorConstants.textColorBlack)
        label.font = Font.helveticaNeue_Bold16
        label.textAlignment = .right
        label.numberOfLines = .zero
        label.accessibilityIdentifier = AccessibilityIdentifiers.amountLabelIdentifier
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func setupUI(_ transactionDetail: Transaction?, _ atmDetails: [ATM]?) {
        configureViews()
        let isPending = transactionDetail?.isPending ?? false
        pendingLabel.isHidden = !isPending
        let descriptionText = transactionDetail?.description?.replacingOccurrences(of: "<br/>", with: "\n")
        let attributedText = "PENDING: " + (descriptionText ?? "NA")
        descriptionLabel.attributedText = isPending ? attributedText.attributedStringWithBoldText(boldText: "PENDING:", boldFont: Font.helveticaNeue_Bold16) : descriptionText?.attributedStringWithBoldText(boldText: "", boldFont: Font.helveticaNeue_light16)
        amountLabel.text = transactionDetail?.amount?.formatDoubleAsCurrency()
        showHideLocatioButton(transactionDetail?.atmID)
        
    }
    
    private func showHideLocatioButton(_ atmId: String?) {
        if let atmID = atmId, !atmID.isEmpty {
            locationButton.setImage(UIImage(named: "FindUsIcon"), for: .normal)
            transactionAtmId = atmID
            locationButton.isHidden = false
        } else {
            locationButton.isHidden = true
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateButtonImageColor()
        }
    }
    
    private func updateButtonImageColor() {
        if traitCollection.userInterfaceStyle == .dark {
            locationButton.tintColor = .systemRed
        } else {
            locationButton.tintColor = .systemGray
        }
    }
    private func configureViews() {
        contentView.addSubview(contentStackView)
        configureContentStackView()
        configureDescriptionStackView()
    }
    
    private func configureContentStackView() {
        [
            locationButton,
            descriptionStackView,
            amountLabel
        ].forEach(contentStackView.addArrangedSubview)
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.OffsetConstants.offset15),
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.OffsetConstants.offset15),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -Constants.OffsetConstants.offset15),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.OffsetConstants.offset15)
        ])
        locationButton.setContentHuggingPriority(UILayoutPriority.init(rawValue: 1000), for: .horizontal)
        amountLabel.setContentHuggingPriority(UILayoutPriority.init(rawValue: 1000), for: .horizontal)
    }
    
    private func showMapView() {
        delegate?.showMapView(transactionAtmId)
    }
    
    private func configureDescriptionStackView() {
        [
            pendingLabel,
            descriptionLabel,
        ].forEach(descriptionStackView.addArrangedSubview)
    }
}
