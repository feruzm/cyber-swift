//
//  CurrentUser.swift
//  CyberSwift
//
//  Created by Chung Tran on 02/07/2019.
//  Copyright © 2019 golos.io. All rights reserved.
//

import Foundation

public struct CurrentUser {
    // Main properties
    public let id: String?
    public var name: String?
    public var activeKey: String? {
        return activeKeys?.privateKey
    }
    
    // Passcode
    public var passcode: String?
    
    // Registration keys
    public var registrationStep: CurrentUserRegistrationStep?
    public var phoneNumber: String?
    public var smsCode: UInt64?
    public var smsNextRetry: String?
    
    // UsersKey
    public var memoKeys: UserKeys?
    public var ownerKeys: UserKeys?
    public var activeKeys: UserKeys?
    public var postingKeys: UserKeys?
    
    // Methods
    public static var loggedIn: Bool {
        return UserDefaults.standard.bool(forKey: Config.isCurrentUserLoggedKey)
    }
}

public struct UserKeys {
    public let privateKey: String?
    public let publicKey: String?
}

public enum CurrentUserRegistrationStep: String {
    case firstStep      = "firstStep"
    case verify         = "verify"
    case setUserName    = "setUsername"
    case toBlockChain   = "toBlockChain"
    case setPasscode    = "setPasscode"
    // FaceId = FaceId or TouchId (optional)
    case setFaceId      = "setFaceId"
    case backUpICloud   = "backUpICloud"
    case setAvatar      = "setAvatar"
    case setBio         = "setBio"
    case registered     = "registered"
}
