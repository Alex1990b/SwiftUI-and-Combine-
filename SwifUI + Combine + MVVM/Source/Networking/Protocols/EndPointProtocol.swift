
//
//  AppDelegate.swift
//  SwifUI + Combine + MVVM
//
//  Created by Oleksandr Bondar on 25.11.2019.
//  Copyright © 2019 Oleksandr Bondar. All rights reserved.
//

import Foundation

protocol EndPointProtocol {
    var url: URL? { get}
}

extension EndPointProtocol {
    var baseURL: String {
        return "https://gorest.co.in/"
    }
}

extension String: EndPointProtocol {
    var url: URL? {
        return URL(string: baseURL + self)
    }
}

enum EndPoint: EndPointProtocol {
    case getPosts
    case getUsers
    case getPostById(path: String)
    case getUserById(path: String)
    
    var rawValueDescription: String {
        switch self {
        case .getPosts: return "public-api/posts"
        case .getUsers: return "public-api/users"
        case .getPostById(path: let path): return "public-api/posts/\(path)"
        case .getUserById(path: let path): return "public-api/users/\(path)"
        }
    }
    
    var url: URL? {
        return URL(string: baseURL + rawValueDescription + "?_format=json")
    }
}
