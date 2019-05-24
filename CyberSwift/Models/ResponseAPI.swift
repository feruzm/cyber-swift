//
//  ResponseAPI.swift
//  CyberSwift
//
//  Created by msm72 on 13.04.2018.
//  Copyright © 2018 Golos.io. All rights reserved.
//

import Foundation

/// [Multiple types](https://stackoverflow.com/questions/46759044/swift-structures-handling-multiple-types-for-a-single-property)
public struct Conflicted: Codable {
    public let stringValue: String?
    
    // Where we determine what type the value is
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        do {
            stringValue = try container.decode(String.self)
        } catch {
            do {
                stringValue = "\(try container.decode(Int64.self))"
            } catch {
                stringValue = ""
            }
        }
    }
    
    // We need to go back to a dynamic type, so based on the data we have stored, encode to the proper type
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(stringValue)
    }
}

public enum StatusState: String {
    case ok         =   "OK"
    case error      =   "Error"
    case offline    =   "Offline"
}


// MARK: -
public struct ResponseAPIErrorResult: Decodable {
    // MARK: - In work
    public let error: ResponseAPIError
    public let id: Int64
    public let jsonrpc: String
}


// MARK: -
public struct ResponseAPIError: Decodable {
    // MARK: - In work
    public let code: Int64
    public let message: String
    public let currentState: String?
}


// MARK: -
public struct ResponseAPIContentGetProfileResult: Decodable {
    // MARK: - In work API `content.getProfile`
    public let id: Int64
    public let jsonrpc: String
    public let result: ResponseAPIContentGetProfile?
    public let error: ResponseAPIError?
}


// MARK: -
public struct ResponseAPIContentGetProfile: Decodable {
    // MARK: - In work API `content.getProfile`
    public let subscriptions: ResponseAPIContentGetProfileSubscription?
    public let stats: ResponseAPIContentGetProfileStat
    public let userId: String
    public let username: String?
    public let registration: ResponseAPIContentGetProfileRegistration
    public let createdAt: String
    public let personal: ResponseAPIContentGetProfilePersonal
    public let subscribers: ResponseAPIContentGetProfileSubscriber?
    public let isSubscribed: Bool?
}

// MARK: -
public struct ResponseAPIContentGetProfileSubscription: Decodable {
    // MARK: - In work API `content.getProfile`
    public let userIds: [ResponseAPIContentGetProfileSubscriptionUserID?]?
    public let communities: [ResponseAPIContentGetProfileSubscriptionCommunity?]?
}


// MARK: -
public struct ResponseAPIContentGetProfileSubscriptionUserID: Decodable {
    // MARK: - In work API `content.getProfile`
    public let id: String
    public let avatarUrl: String?
}


// MARK: -
public struct ResponseAPIContentGetProfileSubscriptionCommunity: Decodable {
    // MARK: - In work API `content.getProfile`
    public let id: String
    public let name: String
    public let avatarUrl: String?
}


// MARK: -
public struct ResponseAPIContentGetProfileRegistration: Decodable {
    // MARK: - In work API `content.getProfile`
    public let time: String
}


// MARK: -
public struct ResponseAPIContentGetProfileStat: Decodable {
    // MARK: - In work API `content.getProfile`
    public let postsCount: Int64
    public let commentsCount: Int64
}


// MARK: -
public struct ResponseAPIContentGetProfilePersonal: Decodable {
    // MARK: - In work API `content.getProfile`
    public let contacts: ResponseAPIContentGetProfileContact?
    public let avatarUrl: String?
    public let coverUrl: String?
    public let biography: String?
}


// MARK: -
public struct ResponseAPIContentGetProfileSubscriber: Decodable {
    // MARK: - In work API `content.getProfile`
    public let usersCount: UInt64
    public let communitiesCount: UInt64
}


// MARK: -
public struct ResponseAPIContentGetProfileContact: Decodable {
    // MARK: - In work API `content.getProfile`
    public let facebook: String
    public let telegram: String
    public let whatsApp: String
    public let weChat: String
}


// MARK: -
public struct ResponseAPIContentGetProfileSubscribers: Decodable {
    public let usersCount: UInt64
    public let communitiesCount: UInt64
}


// MARK: -
public struct ResponseAPIContentGetFeedResult: Decodable {
    // MARK: - In work API `content.getFeed`
    public let id: Int64
    public let jsonrpc: String
    public let result: ResponseAPIContentGetFeed?
    public let error: ResponseAPIError?
}


