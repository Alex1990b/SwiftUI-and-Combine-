//
//  URLImageView.swift
//  SwifUI + Combine + MVVM
//
//  Created by Oleksandr Bondar on 28.11.2019.
//  Copyright © 2019 Oleksandr Bondar. All rights reserved.
//

import Combine
import SwiftUI

struct URLImageView: View {
    
    @ObservedObject private var imageLoader = ImageLoader()
    
    private let placeholder: Image
    
    init(url: String, placeholder: Image = Image("avatarPlaceholder")) {
        self.placeholder = placeholder
        imageLoader.load(urlString: url)
    }
    
    var body: some View {
    
        if let uiImage = self.imageLoader.image {
            return Image(uiImage: uiImage)
        } else {
           return placeholder
        }
    }
}
