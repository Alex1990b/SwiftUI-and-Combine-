//
//  PostsResponse.swift
//  SwifUI + Combine + MVVM
//
//  Created by Oleksandr Bondar on 26.11.2019.
//  Copyright © 2019 Oleksandr Bondar. All rights reserved.
//

import Foundation

final class PostsResponse: Decodable {
    var result: [Post]?
}

final class Post: Decodable, Identifiable {
    let id: String?
    let userId: String?
    let title: String?
    let body: String?
    var user: User?
}
