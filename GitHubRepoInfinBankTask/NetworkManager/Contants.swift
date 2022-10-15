//
//  Contants.swift
//  GitHubRepoInfinBankTask
//
//  Created by Mekhriddin Jumaev on 24/09/22.
//

import Foundation

struct Constants {
    
    static let cliendID = "0df4f1e68b31427031fc"
    static let clientSecret = "91b64589ba68f77d04c86a657243a803b8e75356"
    static let redirectURL = "task.infinbank.github://authentication"
    static let scope = ""
    static let tokenURL = "https://github.com/login/oauth/access_token"
    static let searchRepoURL = "https://api.github.com/search/repositories"
    static let authURL = "https://github.com/login/oauth/authorize?client_id=" + Constants.cliendID + "&scope=" + Constants.scope + "&redirect_uri=" + Constants.redirectURL + "&state="
    
}
