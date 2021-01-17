//
//  ContentView.swift
//  SwifUI + Combine + MVVM
//
//  Created by Oleksandr Bondar on 25.11.2019.
//  Copyright © 2019 Oleksandr Bondar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    getTextView(text: "Posts")
                    getImageView(imageName: "post", rotationY: 1.0, destination: PostsView())
                    getTextView(text: "Users")
                    getImageView(imageName: "user", rotationY: -1.0, destination: UsersView())
                    
                }.foregroundColor(.black)
                    .accentColor(.pink)
                    .background(Color.gray)
                    .frame(maxWidth: 1000)
                
            }
            .font(.title)
            .navigationBarTitle(Text("Main"), displayMode: .inline)
        }
    }
}


private extension ContentView {
    func getTextView(text: String) -> some View {
        Text(text)
            .font(Font.custom("Avenir Next", size: 26))
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.red)
            .shadow(color: .black, radius: 10)
    }
    
    func getImageView<T: View>(imageName: String, rotationY: CGFloat, destination: T) -> some View {
        NavigationLink(destination: destination) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .rotation3DEffect(Angle(degrees: 30), axis: (x: 0.0, y: rotationY, z: 0.0))
                .padding(40)
                .frame(width: 300, height: 300)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
