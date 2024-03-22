//
//  LocalStorageManager.swift
//  onlineBankingApp
//
//  Created by Celal Karahan on 22.03.2024.
//

import Foundation
class LocalStorageManager {
    private let PREF_NAME = "MyPrefs"
    private let ACCESS_TOKEN_KEY = "accessToken"
    
    private let userDefaults: UserDefaults
    
    init() {
        // UserDefaults nesnesini oluştur
        self.userDefaults = UserDefaults.standard
    }
    
    func saveAccessToken(accessToken: String) {
        // Access token'ı UserDefaults'a kaydet
        userDefaults.set(accessToken, forKey: ACCESS_TOKEN_KEY)
    }
    
    func getAccessToken() -> String? {
        // Access token'ı UserDefaults'dan al
        return userDefaults.string(forKey: ACCESS_TOKEN_KEY)
    }
    
    func removeAccessToken() {
        // Access token'ı UserDefaults'dan sil
        userDefaults.removeObject(forKey: ACCESS_TOKEN_KEY)
    }
}
