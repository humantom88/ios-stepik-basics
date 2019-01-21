//
//  PostsStorage.swift
//  FirstCourseFinalTask
//
//  Created by Tom Belov on 18/01/2019.
//  Copyright © 2019 E-Legion. All rights reserved.
//

import Foundation
import FirstCourseFinalTaskChecker

public class PostsStorage: PostsStorageProtocol {
    public var posts: [Post]
    public var likes: [(GenericIdentifier<UserProtocol>, GenericIdentifier<PostProtocol>)]
    public var currentUserID: GenericIdentifier<UserProtocol>
    public var count: Int {
        get {
            return self.posts.count
        }
    }
    
    static func debugPost(
        post: Post,
        likes: [(GenericIdentifier<UserProtocol>, GenericIdentifier<PostProtocol>)],
        currentUserID: GenericIdentifier<UserProtocol>
    ) {
        let currentUserLikes = likes.filter { $0.0 == currentUserID && $0.1 == post.id }.count > 0
        let likesByCount = likes.filter { $0.1 == post.id }.count
        
        print ("""
            ===================================
            PostDesk:\(post.description)
            CurrentUserLikes:\(currentUserLikes)
            LikesByCount:\(likesByCount)
        """)
        
        if (!currentUserLikes && likesByCount > 0) {
            print ("currentUserId: \(currentUserID)")
            likes.forEach {
                print($0.0)
            }
        }
    }
    
    public required init (
        posts: [PostInitialData],
        likes: [(GenericIdentifier<UserProtocol>, GenericIdentifier<PostProtocol>)],
        currentUserID: GenericIdentifier<UserProtocol>
    ) {
        self.currentUserID = currentUserID
        self.likes = likes
        self.posts = posts.map {
            post in

            let currentUserLikes = likes.filter { $0.0 == currentUserID && $0.1 == post.id }.count > 0
            let likesByCount = likes.filter { $0.1 == post.id }.count
            
            return Post(
                id: post.id,
                author: post.author,
                description: post.description,
                imageURL: post.imageURL,
                createdTime: post.createdTime,
                currentUserLikesThisPost: currentUserLikes,
                likedByCount: likesByCount
            )
        }
    }
    
    func getPostFromLike(like: (GenericIdentifier<UserProtocol>, GenericIdentifier<PostProtocol>)) -> PostProtocol {
        return self.posts.first { $0.id == like.1 }!
    }
    
    public func post(with postID: GenericIdentifier<PostProtocol>) -> PostProtocol? {
        return self.posts.first { $0.id == postID }
    }
    
    public func findPosts(by authorID: GenericIdentifier<UserProtocol>) -> [PostProtocol] {
        return self.posts.filter { $0.author == authorID }
    }
    
    public func findPosts(by searchString: String) -> [PostProtocol] {
        return self.posts.filter { $0.description.contains(searchString) }
    }
    
    public func likePost(with postID: GenericIdentifier<PostProtocol>) -> Bool {
        guard let _ = self.posts.first(where: { $0.id == postID }) else {
            return false
        }
        
        if self.likes.filter({ $0.0 == self.currentUserID && $0.1 == postID }).first != nil {
            return true
        }
        
        let newLike = (self.currentUserID, postID)
        self.likes.append(newLike)
        if let post = self.posts.filter({ $0.id == newLike.1 }).first {
            post.currentUserLikesThisPost = true
            post.likedByCount += 1
        }
        
        return true
    }
    
    public func unlikePost(with postID: GenericIdentifier<PostProtocol>) -> Bool {
        guard let _ = self.posts.first(where: { $0.id == postID }) else {
            return false
        }
        
        if let like = self.likes.filter({ $0.0 == self.currentUserID && $0.1 == postID }).first {
            self.likes.removeAll(where: { $0.0 == like.0 && $0.1 == like.1})
            if let post = self.posts.filter ({ $0.id == like.1 && like.0 == self.currentUserID }).first {
                post.currentUserLikesThisPost = false
                post.likedByCount -= 1
            }
        }

        return true
    }
    
    public func usersLikedPost(with postID: GenericIdentifier<PostProtocol>) -> [GenericIdentifier<UserProtocol>]? {
        guard let _ = self.posts.first(where: { $0.id == postID }) else {
            return nil
        }
        
        print("COUNT: ", self.likes.count)
        
        self.likes
//            .filter({ $0.1 == postID })
            .forEach({ print($0.0.rawValue, $0.1.rawValue) })
        
        return self.likes
            .filter({ $0.1 == postID })
            .map({ $0.0 })
    }
}
