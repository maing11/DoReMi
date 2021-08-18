//
//  UserProfile.swift
//  DoReMi
//
//  Created by mai ng on 8/17/21.
//

import Foundation


struct UserProfile: Codable {
    let countrry: String
    let display_name: String
    let email: String
    let explicit_content: [String: Int]
    let external_urls: [String: String]
//    let follower: [String: Codable?]
    let id: String
    let product: String
    let images: [UserImage]
    
}


struct UserImage: Codable{
    let url: String
}
