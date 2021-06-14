//
//  Preferences.swift
//  Dom24x7
//
//  Created by Alim Gershishev on 16.04.2021.
//

import Foundation

class Preferences {
    
    private static let preferences = UserDefaults.standard
    
    
    public static func clearAll() {
        preferences.dictionaryRepresentation().keys.forEach { key in
            preferences.removeObject(forKey: key)
        }
    }
    
    // MARK: AuthToken
    
    public static func getAuthToken() -> String? {
        let key = "AuthToken"
        
        return preferences.string(forKey: key)
    }
    
    public static func saveAuthToken(_ token: String) {
        let key = "AuthToken"
        
        preferences.set(token, forKey: key)
    }

    // MARK: PhoneNumber
    
    public static func getPhoneNumber() -> String {
        let key = "PhoneNumber"
        
        return preferences.string(forKey: key)!
    }
    
    public static func savePhoneNumber(_ number: String) {
        let key = "PhoneNumber"
        
        preferences.set(number, forKey: key)
    }
    
    // MARK: UserData
    
    public static func getUserData() -> UserObject {
        let key = "UserData"
        
        return JSONDecoder.decode(UserObject.self, from: preferences.string(forKey: key)!)
    }
    
    public static func saveUserData(_ userData: UserObject) {
        let key = "UserData"
        
        preferences.set(JSONEncoder.encodeToString(userData), forKey: key)
    }
    
}