// MARK: -
public struct ResponseAPIContentGetFeed: Decodable {
    // MARK: - In work API `content.getFeed`
    public let items: [ResponseAPIContentGetPost]?
    public let sequenceKey: String?
}


// MARK: -
public struct ResponseAPIContentGetPost: Decodable {
    // MARK: - In work API `content.getFeed`
    public let content: ResponseAPIContentGetPostContent
    public var votes: ResponseAPIContentGetPostVotes
    public let stats: ResponseAPIContentGetPostStats
    public let payout: ResponseAPIContentGetPostPayout
    public let contentId: ResponseAPIContentGetPostContentId
    public let meta: ResponseAPIContentGetPostMeta
    public let author: ResponseAPIContentGetPostAuthor?
    public let community: ResponseAPIContentGetPostCommunity
}


// MARK: -
public struct ResponseAPIContentGetPostContent: Decodable {
    // MARK: - In work API `content.getFeed`
    public let body: ResponseAPIContentGetPostContentBody
    public let title: String
    public let tags: [String?]?
    public let metadata: ResponseAPIContentGetPostContentMetadata?
    public let embeds: [ResponseAPIContentGetPostContentEmbed]
}


// MARK: -
public struct ResponseAPIContentGetPostContentBody: Decodable {
    // MARK: - In work API `content.getFeed`
    public let preview: String?
    
    // MARK: - In work API `content.getPost`
    public let full: String?
}


// MARK: -
public struct ResponseAPIContentGetPostContentMetadata: Decodable {
    // MARK: - In work API `content.getFeed`
    public let embeds: [ResponseAPIContentGetPostContentMetadataEmbed]?
    
    // MARK: - In work API `content.getPost`
}


// MARK: -
public struct ResponseAPIContentGetPostContentEmbed: Decodable {
    // MARK: - In work API `content.getFeed`
    public let _id: String
    public let id: String
    public let type: String
    public let result: ResponseAPIContentGetPostContentEmbedResult
}


// MARK: -
public struct ResponseAPIContentGetPostContentEmbedResult: Decodable {
    // MARK: - In work API `content.getFeed`
    public let type: String
    public let version: String
    public let title: String?
    public let url: String
    public let author: String?
    public let author_url: String?
    public let provider_name: String?
    public let description: String?
    public let thumbnail_url: String?
    public let thumbnail_width: UInt64?
    public let thumbnail_height: UInt64?
    public let html: String?
    public let content_length: UInt64?
}


// MARK: -
public struct ResponseAPIContentGetPostContentMetadataEmbed: Decodable {
    // MARK: - In work API `content.getFeed`
    public let url: String?
    public let result: ResponseAPIContentGetPostContentMetadataEmbedResult?
    public let id: Conflicted
    public let html: String?
    public let type: String?
}


// MARK: -
public struct ResponseAPIContentGetPostContentMetadataEmbedResult: Decodable {
    // MARK: - In work API `content.getFeed`
    public let type: String
    public let version: String
    public let title: String
    public let url: String
    public let author: String
    public let author_url: String
    public let provider_name: String
    public let description: String
    public let thumbnail_url: String
    public let thumbnail_width: UInt16
    public let thumbnail_height: UInt16
    public let html: String
}


// MARK: -
public struct ResponseAPIContentGetPostVotes: Decodable {
    // MARK: - In work API `content.getFeed`
    public let upCount: UInt64?
    public let downCount: UInt64?
    public var hasUpVote: Bool
    public var hasDownVote: Bool
}


// MARK: -
public struct ResponseAPIContentGetPostStats: Decodable {
    // MARK: - In work API `content.getFeed`
    public let wilson: ResponseAPIContentGetPostStatsWilson?
    public let commentsCount: UInt64
}


// MARK: -
public struct ResponseAPIContentGetPostStatsWilson: Decodable {
    // MARK: - In work API `content.getFeed`
    public let hot: Double
    public let trending: Double
}


// MARK: -
public struct ResponseAPIContentGetPostPayout: Decodable {
    // MARK: - In work API `content.getFeed`
    public let rShares: Conflicted
}


// MARK: -
public struct ResponseAPIContentGetPostContentId: Decodable {
    // MARK: - In work API `content.getFeed`
    public let userId: String
    public let permlink: String
    public let refBlockNum: UInt64?
}


// MARK: -
public struct ResponseAPIContentGetPostMeta: Decodable {
    // MARK: - In work API `content.getFeed`
    public let time: String
}


