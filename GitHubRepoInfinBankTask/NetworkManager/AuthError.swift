//
//  AuthError.swift
//  GitHubRepoInfinBankTask
//
//  Created by Mekhriddin Jumaev on 24/09/22.
//

import Foundation

enum AuthError: Error {
    
    case invalidAuthCode
    case unableToComplete
    case invalidResponse
    case invalidData
    
}
