//
//  URLExtension.swift
//  SwifUI + Combine + MVVM
//
//  Created by Oleksandr Bondar on 26.11.2019.
//  Copyright © 2019 Oleksandr Bondar. All rights reserved.
//

import Foundation

extension URL {
    
    func add(parameters: Encodable) -> Self? {
        guard let parameters = parameters.dictionary else {
            return self
        }
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        var queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
}
