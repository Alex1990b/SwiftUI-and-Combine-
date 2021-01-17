//
//  PostViewModel.swift
//  SwifUI + Combine + MVVM
//
//  Created by Oleksandr Bondar on 26.11.2019.
//  Copyright © 2019 Oleksandr Bondar. All rights reserved.
//

import Combine

final class PostViewModel: ObservableObject, Identifiable {
    
    @Published private(set) var dataSource: [Post] = []
    @Published private(set) var errorMessage = ""
    @Published var isShowError = false
    @Published var isShowLoading = false
    
    private let postRepository: PostRepository
    private let userRepository: UserRepository
    
    private var disposables = Set<AnyCancellable>()
    
    init(postRepository: PostRepository = .init(), userRepository: UserRepository = .init()) {
        self.postRepository = postRepository
        self.userRepository = userRepository
    }
    
    func fetchPosts() {
        
        guard dataSource.isEmpty else { return }
        
        isShowLoading = true
        
        postRepository.getPosts()
            .flatMap({ post -> AnyPublisher<[Post], Error> in
                
                let mappedPosts = post.compactMap{ self.updatePostWithUser(post: $0) }
                
                return Publishers.MergeMany(mappedPosts).collect().eraseToAnyPublisher()
                
            })
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
            }, receiveValue: { [weak self] posts in
                self?.dataSource = posts
            }).store(in: &disposables)
    }
}

private extension PostViewModel {
    func updatePostWithUser(post: Post) -> AnyPublisher<Post, Error> {
       
        return self.userRepository.getUser(with: post.userId ?? "")
            .map { (user) -> Post in
                post.user = user
                return post
        }.eraseToAnyPublisher()
    }
}
