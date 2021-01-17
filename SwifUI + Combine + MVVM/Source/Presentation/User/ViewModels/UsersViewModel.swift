//
//  UsersViewModel.swift
//  SwifUI + Combine + MVVM
//
//  Created by Oleksandr Bondar on 27.11.2019.
//  Copyright © 2019 Oleksandr Bondar. All rights reserved.
//

import Combine

final class UsersViewModel: ObservableObject, Identifiable {
    
    @Published private(set) var dataSource: [User] = []
    @Published private(set) var errorMessage = ""
    @Published var isShowLoading = false
    @Published var isShowError = false
    
    private let userRepository: UserRepository
    
    private var disposables = Set<AnyCancellable>()
    
    init(userRepository: UserRepository = .init()) {
        self.userRepository = userRepository
    }
    
    func fetchUsers() {
        
        guard dataSource.isEmpty else { return }
        
        isShowLoading = true
        userRepository.getUsers()
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                
                self.isShowLoading = false
        
                switch completion {
                case .failure(let error):
                    self.isShowError = true
                    self.errorMessage = error.localizedDescription
                    self.dataSource = []
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] users in
                self?.dataSource = users
            }).store(in: &disposables)
    }
}
