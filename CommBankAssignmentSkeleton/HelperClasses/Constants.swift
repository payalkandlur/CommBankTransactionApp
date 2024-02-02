//  Copyright (c) 2022 Commonwealth Bank. All rights reserved.

import Foundation

enum Constants {
    enum ApiConstant {
        //Api endpoint to get the the transaction response
        static let transactionsUrl = "https://www.dropbox.com/s/tewg9b71x0wrou9/data.json?dl=1"
    }
    enum StringConstant {
        static let available_funds = "Available Funds"
        static let available_balance = "Available Balance"
    }
    
    enum ColorConstants {
        static let headerBackgroundColor = "headerBackgroundColor"
        static let stackBackgroundColor = "stackBackgroundColor"
        static let accountDetailLabelColor = "accountDetailLabelColor"
        static let dateViewYellow = "dateViewYellow"
        static let textColorBlack = "textColorBlack"
        static let backgroundWhite = "backgroundWhite"
    }
    
    enum OffsetConstants {
        static let offset15: CGFloat = 15
        static let offset10: CGFloat = 10
    }
    
}
