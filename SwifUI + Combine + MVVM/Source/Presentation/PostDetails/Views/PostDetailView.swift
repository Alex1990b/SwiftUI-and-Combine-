//
//  PostDetailView.swift
//  SwifUI + Combine + MVVM
//
//  Created by Oleksandr Bondar on 27.11.2019.
//  Copyright © 2019 Oleksandr Bondar. All rights reserved.
//

import SwiftUI

struct PostDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var postDetailViewModel: PostDetailViewModel
    
    init(viewModel: PostDetailViewModel = .init(dataSource: nil)) {
        postDetailViewModel = viewModel
    }
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 20) {
                Text(postDetailViewModel.dataSource?.title ?? "")
                    .padding(20)
                Text(postDetailViewModel.dataSource?.body ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                    .font(.system(size: 20))
                HStack(spacing: 10) {
                    URLImageView(url: self.postDetailViewModel.imageUrl)
                        .frame(width: 60, height: 60, alignment: .leading)
                        .clipShape(Circle())
                    Text(self.postDetailViewModel.avtorName)
                }.frame(maxWidth: .infinity, alignment: .leading)
            }.padding()
        }
            
        .navigationBarTitle(Text("Post info"), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            })
            {
                Image("arrowLeft")
                
            }.accentColor(.red)
        )
    }
}

#if DEBUG
struct PostDetailView_Previews : PreviewProvider {
    static var previews: some View {
        PostDetailView()
    }
}
#endif
