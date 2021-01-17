//
//  UserDetailView.swift
//  SwifUI + Combine + MVVM
//
//  Created by Oleksandr Bondar on 27.11.2019.
//  Copyright © 2019 Oleksandr Bondar. All rights reserved.
//

import SwiftUI

struct UserDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var postDetailViewModel: UserDetailsViewModel
    
    init(viewModel: UserDetailsViewModel = .init(dataSource: nil)) {
        postDetailViewModel = viewModel
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 20) {
                    URLImageView(url: self.postDetailViewModel.imageUrl)
                        .frame(width: geometry.size.width / 2, height: geometry.size.width / 2, alignment: .center)
                        .clipShape(Circle())
                    Text(self.postDetailViewModel.fullName)
                        .padding(20)
                    
                    self.textView(text: self.postDetailViewModel.email)
                    self.textView(text: self.postDetailViewModel.phone)
                    self.textView(text: self.postDetailViewModel.website)
                    self.textView(text: self.postDetailViewModel.status)
                }.frame(maxWidth: .infinity).padding()
            }
        }
            
        .navigationBarTitle(Text("User info"), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image("arrowLeft")
                
            }.accentColor(.red)
        )
    }
}

private extension UserDetailView {
    func textView(text: String) -> some View {
        Text(text)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
struct UserDetailView_Previews : PreviewProvider {
    static var previews: some View {
        UserDetailView()
    }
}
#endif
