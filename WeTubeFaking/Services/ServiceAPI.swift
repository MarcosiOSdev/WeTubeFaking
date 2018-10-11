//
//  ServiceAPI.swift
//  WeTubeFaking
//
//  Created by Marcos Felipe Souza on 30/09/18.
//  Copyright © 2018 Marcos. All rights reserved.
//

import UIKit

class ServiceAPI: NSObject {
    
    static let shared = ServiceAPI()
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"//"http://localhost:3000/youtube"
    
    private override init() {
        super.init()
    }
    
    func getFeeds(urlString: String, completed: @escaping (_ videos: [VideoModel]) -> Void) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            //There arent error handling
            let returnError = [VideoModel]()
            
            if error != nil {
                print(error ?? "")
                completed(returnError)
                return
            }
            do {
                guard let responseData = data else { return }
                let videos:[VideoModel] = try JSONDecoder().decode([VideoModel].self, from: responseData)
                completed(videos)
                
            } catch let jsonError {
                print(jsonError)
                completed(returnError)
            }
        }.resume()
        
    }
    
    func fetchingVideos(completed: @escaping (_ videos: [VideoModel]) -> Void ){
        let url = self.baseUrl + "/home.json"
        getFeeds(urlString: url, completed: completed)
    }
    
    func trendingFetchingVideos(completed: @escaping (_ videos: [VideoModel]) -> Void ){
        let url = self.baseUrl + "/trending.json"
        getFeeds(urlString: url, completed: completed)
    }
    
    func subscribleFetchingVideos(completed: @escaping (_ videos: [VideoModel]) -> Void ) {
        let url = self.baseUrl + "/subscriptions.json"//"/subscrible"
        getFeeds(urlString: url, completed: completed)
    }
}
