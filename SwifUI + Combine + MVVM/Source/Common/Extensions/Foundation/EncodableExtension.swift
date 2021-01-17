//
//  EncodableExtension.swift
//  SwifUI + Combine + MVVM
//
//  Created by Oleksandr Bondar on 26.11.2019.
//  Copyright © 2019 Oleksandr Bondar. All rights reserved.
//

import Foundation

extension Encodable {
    
  var dictionary: [String: String]? {
    
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    
    return (try? JSONSerialization.jsonObject(with: data,
                                              options: .allowFragments)).flatMap { $0 as? [String: String] }
  }
    
}
