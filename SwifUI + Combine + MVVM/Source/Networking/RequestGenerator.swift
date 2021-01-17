//
//  AppDelegate.swift
//  SwifUI + Combine + MVVM
//
//  Created by Oleksandr Bondar on 25.11.2019.
//  Copyright © 2019 Oleksandr Bondar. All rights reserved.
//

import Foundation

struct RequestGenerator<T: Decodable>: APIRequestProtocol {

    typealias ResponseType = T

    var type: APIRequestType
    var endPoint: EndPointProtocol
}
