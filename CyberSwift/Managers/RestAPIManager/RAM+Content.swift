//
//  RAM+Content.swift
//  CyberSwift
//
//  Created by Chung Tran on 11/11/19.
//  Copyright © 2019 Commun Limited. All rights reserved.
//

import Foundation
import RxSwift

extension RestAPIManager {
    // MARK: - Posts
    // API `content.getPosts`
    public func getPosts(
        userId: String?,
        communityId: String?,
        communityAlias: String? = nil,
        allowNsfw: Bool = false,
        type: FeedTypeMode,
        sortBy: FeedSortMode = .time,
        sortType: FeedTimeFrameMode? = nil,
        limit: UInt = UInt(Config.paginationLimit),
        offset: UInt = 0
    ) -> Single<ResponseAPIContentGetPosts> {
        let methodAPIType = MethodAPIType.getPosts(userId: userId, communityId: communityId, communityAlias: communityAlias, allowNsfw: allowNsfw, type: type, sortBy: sortBy, sortType: sortType, limit: limit, offset: offset)
        
        return executeGetRequest(methodAPIType: methodAPIType)
    }
    
    // API `content.getPost`
    public func loadPost(userId: String? = nil, username: String? = nil, permlink: String, communityId: String? = nil, communityAlias: String? = nil) -> Single<ResponseAPIContentGetPost> {
        
        let methodAPIType = MethodAPIType.getPost(userId: userId, username: username, permlink: permlink, communityId: communityId, communityAlias: communityAlias)
        
        return executeGetRequest(methodAPIType: methodAPIType)
    }
    
    // API `content.getComments` by post
    public func loadPostComments(
        sortBy: CommentSortMode         = .time,
        offset: UInt                    = 0,
        limit: UInt                     = UInt(Config.paginationLimit),
        userId: String?                 = Config.currentUser?.id,
        username: String?               = nil,
        permlink: String,
        communityId: String?            = nil,
        communityAlias: String?         = nil,
        parentCommentUserId: String?    = nil,
        parentCommentPermlink: String?  = nil,
        resolveNestedComments: Bool     = false
    ) -> Single<ResponseAPIContentGetComments> {
        
        var parentComment: [String: String]?
        if let parentCommentUserId = parentCommentUserId,
            let parentCommentPermlink = parentCommentPermlink {
            parentComment = [
                "userId": parentCommentUserId,
                "permlink": parentCommentPermlink
            ]
        }
        
        let methodAPIType = MethodAPIType.getComments(
            sortBy: sortBy,
            offset: offset,
            limit: limit,
            type: .post,
            userId: userId,
            username: username,
            permlink: permlink,
            communityId: communityId,
            communityAlias: communityAlias,
            parentComment: parentComment,
            resolveNestedComments: resolveNestedComments)
        
        return executeGetRequest(methodAPIType: methodAPIType)
    }
    
    // API `meta.recordPostView`
    public func recordPostView(permlink: String) -> Single<ResponseAPIStatus> {
        // Check user authorize
        guard Config.currentUser?.id != nil else { return .error(CMError.unauthorized())}

        let methodAPIType = MethodAPIType.recordPostView(permlink: permlink)
        
        return executeGetRequest(methodAPIType: methodAPIType)
    }
    
    // MARK: - Comments
    public func getRepliesForComment(
        forPost post: ResponseAPIContentId,
        parentComment: ResponseAPIContentId,
        offset: UInt                    = 0,
        limit: UInt                     = UInt(Config.paginationLimit)
    ) -> Single<ResponseAPIContentGetComments> {
        let methodAPIType = MethodAPIType.getComments(
            sortBy: .timeDesc,
            offset: offset,
            limit: limit,
            type: .post,
            userId: post.userId,
            permlink: post.permlink,
            communityId: post.communityId,
            communityAlias: nil,
            parentComment: [
                "userId": parentComment.userId,
                "permlink": parentComment.permlink
            ],
            resolveNestedComments: nil)
        return executeGetRequest(methodAPIType: methodAPIType)
    }
    
    // MARK: - Referal
    public func getReferralUsers(
        offset: UInt                    = 0,
        limit: UInt                     = UInt(Config.paginationLimit)
    ) -> Single<ResponseAPIContentGetReferralUsers> {
        let methodAPIType = MethodAPIType.getReferralUsers(limit: limit, offset: offset)
        return executeGetRequest(methodAPIType: methodAPIType)
    }
}
