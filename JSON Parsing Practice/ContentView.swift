//
//  ContentView.swift
//  JSON Parsing Practice
//
//  Created by Sergey Basin on 25.03.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                APImanager.shared.getUsers { users in
                    print(users.count)
                }
                
                APImanager.shared.getPosts { posts in
                    print(posts.count)
                }
                
                APImanager.shared.getAlbums { albums in
                    print(albums.count)
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
