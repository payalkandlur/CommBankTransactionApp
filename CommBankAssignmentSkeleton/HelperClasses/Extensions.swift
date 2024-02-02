//
//  Colors.swift
//  CommBankAssignmentSkeleton
//
//  Created by Payal Kandlur on 1/31/24.
//

import Foundation
import UIKit

extension String {
    func convertDateString() -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy"
        
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMM yyyy"
            let formattedDateString = outputFormatter.string(from: date)
            return formattedDateString
        } else {
            print("Invalid date format.")
            return nil
        }
    }
    
    func calculateDaysFromNow() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        if let targetDate = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let currentDate = Date()
            
            let components = calendar.dateComponents([.day], from: targetDate, to: currentDate)
            if let days = components.day {
                return "\(days)"
            }
        }
        
        print("Invalid date format.")
        return nil
    }
    
    func attributedStringWithBoldText(boldText: String, boldFont: UIFont?) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let boldRange = (self as NSString).range(of: boldText)
        
        attributedString.addAttributes([.font: boldFont], range: boldRange)
        
        return attributedString
    }
}

extension Double {
    func formatDoubleAsCurrency() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "$"
        
        if let formattedString = numberFormatter.string(from: NSNumber(value: self)) {
            return formattedString
        } else {
            print("Error formatting double as currency.")
            return nil
        }
    }
    
}
