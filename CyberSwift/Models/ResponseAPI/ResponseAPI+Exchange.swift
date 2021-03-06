//
//  ResponseAPI+Exchange.swift
//  CyberSwift
//
//  Created by Chung Tran on 1/20/20.
//  Copyright © 2020 Commun Limited. All rights reserved.
//

// MARK: - getCurrenciesFull
public struct ResponseAPIGetCurrency: ListItemType {
    public let name: String
    public let fullName: String?
    public let enabled: Bool
    public let fixRateEnabled: Bool
    public let extraIdName: String?
    public let addressUrl: String?
    public let transactionUrl: String?
    public let image: String?
    public let fixedTime: UInt64
    
    public var identity: String {
        return name
    }
    
    public func newUpdatedItem(from item: ResponseAPIGetCurrency) -> ResponseAPIGetCurrency? {
        return ResponseAPIGetCurrency(name: item.name, fullName: item.fullName ?? fullName, enabled: item.enabled, fixRateEnabled: item.fixRateEnabled, extraIdName: item.extraIdName, addressUrl: item.addressUrl ?? addressUrl, transactionUrl: item.transactionUrl ?? transactionUrl, image: item.image ?? image, fixedTime: item.fixedTime)
    }
}

// MARK: - getMinMaxAmount
public struct ResponseAPIGetMinMaxAmount: Decodable {
    public let minFromAmount: String
    public let maxToAmount: String
    
    public var minValue: Double {
        Double(minFromAmount) ?? 0
    }
    
    public var maxValue: Double {
        Double(maxToAmount) ?? 0
    }
}

public struct ResponseAPICreateTransaction: Decodable {
    public let id: String
    public let status: String
    public let currencyFrom: String
    public let currencyTo: String
    public let payinAddress: String
    public let payinExtraId: String?
    public let payoutAddress: String
    public let payoutExtraId: String?
    public let amountExpectedFrom: String
    public let amountExpectedTo: Double
    public let createdAt: String
}
