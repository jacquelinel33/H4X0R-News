//
//  PostData.swift
//  H4X0R News
//
//  Created by Jacqueline Lee on 2023-12-07.
//

import Foundation

//The primary purpose of Decodable is to provide a mechanism to convert data like JSON into Swift objects. This is particularly useful when fetching data from an API or reading data from a file.
struct Results: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable {
    //identifiable protocol needs an "id". From the JSON we have the objectID. 
    var id: String {
        return objectID
    }
    let objectID: String
    let title: String
    let points: Int
    let url: String?
}
