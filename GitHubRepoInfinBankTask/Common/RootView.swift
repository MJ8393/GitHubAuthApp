//
//  RootView.swift
//  GitHubRepoInfinBankTask
//
//  Created by Mekhriddin Jumaev on 25/09/22.
//

protocol RootView {
    func configureUI()
    
    func addSubviews()
    func setConstraints()
    func bindElements()
}

extension RootView {
    func configureUI() {
        addSubviews()
        setConstraints()
        bindElements()
    }
    
    func bindElements() { }
}
