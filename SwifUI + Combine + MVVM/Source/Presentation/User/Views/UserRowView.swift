//
//  UserRowView.swift
//  SwifUI + Combine + MVVM
//
//  Created by Oleksandr Bondar on 27.11.2019.
//  Copyright © 2019 Oleksandr Bondar. All rights reserved.
//

import SwiftUI

struct UserRowView: View {
    
    @State var user: User?
    
    var body: some View {
        
        NavigationLink(destination: UserDetailView(viewModel: UserDetailsViewModel(dataSource: user))) {
            Text("\(user?.firstName ?? "") \(user?.lastName ?? "")")
        }
    }
}

#if DEBUG
struct RepositoryListRow_Previews : PreviewProvider {
    static var previews: some View {
        UserRowView()
    }
}
#endif
