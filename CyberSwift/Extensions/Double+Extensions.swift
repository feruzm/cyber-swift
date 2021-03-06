//
//  Double.swift
//  CyberSwift
//
//  Created by Chung Tran on 1/29/20.
//  Copyright © 2020 Commun Limited. All rights reserved.
//

import Foundation

extension Double {
    public var readableString: String {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = false
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = (self < 1000) ? 4 : 2
        return formatter.string(from: self as NSNumber) ?? "0"
    }
    
    public var currencyValueFormatted: String {
        let formatter = NumberFormatter()
        formatter.groupingSize = 3
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        formatter.locale = Locale(identifier: "en")

        if self > 1000 {
            formatter.maximumFractionDigits = 2
        } else if self < 100 {
            formatter.maximumFractionDigits = 3
        } else {
            formatter.maximumFractionDigits = 2
        }
        
        return (formatter.string(from: self as NSNumber) ?? "0").replacingOccurrences(of: ",", with: " ")
    }
}