// MARK: -
public struct ResponseAPIContentGetPostAuthor: Decodable {
    // MARK: - In work API `content.getFeed`
    public let userId: String
    public let username: String?
}


// MARK: -
public struct ResponseAPIContentGetPostCommunity: Decodable {
    // MARK: - In work API `content.getFeed`
    public let id: String
    public let name: String
    public let avatarUrl: String?
}


// MARK: -
public struct ResponseAPIContentGetPostResult: Decodable {
    // MARK: - In work API `content.getPost`
    public let id: Int64
    public let jsonrpc: String
    public let result: ResponseAPIContentGetPost?
    public let error: ResponseAPIError?
}


// MARK: -
public struct ResponseAPIContentGetCommentsResult: Decodable {
    // MARK: - In work API `content.getComments`
    public let id: Int64
    public let jsonrpc: String
    public let result: ResponseAPIContentGetComments?
    public let error: ResponseAPIError?
}


// MARK: -
public struct ResponseAPIContentGetComments: Decodable {
    // MARK: - In work API `content.getComments`
    public let items: [ResponseAPIContentGetComment]?
    public let sequenceKey: String?
}


// MARK: -
public struct ResponseAPIContentGetComment: Decodable {
    // MARK: - In work API `content.getComments`
    public let content: ResponseAPIContentGetCommentContent
    public let votes: ResponseAPIContentGetCommentVotes
    public let payout: ResponseAPIContentGetCommentPayout
    public let contentId: ResponseAPIContentGetCommentContentId
    public let meta: ResponseAPIContentGetCommentMeta
    public let author: ResponseAPIContentGetCommentAuthor?
    public let parent: ResponseAPIContentGetCommentParent
    public let parentComment: ResponseAPIContentGetCommentParentComment?
}


// MARK: -
public struct ResponseAPIContentGetCommentContent: Decodable {
    // MARK: - In work API `content.getComments`
    public let body: ResponseAPIContentGetCommentContentBody
    public let metadata: ResponseAPIContentGetCommentContentMetadata?
    public let embeds: [ResponseAPIContentGetCommentContentEmbed]}


// MARK: -
public struct ResponseAPIContentGetCommentContentBody: Decodable {
    // MARK: - In work API `content.getComments`
    public let preview: String?
    public let full: String?
}


// MARK: -
public struct ResponseAPIContentGetCommentContentMetadata: Decodable {
    // MARK: - In work API `content.getComments`
    public let app: String
    public let format: String
    public let tags: [String]
}


// MARK: -
public struct ResponseAPIContentGetCommentContentEmbed: Decodable {
    // MARK: - In work API `content.getComments`
    public let _id: String
    public let id: String
    public let type: String
    public let result: ResponseAPIContentGetCommentContentEmbedResult
}


// MARK: -
public struct ResponseAPIContentGetCommentContentEmbedResult: Decodable {
    // MARK: - In work API `content.getComments`
    public let type: String
    public let version: String
    public let title: String
    public let url: String
    public let author: String
    public let author_url: String
    public let provider_name: String
    public let description: String
    public let thumbnail_url: String
    public let thumbnail_width: UInt64
    public let thumbnail_height: UInt64
    public let html: String
}


// MARK: -
public struct ResponseAPIContentGetCommentVotes: Decodable {
    // MARK: - In work API `content.getComments`
    public let upCount: UInt64?
    public let downCount: UInt64?
    public let hasUpVote: Bool
    public let hasDownVote: Bool
}


// MARK: -
public struct ResponseAPIContentGetCommentPayout: Decodable {
    // MARK: - In work API `content.getComments`
    public let rShares: UInt64
}


// MARK: -
public struct ResponseAPIContentGetCommentContentId: Decodable {
    // MARK: - In work API `content.getComments`
    public let userId: String
    public let permlink: String
    public let refBlockNum: UInt64?
}


// MARK: -
public struct ResponseAPIContentGetCommentMeta: Decodable {
    // MARK: - In work API `content.getComments`
    public let time: String
}


// MARK: -
public struct ResponseAPIContentGetCommentAuthor: Decodable {
    // MARK: - In work API `content.getComments`
    public let userId: String
    public let username: String?
}


// MARK: -
public struct ResponseAPIContentGetCommentParent: Decodable {
    // MARK: - In work API `content.getComments`
    public let post: ResponseAPIContentGetCommentParentPost?
    public let comment: ResponseAPIContentGetCommentParentComment?
}


