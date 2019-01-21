//
//  Post.swift
//  FirstCourseFinalTask
//
//  Created by Tom Belov on 18/01/2019.
//  Copyright © 2019 E-Legion. All rights reserved.
//

import Foundation
import FirstCourseFinalTaskChecker

public class Post: PostProtocol {
    public var id: Post.Identifier
    public var author: GenericIdentifier<UserProtocol>
    public var description: String
    public var imageURL: URL
    public var createdTime: Date
    public var currentUserLikesThisPost: Bool
    public var likedByCount: Int
    
    init (
        id: Post.Identifier,
        author: GenericIdentifier<UserProtocol>,
        description: String,
        imageURL: URL,
        createdTime: Date,
        currentUserLikesThisPost: Bool,
        likedByCount: Int
        ) {
        self.id = id
        self.author = author
        self.description = description
        self.imageURL = imageURL
        self.createdTime = createdTime
        self.currentUserLikesThisPost = currentUserLikesThisPost
        self.likedByCount = likedByCount
    }
}
