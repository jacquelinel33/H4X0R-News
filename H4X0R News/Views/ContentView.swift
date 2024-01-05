//
//  ContentView.swift
//  H4X0R News
//
//  Created by Jacqueline Lee on 2023-12-07.
//

import SwiftUI

struct ContentView: View {
    
    //listener that listens for changes in @published
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            List(networkManager.posts) { post in
                NavigationLink(destination: DetailView(url: post.url)) {
                    HStack {
                        Text(String(post.points))
                        Text(post.title)
                    }
                }
            }
            .navigationBarTitle("HAX0R NEWS")
        }
        //similiar to viewDidLoad. This fetches the data.
        .onAppear {
            self.networkManager.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