// MARK: -
public struct ResponseAPIContentGetCommentParentComment: Decodable {
    // MARK: - In work API `content.getComments`
    public let contentId: ResponseAPIContentGetCommentParentCommentContentId?
    public let content: ResponseAPIContentGetCommentParentCommentContent?
    public let author: ResponseAPIContentGetCommentParentCommentAuthor?
}


// MARK: -
public struct ResponseAPIContentGetCommentParentCommentContentId: Decodable {
    // MARK: - In work API `content.getComments`
    public let userId: String
    public let permlink: String
    public let refBlockNum: UInt64?
}


// MARK: -
public struct ResponseAPIContentGetCommentParentCommentContent: Decodable {
    // MARK: - In work API `content.getComments`
    public let body: ResponseAPIContentGetCommentParentCommentContentBody?
}


// MARK: -
public struct ResponseAPIContentGetCommentParentCommentContentBody: Decodable {
    // MARK: - In work API `content.getComments`
    public let preview: String?
}


// MARK: -
public struct ResponseAPIContentGetCommentParentCommentAuthor: Decodable {
    // MARK: - In work API `content.getComments`
    public let userId: String
}


// MARK: -
public struct ResponseAPIContentGetCommentParentPost: Decodable {
    // MARK: - In work API `content.getComments` by user
    public let content: ResponseAPIContentGetCommentParentPostContent?
    public let community: ResponseAPIContentGetCommentParentPostCommunity?
    
    // MARK: - In work API `content.getComments` by post
    public let contentId: ResponseAPIContentGetCommentContentId?
}


// MARK: -
public struct ResponseAPIContentGetCommentParentPostContent: Decodable {
    // MARK: - In work API `content.getComments`
    public let title: String
}


// MARK: -
public struct ResponseAPIContentGetCommentParentPostCommunity: Decodable {
    // MARK: - In work API `content.getComments`
    public let id: String
    public let name: String
    public let avatarUrl: String?
}


// MARK: -
public struct ResponseAPIAuthAuthorizeResult: Decodable {
    // MARK: - In work API `auth.authorize`
    public let id: Int64
    public let jsonrpc: String
    public let result: ResponseAPIAuthAuthorize?
    public let error: ResponseAPIError?
}


// MARK: -
public struct ResponseAPIAuthAuthorize: Decodable {
    // MARK: - In work API `auth.authorize`
    public let user: String
    public let displayName: String
    public let roles: [ResponseAPIAuthAuthorizeRole]?
    public let permission: String
}


// MARK: -
public struct ResponseAPIAuthAuthorizeRole: Decodable {
    // MARK: - In work API `auth.authorize`
    //    public let title: String?
}


// MARK: -
public struct ResponseAPIAuthGenerateSecretResult: Decodable {
    // MARK: - In work API `auth.authorize`
    public let id: Int64
    public let jsonrpc: String
    public let result: ResponseAPIAuthGenerateSecret?
    public let error: ResponseAPIError?
}


// MARK: -
public struct ResponseAPIAuthGenerateSecret: Decodable {
    // MARK: - In work API `auth.authorize`
    public let secret: String
}


// MARK: -
public struct ResponseAPIRegistrationGetStateResult: Decodable {
    // MARK: - In work API `registration.getState`
    public let id: Int64
    public let jsonrpc: String
    public let result: ResponseAPIRegistrationGetState?
    public let error: ResponseAPIError?
}


// MARK: -
public struct ResponseAPIRegistrationGetState: Decodable {
    // MARK: - In work API `registration.getState`
    public let currentState: String
}


// MARK: -
public struct ResponseAPIRegistrationFirstStepResult: Decodable {
    // MARK: - In work API `registration.firstStep`
    public let id: Int64
    public let jsonrpc: String
    public let result: ResponseAPIRegistrationFirstStep?
    public let error: ResponseAPIError?
}


// MARK: -
public struct ResponseAPIRegistrationFirstStep: Decodable {
    // MARK: - In work API `registration.firstStep`
    public let code: UInt64
    public let strategy: String
    public let nextSmsRetry: String
    
    public init(code: UInt64 = 0, strategy: String = "", nextSmsRetry: String = "") {
        self.code           =   code
        self.strategy       =   strategy
        self.nextSmsRetry   =   nextSmsRetry
    }
}


// MARK: -
public struct ResponseAPIRegistrationVerifyResult: Decodable {
    // MARK: - In work API `registration.verify`
    public let id: Int64
    public let jsonrpc: String
    public let result: ResponseAPIRegistrationVerify?
    public let error: ResponseAPIError?
}


