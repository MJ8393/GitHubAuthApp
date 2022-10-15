//
//  File.swift
//  GitHubRepoInfinBankTask
//
//  Created by Mekhriddin Jumaev on 24/09/22.
//

import Foundation

struct TokenInfo: Codable {
    let access_token: String
    let token_type: String
    let scope: String
}
