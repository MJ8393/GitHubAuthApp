//
//  Ext+UserDefaults.swift
//  GitHubRepoInfinBankTask
//
//  Created by Mekhriddin Jumaev on 24/09/22.
//

import Foundation

let UD = UserDefaults()

extension UserDefaults {
    
    var access_token: String? {
        get { return self.string(forKey: "access_token") }
        set { self.set(newValue, forKey: "access_token") }
    }
    
    var token_type: String? {
        get { return self.string(forKey: "token_type") }
        set { self.set(newValue, forKey: "token_type") }
    }
    
    var scope: String? {
        get { return self.string(forKey: "scope") }
        set { self.set(newValue, forKey: "scope") }
    }
    
}

