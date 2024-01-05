//
//  NetworkManager.swift
//  H4X0R News
//
//  Created by Jacqueline Lee on 2023-12-07.
//

import Foundation

//Being an ObservableObject means that SwiftUI will watch this class for any changes to properties marked with @Published
class NetworkManager: ObservableObject {
    
    //@Published is a property wrapper that will publish a notification to any observer (to a listener @ObservedObject). posts stores the results from results.hits
    @Published var posts = [Post]()
    
    func fetchData() {
        //attempts to create a URL from the provided string. If this is successful, the code inside the braces { ... } gets executed.
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {
            //This creates a URL session with a default configuration. This session is used to manage data-transfer tasks.
            let session = URLSession(configuration: .default)
            //This creates a task to retrieve the contents of the URL. It has a completion handler which is a block of code that will run when the task completes. This handler receives data, response, and error as inputs.
            let task = session.dataTask(with: url) { (data, response, error)  in
                if error == nil {
                    //creates a JSON decoder to convert JSON data into Swift objects.
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            //tries to decode safeData into a Results object.
                            let results = try decoder.decode(Results.self, from: safeData)
                            //The results are assigned to posts. This is done on the main thread because it updates the UI, which must be done on the main thread.
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            //When you create a data task with URLSession, the task is initially in a suspended state. This means that the task is set up and ready to go, but it doesn't start the network request immediately. This design gives you control over when the network request should start.
            task.resume()
        }
    }
}
