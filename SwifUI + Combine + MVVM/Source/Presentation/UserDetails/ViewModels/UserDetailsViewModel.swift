//
//  UserDetailsViewModel.swift
//  SwifUI + Combine + MVVM
//
//  Created by Oleksandr Bondar on 27.11.2019.
//  Copyright © 2019 Oleksandr Bondar. All rights reserved.
//

import Combine

final class UserDetailsViewModel: ObservableObject, Identifiable {
    
    @Published private(set) var dataSource: User?
    
    var imageUrl: String {
        dataSource?.links?.avatar?.href ?? ""
    }
    
    var email: String {
        dataSource?.email ?? ""
    }
    
    var phone: String {
        dataSource?.phone ?? ""
    }
    
    var website: String {
        dataSource?.website ?? ""
    }
    
    var status: String {
        dataSource?.status ?? ""
    }
    
    var fullName: String {
        dataSource?.name ?? ""
    }
    
    private var disposables = Set<AnyCancellable>()
    
    init(dataSource: User?) {
        self.dataSource = dataSource
    }
}
