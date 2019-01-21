//
//  User.swift
//  FirstCourseFinalTask
//
//  Created by Tom Belov on 18/01/2019.
//  Copyright © 2019 E-Legion. All rights reserved.
//

import Foundation
import FirstCourseFinalTaskChecker

public class User: UserProtocol {
    public var id: Identifier
    public var username: String
    public var fullName: String
    public var avatarURL: URL?
    public var currentUserFollowsThisUser: Bool
    public var currentUserIsFollowedByThisUser: Bool
    public var followsCount: Int
    public var followedByCount: Int

    public init(
        id: Identifier,
        username: String,
        fullName: String,
        avatarURL: URL?,
        currentUserFollowsThisUser: Bool,
        currentUserIsFollowedByThisUser: Bool,
        followsCount: Int,
        followedByCount: Int
        ) {
        self.id = id
        self.username = username
        self.fullName = fullName
        self.avatarURL = avatarURL
        self.currentUserFollowsThisUser = currentUserFollowsThisUser
        self.currentUserIsFollowedByThisUser = currentUserIsFollowedByThisUser
        self.followsCount = followsCount
        self.followedByCount = followedByCount
    }
}
