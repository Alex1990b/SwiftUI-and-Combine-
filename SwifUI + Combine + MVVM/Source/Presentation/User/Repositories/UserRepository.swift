//
//  UserRepository.swift
//  SwifUI + Combine + MVVM
//
//  Created by Oleksandr Bondar on 26.11.2019.
//  Copyright © 2019 Oleksandr Bondar. All rights reserved.
//

import Foundation
import Combine

final class UserRepository: APIClientProtocol {
    
    func getUser(with id: String) -> AnyPublisher<User, Error> {
        
        let request = RequestGenerator<UserResponse>(type: .get, endPoint: EndPoint.getUserById(path: id))
        return fetch(request: request)
            .compactMap { $0.result }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getUsers() -> AnyPublisher<[User], Error> {
        let request = RequestGenerator<UsersResponse>(type: .get, endPoint: EndPoint.getUsers)
        return fetch(request: request)
            .compactMap { $0.result }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
