//
//  DateDetailsHeader.swift
//  CommBankAssignmentSkeleton
//
//  Created by Payal Kandlur on 1/31/24.
//

import Foundation
import UIKit

class DateDetailsHeader: UITableViewHeaderFooterView {
    
    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var dateLabel: UILabel = {
            let label = UILabel()
            label.backgroundColor = .clear
        label.textColor = UIColor(named: Constants.ColorConstants.textColorBlack)
            label.font = Font.helveticaNeue_Bold16
            label.textAlignment = .left
            label.numberOfLines = .zero
            label.accessibilityIdentifier = AccessibilityIdentifiers.dateLabelIdentifier
            return label
        }()
    
    private lazy var daysLabel: UILabel = {
            let label = UILabel()
            label.backgroundColor = .clear
        label.textColor = .black
            label.font = Font.helveticaNeue_Bold16
            label.textAlignment = .right
            label.numberOfLines = .zero
            label.accessibilityIdentifier = AccessibilityIdentifiers.daysLabelIdentifier
            return label
        }()
    
    func setupUI(_ effectiveDate: String) {
        contentView.addSubview(dateStackView)
        configureDateStackView()
        dateLabel.text = effectiveDate.convertDateString()
        daysLabel.text = (effectiveDate.calculateDaysFromNow() ?? "-") + " days ago"
    }
    
    private func configureDateStackView() {
        [
            dateLabel,
            daysLabel
        ].forEach(dateStackView.addArrangedSubview)
        dateStackView.backgroundColor = UIColor(named: Constants.ColorConstants.dateViewYellow)
        
        NSLayoutConstraint.activate([
            dateStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dateStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            
        ])
        
        configureDateLabels()
    }
    
    private func configureDateLabels() {
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.OffsetConstants.offset15),
            daysLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -Constants.OffsetConstants.offset15),
            dateLabel.heightAnchor.constraint(equalToConstant: 24),
            daysLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
