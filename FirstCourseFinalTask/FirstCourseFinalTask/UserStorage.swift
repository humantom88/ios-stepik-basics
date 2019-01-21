//
//  UserStorage.swift
//  FirstCourseFinalTask
//
//  Created by Tom Belov on 18/01/2019.
//  Copyright © 2019 E-Legion. All rights reserved.
//

import Foundation
import FirstCourseFinalTaskChecker

public class UsersStorage : UsersStorageProtocol {
    public var users: [User]
    public var followers: [(GenericIdentifier<UserProtocol>, GenericIdentifier<UserProtocol>)]
    public var currentUserID: GenericIdentifier<UserProtocol>
    public var count: Int {
        get {
            return self.users.count
        }
    }
    
    public func setFollowers(newFollowers: [(GenericIdentifier<UserProtocol>, GenericIdentifier<UserProtocol>)]) {
        self.followers = newFollowers
    }
    
    static func getFollowsCount(
        userId: GenericIdentifier<UserProtocol>,
        followers: [(GenericIdentifier<UserProtocol>, GenericIdentifier<UserProtocol>)]
        ) -> Int {
        return followers.filter {
            pair in
            let (to, _) = pair
            return to == userId
        }.count
    }
    
    static func getFollowedByCount(
        userId: GenericIdentifier<UserProtocol>,
        followers: [(GenericIdentifier<UserProtocol>, GenericIdentifier<UserProtocol>)]
        ) -> Int {
        return followers.filter {
            pair in
            let (_, who) = pair
            return who == userId
        }.count
    }
    
    static func getUserById(userId: GenericIdentifier<UserProtocol>, users: [UserProtocol]) -> UserProtocol? {
        return users.first {
            user in
            user.id == userId
        }
    }
    
    public required init? (
        users: [UserInitialData],
        followers: [(GenericIdentifier<UserProtocol>, GenericIdentifier<UserProtocol>)],
        currentUserID: GenericIdentifier<UserProtocol>
        ) {
        
        if (users.first { $0.id == currentUserID } == nil) {
            return nil
        }

        self.followers = followers
        
        self.currentUserID = currentUserID
        
        self.users = users.map {
            user in
            return User(
                id: user.id,
                username: user.username,
                fullName: user.fullName,
                avatarURL: user.avatarURL,
                currentUserFollowsThisUser: followers.filter({ $0.0 == currentUserID && $0.1 == user.id }).count > 0,
                currentUserIsFollowedByThisUser: followers.filter({ $0.0 == user.id && $0.1 == currentUserID }).count > 0,
                followsCount: followers.filter({ $0.0 == user.id }).count,
                followedByCount: followers.filter({ $0.1 == user.id}).count
            )
        }
    }
    
    public func currentUser() -> UserProtocol {
        return self.users.filter({ $0.id == self.currentUserID }).first!
    }
    
    public func user(with userID: GenericIdentifier<UserProtocol>) -> UserProtocol? {
        return self.users.first(where: { $0.id == userID })
    }
    
    public func findUsers(by searchString: String) -> [UserProtocol] {
        return self.users.filter { $0.username.contains(searchString) || $0.fullName.contains(searchString) }
    }
    
    public func follow(_ userIDToFollow: GenericIdentifier<UserProtocol>) -> Bool {
        if self.followers.filter({ $0.0 == userIDToFollow && $0.1 == self.currentUserID }).first != nil {
            return true
        }
        
        self.followers.append((self.currentUserID, userIDToFollow))
        
        if let user = self.users.filter({ $0.id == userIDToFollow }).first {
            user.followedByCount += 1
            if let currentUser = self.users.filter({ $0.id == self.currentUserID }).first {
                currentUser.followsCount += 1
            }
            
            return true
        } else {
            
            return false
        }
    }
    
    public func unfollow(_ userIDToUnfollow: GenericIdentifier<UserProtocol>) -> Bool {
        guard let user = self.users.filter({ $0.id == userIDToUnfollow }).first else {
            return false
        }
        
        guard let currentUser = self.users.filter({ $0.id == self.currentUserID }).first else {
            return false
        }
    
        user.followedByCount -= 1
        currentUser.followsCount -= 1

        self.setFollowers(newFollowers: self.followers.filter({ !($0.0 == currentUser.id && $0.1 == userIDToUnfollow) }))

        return true
    }
    
    func debugFollowers(followers: [(GenericIdentifier<UserProtocol>, GenericIdentifier<UserProtocol>)]){
        print("=== Debugging followers ===")
        followers.forEach {
            follower in
            
            print("""
                I'm: \(follower.0.rawValue)
                followHim: \(follower.1.rawValue)
            """)
        }
    }
    
    public func usersFollowingUser(with userID: GenericIdentifier<UserProtocol>) -> [UserProtocol]? {
        guard let _ = self.user(with: userID) else {
            return nil
        }
        
        let followerUserIds = self.followers.filter({ $0.1 == userID }).map({ $0.0 })
        let followerUsers = self.users.filter({ followerUserIds.contains($0.id) })
        
        return followerUsers
    }
    
    public func usersFollowedByUser(with userID: GenericIdentifier<UserProtocol>) -> [UserProtocol]? {
        guard let _ = self.user(with: userID) else {
            return nil
        }
        return self.followers
            .filter({ $0.0 == userID })
            .map({
                follow in
                return self.users.filter({ $0.id == follow.1 }).first!
            })
    }
}
