//
//  ResponseAPI+CommiunityManager.swift
//  CyberSwift
//
//  Created by Chung Tran on 8/13/20.
//  Copyright © 2020 Commun Limited. All rights reserved.
//

import Foundation

// MARK: - content.getProposals
public struct ResponseAPIContentGetProposals: Decodable {
    public let items: [ResponseAPIContentGetProposal]
    public let proposalsCount: UInt64?
}

public struct ResponseAPIContentGetProposal: ListItemType {
    public let proposer: ResponseAPIContentGetProfile?
    public let proposalId: String
    public let type: String?
    public let contract: String?
    public let action: String?
    public let permission: String?
    public let blockTime: String?
    public let expiration: String?
    public let data: ResponseAPIContentGetProposalData?
    public let contentType: String?
    public let community: ResponseAPIContentGetCommunity?
    public let isApproved: Bool?
    public let approvesCount: UInt64?
    public let approvesNeed: UInt64?
    public var change: ResponseAPIContentGetProposalChange?
    
    // MARK: - Additional properties
    public var post: ResponseAPIContentGetPost?
    public var comment: ResponseAPIContentGetComment?
    
    public var postLoadingError: String?
    
    public var identity: String {
        proposalId
    }
    
    public func newUpdatedItem(from item: ResponseAPIContentGetProposal) -> ResponseAPIContentGetProposal? {
        ResponseAPIContentGetProposal(
            proposer: item.proposer ?? proposer,
            proposalId: item.proposalId,
            type: item.type ?? type,
            contract: item.contract ?? contract,
            action: item.action ?? action,
            permission: item.permission ?? permission,
            blockTime: item.blockTime ?? blockTime,
            expiration: item.expiration ?? expiration,
            data: item.data ?? data,
            contentType: item.contentType ?? contentType,
            community: item.community ?? community,
            isApproved: item.isApproved ?? isApproved,
            approvesCount: item.approvesCount ?? approvesCount,
            approvesNeed: item.approvesNeed ?? approvesNeed,
            change: item.change ?? change,
            post: item.post ?? post,
            comment: item.comment ?? comment,
            postLoadingError: item.postLoadingError
        )
    }
}

public struct ResponseAPIContentGetProposalData: Decodable, Equatable {
    public let commun_code: String?
    public let message_id: ResponseAPIContentGetProposalDataMessageId?
    public let description: String?
    public let language: String?
    public let rules: String?
    public let avatar_image: String?
    public let cover_image: String?
    public let subject: String?
}

public struct ResponseAPIContentGetProposalDataMessageId: Decodable, Equatable {
    public let author: String?
    public let permlink: String?
}

public struct ResponseAPIContentGetProposalChange: Decodable, Equatable {
    public let type: String?
    public let subType: String?
    public let old: ResponseAPIContentGetProposalChangeData?
    public let new: ResponseAPIContentGetProposalChangeData?
    
    // MARK: - Additional property
    public var isOldRuleCollapsed: Bool? = true
}

public struct ResponseAPIContentGetProposalChangeData: Decodable, Equatable {
    public var string: String?
    public var rules: ResponseAPIGetCommunityRule?
    
    // Where we determine what type the value is
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let rules = try? container.decode(ResponseAPIGetCommunityRule.self) {
            self.rules = rules
            return
        }
        
        string = try? container.decode(String.self)
    }
}

public struct ResponseAPIGetCommunityRule: Decodable, Equatable {
    public let _id: String?
    public let id: String?
    public let title: String?
    public let text: String?
}

// MARK: - content.getReportsList
public struct ResponseAPIContentGetReportsList: Decodable {
    public let items: [ResponseAPIContentGetReport]
    public let reportsCount: UInt64?
}

public struct ResponseAPIContentGetReport: ListItemType {
    init(type: String, post: ResponseAPIContentGetPost?, comment: ResponseAPIContentGetComment?) {
        self.type = type
        self.post = post
        self.comment = comment
    }
    
    public let type: String
    public var post: ResponseAPIContentGetPost?
    public var comment: ResponseAPIContentGetComment?
    
    public var identity: String {
        post?.identity ?? comment?.identity ?? String.randomString(length: 7)
    }
    
    enum CodingKeys: String, CodingKey  {
        case type
    }
    enum ParseError: Error {
        case notRecognizedType(Any)
    }
    
    // Where we determine what type the value is
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        
        let container2 = try decoder.singleValueContainer()
        switch type {
        case "post":
            post = try container2.decode(ResponseAPIContentGetPost.self)
        case "comment":
            comment = try container2.decode(ResponseAPIContentGetComment.self)
        default:
            throw ParseError.notRecognizedType(type)
        }
        
    }
    
    public func newUpdatedItem(from item: ResponseAPIContentGetReport) -> ResponseAPIContentGetReport? {
        guard item.type == type else {return nil}
        return ResponseAPIContentGetReport(type: item.type, post: item.post ?? post, comment: item.comment ?? comment)
    }
}

public struct ResponseAPIContentGetEntityReports: Decodable, Equatable {
    public let items: [ResponseAPIContentGetEntityReport]
}

public struct ResponseAPIContentGetEntityReport: Decodable, Equatable {
    public let reason: String
    public let author: ResponseAPIContentGetProfile
}
