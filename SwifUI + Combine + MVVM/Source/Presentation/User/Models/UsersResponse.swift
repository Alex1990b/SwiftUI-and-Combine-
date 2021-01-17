//
//  UserResponse.swift
//  SwifUI + Combine + MVVM
//
//  Created by Oleksandr Bondar on 26.11.2019.
//  Copyright © 2019 Oleksandr Bondar. All rights reserved.
//

import Foundation

struct UsersResponse: Decodable {
    let data: [User]?
}

struct User: Decodable, Identifiable {
    let id: Int?
    let name: String?
    let email: String?
    let links: Links?
    let website: String?
    let status: String?
    let phone: String?
    let gender: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case website
        case status
        case phone
        case gender
        case links = "_links"
    }
    
    struct Links: Decodable {
        let selfLink: Link?
        let avatar: Link?
        
        enum CodingKeys: String, CodingKey {
            case selfLink = "self"
            case avatar
        }
        
        struct Link: Decodable {
            let href: String?
        }
    }
}
