//
//  PostRepository.swift
//  SwifUI + Combine + MVVM
//
//  Created by Oleksandr Bondar on 26.11.2019.
//  Copyright © 2019 Oleksandr Bondar. All rights reserved.
//

import Foundation
import Combine

final class PostRepository: APIClientProtocol {
        
    func getPosts() -> AnyPublisher<[Post], Error> {

        let reqest = RequestGenerator<PostsResponse>(type: .get, endPoint: EndPoint.getPosts)
        return fetch(request: reqest)
            .tryMap({ response -> [Post] in
                if let posts = response.result {
                    return posts
                }
                
                throw HTTPError.dataIsEmpty
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
