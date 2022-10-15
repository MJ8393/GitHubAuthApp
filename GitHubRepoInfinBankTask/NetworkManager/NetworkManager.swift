//
//  NetworkManager.swift
//  GitHubRepoInfinBankTask
//
//  Created by Mekhriddin Jumaev on 24/09/22.
//

import UIKit

protocol NetworkManagerProtocol {
    func getGitGubToken(authCode: String, completed: @escaping (Result<TokenInfo, AuthError>) -> Void)
    func getRepositories(query: String, page: Int, completed: @escaping (Result<RepositoryList, AuthError>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {

    func getGitGubToken(authCode: String, completed: @escaping (Result<TokenInfo, AuthError>) -> Void) {
        let endpoint = Constants.tokenURL
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidAuthCode))
            return
        }
        
        // Set the POST parameters.
        let postParams = "&code=" + authCode + "&client_id=" + Constants.cliendID + "&client_secret=" + Constants.clientSecret
        let postData = postParams.data(using: String.Encoding.utf8)
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = postData
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            
            if let _ = error{
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let tokenInfo = try decoder.decode(TokenInfo.self, from: data)
                completed(.success(tokenInfo))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getRepositories(query: String, page: Int, completed: @escaping (Result<RepositoryList, AuthError>) -> Void) {
        let endpoint = Constants.searchRepoURL + "?q=\(query)" + "&page=\(page)" + "&per_page=10"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidAuthCode))
            return
        }
        
        // Set the GET parameters.
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        guard let token = UD.access_token else { return }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            
            if let _ = error{
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let repoList = try decoder.decode(RepositoryList.self, from: data)
                completed(.success(repoList))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}


