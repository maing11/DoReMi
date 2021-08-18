//
//  APICaller.swift
//  DoReMi
//
//  Created by mai ng on 8/15/21.
//

import Foundation


final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "http:://api.spotify.com/v1"
        
    }
        
    enum APIError: Error {
        case failedToGetData
    }
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    // MARK: - Private
    
    private func createRequest(with url: URL?,type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        guard let apiURL = url else {
            return
            
        }
        
        var request = URLRequest(url: apiURL)
//        request.setValue("", forHTTPHeaderField: "Authorization")
        request.httpMethod = type.rawValue
        request.timeoutInterval = 30
        
        completion(request)
    }
    
    
    public func getNewReleasae(completion: @escaping ((Result<String, Error>)) -> Void ) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/new-releases?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _,error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(json)
                    
                } catch {
                    completion(.failure(error))
                    
                }
                
            }
            task.resume()
            
        }
 
    }

}
