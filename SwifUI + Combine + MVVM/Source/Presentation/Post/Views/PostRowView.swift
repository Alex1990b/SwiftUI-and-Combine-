//
//  PostRowView.swift
//  SwifUI + Combine + MVVM
//
//  Created by Oleksandr Bondar on 27.11.2019.
//  Copyright © 2019 Oleksandr Bondar. All rights reserved.
//

import SwiftUI

struct PostRowView: View {
    
    @State var post: Post?
    
    var body: some View {
        NavigationLink(destination: PostDetailView(viewModel: PostDetailViewModel(dataSource: post))) {
            Text(post?.title ?? "gg")
        }
    }
}

#if DEBUG
struct PostRowView_Previews : PreviewProvider {
    static var previews: some View {
        PostRowView()
    }
}
#endif
