//
//  AuthManager.swift
//  DoReMi
//
//  Created by mai ng on 8/15/21.
//

import Foundation


final class  AuthManager {
    static let shared = AuthManager()
    
    
//    struct Constants {
//        static  let clientID = "f542fb8558e54b96864482ae89b904b7"
//        static let clientSecret = "9964ff63bacc4da2a4f4e00281a2b162"
//        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
//        static let redirectURI = "https://www.iosacademy.io/"
//        static let scopes = "user-read-privatep%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
//    }
//
//    user-read-private",
//                               "playlist-modify-public",
//                               "playlist-read-private",
//                               "playlist-modify-private",
//                               "user-follow-read",
//                               "user-read-email
    private init() {}
    
    
    public var signInURL: URL? {
        let scopes = Constants.scopesArray.joined(separator: "%20")

        let baseURL = "https://accounts.spotify.com/authorize"
        let string = "\(baseURL)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(Constants.redirectURI)&show_dialog=TRUE"
        return URL(string: string)
    }
    
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    private var accessToken: String? {
        return  UserDefaults.standard.string(forKey: "access_token")

    }
    
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
        
    }
    
    private var tokenExpiration: Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
            
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpiration else {
            return false
        }
        
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    public func exchangeCodeForToken(code:String,completion: @escaping ((Bool) -> (Void))){
        //Get Token
        guard let url = URL(string: Constants.tokenAPIURL) else {
            return
        }
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type",
                         value: "authorization_code"),
            URLQueryItem(name: "code",
                         value: code),
            URLQueryItem(name: "redirect_uri",
                         value: Constants.redirectURI)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded",
                         forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else{
            print("Failure to get base64")
            completion(false)
            return
        }
        request.setValue("Basic \(base64String)",
                         
                         forHTTPHeaderField:"Authorization")
        let task = URLSession.shared.dataTask(with: request) { [weak self](data, _, error) in
            guard let data = data, error == nil else{
                completion(false)
                return
            }
            do{
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.cacheToken(result: result)
                completion(true)

            }
            catch{
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
        
    }
    
    public func refreshAccessToken(completion: @escaping (Bool) -> Void) {
//        guard let shouldRefreshToken = self.refreshToken else {
//            completion(true)
//            return
//        }
        
        guard let refreshToken = self.refreshToken else {
            return
        }
        // Refresh the token
        
        guard let url = URL(string: Constants.tokenAPIURL) else {
            return
        }
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type",
                         value: "refresh_token"),
            URLQueryItem(name: "redirect_uri",
                         value: refreshToken)
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded",
                         forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else{
            print("Failure to get base64")
            completion(false)
            return
        }
        request.setValue("Basic \(base64String)",
                         
                         forHTTPHeaderField:"Authorization")
        let task = URLSession.shared.dataTask(with: request) { [weak self](data, _, error) in
            guard let data = data, error == nil else{
                completion(false)
                return
            }
            do{
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                print("Successfully refreshed")
                self?.cacheToken(result: result)
                completion(true)

            }
            catch{
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
    
    
    private func cacheToken(result: AuthResponse) {
        //Caching is pretty important so let's see waht we want to do  - We've going to cache everything inyo UserDefault
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        
        if let refresh_token = result.refresh_token {
            UserDefaults.standard.setValue(refresh_token, forKey: "refresh_token")

        }
        
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
    }
    
//    private var accessToken: String?{
//        return UserDefaults.standard.string(forKey: "access_token")
//    }
//    private var refreshToken: String?{
//        return UserDefaults.standard.string(forKey: "refresh_token")
//    }
//    private var tokenExpirationDate: Date?{
//        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
//    }
}
