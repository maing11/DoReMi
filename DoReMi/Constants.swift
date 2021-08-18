//
//  Constants.swift
//  DoReMi
//
//  Created by mai ng on 8/18/21.
//

import Foundation


struct Constants {
    static  let clientID = "f542fb8558e54b96864482ae89b904b7"
    static let clientSecret = "9964ff63bacc4da2a4f4e00281a2b162"
    static let tokenAPIURL = "https://accounts.spotify.com/api/token"
    static let redirectURI = "https://www.iosacademy.io/"
    static let scopesArray = ["user-read-private",
                               "playlist-modify-public",
                               "playlist-read-private",
                               "playlist-modify-private",
                               "user-follow-read",
                               "user-read-email"
    ]
}
