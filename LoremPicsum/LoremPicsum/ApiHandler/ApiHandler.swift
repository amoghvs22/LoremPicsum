//
//  ApiHandler.swift
//  LoremPicsum
//
//  Created by Mac Mini on 11/03/19.
//

import Foundation

typealias CompletionHandler = (URLResponse?, Error?, Data?) -> Void

class ApiHandler: NSObject {
    
    static func getUserDetails(page: String, handler: @escaping CompletionHandler) {
        let urlString = "https://api.randomuser.me/?page=" + page + "&results=10&nat=e"
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                handler(response, nil, data)
            }
            else {
                handler(response, error, nil)
            }
        }.resume()
    }
    
    static func fetchImage(url: String, handler: @escaping CompletionHandler) {
        guard let url = URL(string: url) else { return }
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                handler(response, nil, data)
            }
            else {
                handler(response, error, nil)
            }
        }.resume()
    }
}
