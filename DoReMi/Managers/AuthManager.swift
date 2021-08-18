//
//  AuthManager.swift
//  DoReMi
//
//  Created by mai ng on 8/15/21.
//

import Foundation


final class  AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    var isSignedIn: Bool {
        return false
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpiration: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
        
    }
}
