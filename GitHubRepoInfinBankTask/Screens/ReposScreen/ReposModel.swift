//
//  Repository.swift
//  GitHubRepoInfinBankTask
//
//  Created by Mekhriddin Jumaev on 24/09/22.
//

import Foundation

struct RepositoryList: Codable {
    let items: [Repository]
}

struct Repository: Codable {
    let name: String
    let language: String?
    let html_url: String?
    let owner: Owner
}

struct Owner: Codable {
    let avatar_url: String
}
