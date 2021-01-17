
//
//  AppDelegate.swift
//  SwifUI + Combine + MVVM
//
//  Created by Oleksandr Bondar on 25.11.2019.
//  Copyright © 2019 Oleksandr Bondar. All rights reserved.
//

import Foundation
import Combine

typealias Response<T: APIRequestProtocol> = (Result<T.ResponseType, Error>) -> Void

enum HTTPError: LocalizedError {
    case wrongRequest
    case statusCode
    case noData
    case dataIsEmpty
}

protocol APIClientProtocol: class {
    func fetch<T: APIRequestProtocol>(request: T) -> Future<T.ResponseType, Error>
    func fetch<T: APIRequestProtocol, Body: Encodable>(request: T,
                                                       parameters: Body) -> Future<T.ResponseType, Error>
}

extension APIClientProtocol {
    
    func fetch<T: APIRequestProtocol>(request: T) -> Future<T.ResponseType, Error> {
        
        return Future<T.ResponseType, Error> { [weak self] promise in
            
            if let url = request.endPoint.url {
                var urlRequest = URLRequest(url: url)
                
                self?.setHeaders(request: &urlRequest)
                urlRequest.httpMethod = request.type.rawValue
                
                self?.getPublisher(request: request, urlRequest: urlRequest, promise: promise)
            } else {
                promise(.failure(HTTPError.wrongRequest))
            }
        }
    }
    
    func fetch<T: APIRequestProtocol, Body: Encodable>(request: T,
                                                       parameters: Body) -> Future<T.ResponseType, Error> {
        
        return Future<T.ResponseType, Error> { [weak self] promise in
            
            if let urlRequest = self?.getConfiguredRequest(request: request, parameters: parameters) {
                self?.getPublisher(request: request, urlRequest: urlRequest, promise: promise)
            } else {
                promise(.failure(HTTPError.wrongRequest))
            }
        }
    }
}

private extension APIClientProtocol {
    
    func getConfiguredRequest<T: APIRequestProtocol, Body: Encodable>(request: T,
                                                                      parameters: Body) -> URLRequest? {
        
        guard let url = request.endPoint.url else { return nil }
        var urlRequest = URLRequest(url: url)
        
        setHeaders(request: &urlRequest)
        urlRequest.httpMethod = request.type.rawValue
        
        switch request.type {
        case .post, .put, .delete:
            setRequestBody(request: &urlRequest, body: parameters)
            return urlRequest
        case .get:
            if let url = url.add(parameters: parameters) {
                return URLRequest(url: url)
            } else {
                return urlRequest
            }
        }
    }
    
    func setHeaders(request: inout URLRequest) {
        request.setValue("Bearer vHFpXkF7Gvv4GoC4zThZlBXHxjOTlWnQIszK", forHTTPHeaderField: "Authorization")
    }
    
    func setRequestBody<T: Encodable>(request: inout URLRequest, body: T?) {
        if let body = body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
    }
    
    func getPublisher<T: APIRequestProtocol>(request: T, urlRequest: URLRequest, promise: @escaping Response<T>) {
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                promise(.failure(error))
            }
            
            if let data = data {
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(T.ResponseType.self, from: data)
                    promise(.success(result))
                } catch(let error) {
                    promise(.failure(error))
                }
            } else {
                promise(.failure(HTTPError.noData))
            }
        }.resume()
    }
}

