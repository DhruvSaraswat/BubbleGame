//
//  Storage.swift
//  BubbleGame
//
//  Created by Dhruv Saraswat on 15/05/24.
//

import Foundation

@propertyWrapper
struct Storage {
    private let key: String
    private let defaultValue: String

    init(key: String, defaultValue: String) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: String {
        get {
            return UserDefaults.standard.string(forKey: key) ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct AppData {
    @Storage(key: Constants.UserDefaultsKeys.username, defaultValue: "")
    static var username: String

    @Storage(key: Constants.UserDefaultsKeys.sessionID, defaultValue: "")
    static var sessionID: String
}
