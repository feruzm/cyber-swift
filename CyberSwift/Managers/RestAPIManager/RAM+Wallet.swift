//
//  RAM+Wallet.swift
//  CyberSwift
//
//  Created by Chung Tran on 12/18/19.
//  Copyright © 2019 Commun Limited. All rights reserved.
//

import Foundation
import RxSwift

extension RestAPIManager {
    public func getTransferHistory(
        userId: String? = nil,
        direction: String = "all",
        transferType: String? = nil,
        symbol: String? = nil,
        reward: String? = nil,
        offset: UInt = 0,
        limit: UInt = 20
    ) -> Single<ResponseAPIWalletGetTransferHistory> {
        let methodAPIType = MethodAPIType.getTransferHistory(userId: userId, direction: direction, transferType: transferType, symbol: symbol, rewards: reward, offset: offset, limit: limit)
        return Broadcast.instance.executeGetRequest(methodAPIType: methodAPIType)
    }
    
    public func getBalance(
        userId: String? = nil
    ) -> Single<ResponseAPIWalletGetBalances> {
        let methodAPIType = MethodAPIType.getBalance(userId: userId)
        return Broadcast.instance.executeGetRequest(methodAPIType: methodAPIType)
    }
}