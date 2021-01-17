//
//  PostDetailViewModel.swift
//  SwifUI + Combine + MVVM
//
//  Created by Oleksandr Bondar on 27.11.2019.
//  Copyright © 2019 Oleksandr Bondar. All rights reserved.
//

import Combine

final class PostDetailViewModel: ObservableObject, Identifiable {
    
    @Published private(set) var dataSource: Post?
    
    var imageUrl: String {
        dataSource?.user?.links?.avatar?.href ?? ""
    }
    
    var avtorName: String {
        "\(dataSource?.user?.firstName ?? "") \(dataSource?.user?.lastName ?? "")"
    }

    private var disposables = Set<AnyCancellable>()
    
    init(dataSource: Post?) {
        self.dataSource = dataSource
    }
}
