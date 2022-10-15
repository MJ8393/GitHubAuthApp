//
//  ReposViewModel.swift
//  GitHubRepoInfinBankTask
//
//  Created by Mekhriddin Jumaev on 25/09/22.
//

import Foundation
import RxSwift
import RxRelay

final class ReposViewModel {
    
    let repos = BehaviorRelay<[Repository]>(value: [])
    let showLoadView = BehaviorRelay<Bool>(value: false)
    
    private var service: NetworkManagerProtocol?
    
    init(service: NetworkManagerProtocol) {
        self.service = service
    }
    
    private var query: String = ""
    private var page: Int = 1
    private var hasMoreRepos = true
    
    func changeSearchBarText(_ searchBarText: String) {
        query = searchBarText
        repos.accept([])
        page = 1
        getRepositories(query: query, page: page)
    }
    
    private func getRepositories(query: String, page: Int) {

        if showLoadView.value == false {
            showLoadView.accept(true)
        }
        
        service?.getRepositories(query: query, page: page) { [weak self] result in
            guard let self = self else { return }
            
            self.showLoadView.accept(false)
            
            switch result {
            case .success(let reposList):
                if reposList.items.count < 10 { self.hasMoreRepos = false }
                if page == 1 {
                    self.repos.accept(reposList.items)
                } else {
                    self.repos.accept(self.repos.value + reposList.items)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setPagination() {
            guard hasMoreRepos else { return }
            page += 1
            getRepositories(query: query, page: page)
    }
    
    func setURL(_ index: Int) -> String? {
        guard let urlString = repos.value[index].html_url else { return nil }
        return urlString
    }
}
