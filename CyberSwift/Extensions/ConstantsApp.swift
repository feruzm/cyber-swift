//
//  ConstantsApp.swift
//  CyberSwift
//
//  Created by msm72 on 1/28/19.
//  Copyright © 2019 golos.io. All rights reserved.
//

import Starscream
import Foundation

public struct Config {
    /// Pagination
    public static let paginationLimit: Int8 = 20
    
    static let blocksBehind: Int = 3
    static let expireSeconds: Double = 30.0
    
    public static var isPublicTestnet: Bool             =   true
    static let CHAIN_CYBERWAY_API_BASE_URL: String      =   isPublicTestnet ? "http://46.4.96.246:8888/" : "http://159.69.85.233:8888/"
    
    /// Websocket
    static public var webSocketSecretKey: String        =   "Cyberway"
    
    public static var currentUser: (nickName: String?, activeKey: String?) {
        set { }
        
        get {
            return (nickName:   KeychainManager.loadData(forUserNickName: Config.currentUserNickNameKey, withKey: Config.currentUserNickNameKey)?[Config.currentUserNickNameKey] as? String,
                    activeKey:  KeychainManager.loadData(forUserNickName: Config.currentUserActiveKey, withKey: Config.currentUserActiveKey)?[Config.currentUserActiveKey] as? String)
        }
    }
    
    public static var currentVoter                      =   (nickName: Config.accountNickTest, activeKey: Config.activeKeyTest)
    public static var currentAuthor                     =   (nickName: Config.accountNickTest, activeKey: Config.activeKeyTest)
    
    // Accounts test values
    public static let accountNickDestroyer2k: String    =   "destroyer2k"
    public static let activeKeyDestroyer2k: String      =   "5JagnCwCrB2sWZw6zCvaBw51ifoQuNaKNsDovuGz96wU3tUw7hJ"
    public static let postingKeyDestroyer2k: String     =   "5JjQWZmWj36xbVdcX96gjMs5BRip7TPPCNFFnm19TPEviqnG5Ke"
    
    static let accountNickMsm72: String                 =   "msm72"
    static let postingKeyMsm72: String                  =   "5Jj6qFdJLGKFFFQbfTwv6JNQmXzCidnjgSFNYKhrgqhzigH4sFp"
    
    static let accountNickNickLick: String              =   "nick.lick"
    static let postingKeyNickLick: String               =   "5HuxaRnfHNTS4HA5EA5SQPqAZogP2GoCuZR2yuL1jdfoqjLZAFD"
    
    static let accountNickYoyoyoyo: String              =   "yoyoyoyo"
    static let postingKeyYoyoyoyo: String               =   "5KUk2QMqYqpFM54YSaNoYLVDTznM3fyA8J8qDUQQNgBnqvVyscC"
    
    static let accountNickJosephKalu: String            =   "joseph.kalu"
    static let postingKeyJosephKalu: String             =   "5K6CfG8gzhTZNwHDxPmeQiPChx6FpgiVYN7USVp2aGC2WsDqH4h"
    
    // 159 testnet
    public static let accountNickTest: String           =   "vbjdktidppoq"  //"tst1dmkhfimy"
    public static let activeKeyTest: String             =   "5JA54JMgG4herXK85re6CSyPvmBs1X9EZ1qKwrqyrYVNaR1GKTS"    // "5J1JAhPhCZ78ysXxFPZFrjyHrhbs5ThY47GGk7ZKuZUYtabWXog"

    
    /// Check network connection
    public static var isNetworkAvailable: Bool {
        set { }
        
        get {
            return ReachabilityManager.connection()
        }
    }
    
    
    /// Keys
    static let userSecretKey: String                    =   "userSecretKey"
    public static let currentUserActiveKey: String      =   "currentUserActiveKey"
    public static let currentUserNickNameKey: String    =   "currentUserNickNameKey"
}

