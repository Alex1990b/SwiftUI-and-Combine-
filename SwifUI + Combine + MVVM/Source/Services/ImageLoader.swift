//
//  ImageLoader.swift
//  SwifUI + Combine + MVVM
//
//  Created by Oleksandr Bondar on 27.11.2019.
//  Copyright © 2019 Oleksandr Bondar. All rights reserved.
//

import UIKit
import Combine

final class ImageLoader: ObservableObject {
    
    private var disposables = Set<AnyCancellable>()
    
    @Published var image: UIImage?
    
    func load(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.main)
            .compactMap {    UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
            }) { [weak self] image in
                self?.image = image
        }.store(in: &disposables)
    }
}
