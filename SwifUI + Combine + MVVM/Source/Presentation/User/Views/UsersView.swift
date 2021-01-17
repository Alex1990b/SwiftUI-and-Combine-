//
//  UsersView.swift
//  SwifUI + Combine + MVVM
//
//  Created by Oleksandr Bondar on 27.11.2019.
//  Copyright © 2019 Oleksandr Bondar. All rights reserved.
//

import SwiftUI
import Combine

struct UsersView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: UsersViewModel
    
    init(viewModel: UsersViewModel = .init()) {
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
        .navigationBarTitle(Text("Users"), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image("arrowLeft")
                    
                }.accentColor(.red)
        )
        .onAppear(perform: viewModel.fetchUsers)
    }
}

private extension UsersView {
    
    var emptySection: some View {
        Section {
            Text("No results")
                .frame(maxWidth: .infinity)
        }
    }
    
    var postsSection: some View {
        Section {
            ForEach(viewModel.dataSource) { item in
                UserRowView(user: item)
            }
        }
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