// MARK: -
public struct ResponseAPIRegistrationVerify: Decodable {
    // MARK: - In work API `registration.verify`
    public let status: String
}


// MARK: -
public struct ResponseAPIRegistrationSetUsernameResult: Decodable {
    // MARK: - In work API `registration.setUsername`
    public let id: Int64
    public let jsonrpc: String
    public let result: ResponseAPIRegistrationSetUsername?
    public let error: ResponseAPIError?
}


// MARK: -
public struct ResponseAPIRegistrationSetUsername: Decodable {
    // MARK: - In work API `registration.setUsername`
    public let status: String
}


// MARK: -
public struct ResponseAPIResendSmsCodeResult: Decodable {
    // MARK: - In work API `registration.resendSmsCode`
    public let id: Int64
    public let jsonrpc: String
    public let result: ResponseAPIResendSmsCode?
    public let error: ResponseAPIError?
}


// MARK: -
public struct ResponseAPIResendSmsCode: Decodable {
    // MARK: - In work API `registration.resendSmsCode`
    public let nextSmsRetry: String
    public let code: UInt64
}


// MARK: -
public struct ResponseAPIRegistrationToBlockChainResult: Decodable {
    // MARK: - In work API `registration.toBlockChain`
    public let id: Int64
    public let jsonrpc: String
    public let result: ResponseAPIRegistrationToBlockChain?
    public let error: ResponseAPIError?
}


// MARK: -
public struct ResponseAPIRegistrationToBlockChain: Decodable {
    // MARK: - In work API `registration.toBlockChain`
    public let status: String
}


// MARK: -
public struct ResponseAPIPushHistoryFreshResult: Decodable {
    // MARK: - In work API `push.historyFresh`
    public let id: Int64
    public let jsonrpc: String
    public let result: ResponseAPIPushHistoryFresh?
    public let error: ResponseAPIError?
}


// MARK: -
public struct ResponseAPIPushHistoryFresh: Decodable {
    // MARK: - In work API `push.historyFresh`
    //    public let status: String
}


// MARK: -
public struct ResponseAPIOnlineNotifyHistoryResult: Decodable {
    // MARK: - In work API `onlineNotify.history`
    public let jsonrpc: String
    public let result: ResponseAPIOnlineNotifyHistory?
    public let error: ResponseAPIError?
}


// MARK: -
public struct ResponseAPIOnlineNotifyHistory: Decodable {
    // MARK: - In work API `onlineNotify.history`
    public let total: Int64
    public let data: [ResponseAPIOnlineNotificationData]
}


// MARK: -
public struct ResponseAPIOnlineNotificationData: Decodable {
    public let _id: String
    public let timestamp: String
    public let eventType: String
    public let fresh: Bool
    public let unread: Bool
    
    public let community: ResponseAPIOnlineNotificationDataComunity?
    public let actor: ResponseAPIOnlineNotificationDataActor?
    public let post: ResponseAPIOnlineNotificationDataPost?
    public let comment: ResponseAPIOnlineNotificationDataComment?
    public let value: ResponseAPIOnlineNotificationDataValue?
    
}


// MARK: -
public struct ResponseAPIOnlineNotificationDataComunity: Decodable {
    public let id: String
    public let name: String
}


// MARK: -
public struct ResponseAPIOnlineNotificationDataActor: Decodable {
    public let id: String
    public let avatarUrl: String?
}


// MARK: -
public struct ResponseAPIOnlineNotificationDataPost: Decodable {
    public let contentId: ResponseAPIOnlineNotificationDataPostContentId
    public let title: String
}


// MARK: -
public struct ResponseAPIOnlineNotificationDataPostContentId: Decodable {
    public let userId: String
    public let permlink: String
    public let refBlockNum: UInt64?
}


// MARK: -
public struct ResponseAPIOnlineNotificationDataComment: Decodable {
    public let contentId: ResponseAPIOnlineNotificationDataCommentContentId
    public let body: String
}


// MARK: -
public struct ResponseAPIOnlineNotificationDataCommentContentId: Decodable {
    public let userId: String
    public let permlink: String
    public let refBlockNum: Int64?
}

public struct ResponseAPIOnlineNotificationDataValue: Decodable {
    public let amount: String
    public let currency: String
}

// MARK: -
public struct ResponseAPIOnlineNotifyHistoryFreshResult: Decodable {
    public let jsonrpc: String
    public let id: UInt64
    public let result: ResponseAPIOnlineNotifyHistoryFresh?
    public let error: ResponseAPIError?
}


