//
//  PostsView.swift
//  SwifUI + Combine + MVVM
//
//  Created by Oleksandr Bondar on 27.11.2019.
//  Copyright © 2019 Oleksandr Bondar. All rights reserved.
//

import SwiftUI
import Combine

struct PostsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: PostViewModel
    
    init(viewModel: PostViewModel = .init()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        LoadingView(isShowing: .constant(viewModel.isShowLoading)) {
            List {
                if self.viewModel.dataSource.isEmpty {
                    self.emptySection
                } else {
                    self.postsSection
                }
            }
        }
        
        .alert(isPresented: $viewModel.isShowError) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage))
        }
        .navigationBarTitle(Text("Posts"), displayMode: .inline)
            .navigationBarBackButtonHidden(true)
                      .navigationBarItems(leading:
                          Button(action: {
                              self.presentationMode.wrappedValue.dismiss()
                          }) {
                              Image("arrowLeft")
                              
                        }.accentColor(.red)
        )
        .onAppear(perform: viewModel.fetchPosts)
    }
}

private extension PostsView {
    
    var emptySection: some View {
        Section {
            Text("No results")
                .frame(maxWidth: .infinity)
        }
    }
    
    var postsSection: some View {
        Section {
            ForEach(viewModel.dataSource) { item in
                PostRowView(post: item)
            }
        }
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