// MARK: -
public struct ResponseAPIOnlineNotifyHistoryFresh: Decodable {
    public let fresh: UInt16
    public let freshByTypes: ResponseAPIOnlineNotifyHistoryFreshFreshByTypes
}


// MARK: -
public struct ResponseAPIOnlineNotifyHistoryFreshFreshByTypes: Decodable {
    public let summary: UInt16
    public let upvote: UInt16
    public let downvote: UInt16
    public let transfer: UInt16
    public let reply: UInt16
    public let subscribe: UInt16
    public let unsubscribe: UInt16?
    public let mention: UInt16
    public let repost: UInt16
    public let reward: UInt16
    public let curatorReward: UInt16
    public let message: UInt16?
    public let witnessVote: UInt16?
    public let witnessCancelVote: UInt16?
}


// MARK: -
public struct ResponseAPINotifyMarkAllAsViewedResult: Decodable {
    public let jsonrpc: String
    public let id: UInt16
    public let result: ResponseAPINotifyMarkAllAsViewed?
    public let error: ResponseAPIError?
}


// MARK: -
public struct ResponseAPINotifyMarkAllAsViewed: Decodable {
    public let status: String
}


// MARK: -
public struct ResponseAPIGetOptionsResult: Decodable {
    public let jsonrpc: String
    public let id: UInt16
    public let result: ResponseAPIGetOptions?
    public let error: ResponseAPIError?
}


// MARK: -
public struct ResponseAPIGetOptions: Decodable {
    public let basic: ResponseAPIGetOptionsBasic
    public let notify: ResponseAPIGetOptionsNotify
    public let push: ResponseAPIGetOptionsNotifyPush
}


// MARK: -
public struct ResponseAPIGetOptionsBasic: Decodable {
    public let language: String
    public let nsfwContent: String
}


// MARK: -
public struct ResponseAPIGetOptionsNotify: Decodable {
    public let show: ResponseAPIGetOptionsNotifyShow
}


// MARK: -
public struct ResponseAPIGetOptionsNotifyShow: Decodable {
    public let upvote: Bool
    public let downvote: Bool
    public let transfer: Bool
    public let reply: Bool
    public let subscribe: Bool
    public let unsubscribe: Bool
    public let mention: Bool
    public let repost: Bool
    public let reward: Bool
    public let curatorReward: Bool
    public let message: Bool
    public let witnessVote: Bool
    public let witnessCancelVote: Bool
}


// MARK: -
public struct ResponseAPIGetOptionsNotifyPush: Decodable {
    public let lang: String
    public let show: ResponseAPIGetOptionsNotifyPushShow
}


// MARK: -
public struct ResponseAPIGetOptionsNotifyPushShow: Decodable {
    public let upvote: Bool
    public let downvote: Bool
    public let transfer: Bool
    public let reply: Bool
    public let subscribe: Bool
    public let unsubscribe: Bool
    public let mention: Bool
    public let repost: Bool
    public let reward: Bool
    public let curatorReward: Bool
    public let message: Bool
    public let witnessVote: Bool
    public let witnessCancelVote: Bool
}


// MARK: -
public struct ResponseAPISetOptionsBasicResult: Decodable {
    public let jsonrpc: String
    public let id: UInt16
    public let result: ResponseAPISetOptionsBasic?
    public let error: ResponseAPIError?
}


// MARK: -
public struct ResponseAPISetOptionsBasic: Decodable {
    public let status: String
}


// MARK: -
public struct ResponseAPISetOptionsNoticeResult: Decodable {
    public let jsonrpc: String
    public let id: UInt16
    public let result: ResponseAPISetOptionsNotice?
    public let error: ResponseAPIError?
}


// MARK: -
public struct ResponseAPISetOptionsNotice: Decodable {
    public let status: String
}


// MARK: -
public struct ResponseAPIMarkNotifiesAsReadResult: Decodable {
    public let jsonrpc: String
    public let id: UInt16
    public let result: ResponseAPIMarkNotifiesAsRead?
    public let error: ResponseAPIError?
}


// MARK: -
public struct ResponseAPIMarkNotifiesAsRead: Decodable {
    public let status: String
}


// MARK: -
public struct ResponseAPIMetaRecordPostViewResult: Decodable {
    public let jsonrpc: String
    public let id: UInt16
    public let result: ResponseAPIMetaRecordPostView?
    public let error: ResponseAPIError?
}


// MARK: -
public struct ResponseAPIMetaRecordPostView: Decodable {
    public let status: String
}
