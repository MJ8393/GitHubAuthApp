//
//  ReposTableViewCell.swift
//  GitHubRepoInfinBankTask
//
//  Created by Mekhriddin Jumaev on 24/09/22.
//

import UIKit
import SDWebImage

final class ReposCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    static let reuseID = "FavoriteCell"
    
    // MARK: Outlets
    
    private let reposName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let devLanguage: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "Dev. Language: Not found"
        return label
    }()
    
    // MARK: View lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    
    func setData(repo: Repository) {
        reposName.text = repo.name

        if let language = repo.language {
            devLanguage.text = "Dev. Language: " + language
        }
        
        avatarImageView.sd_setImage(with: URL(string: repo.owner.avatar_url))
    }
}

// MARK: - Extension RootView

extension ReposCollectionViewCell: RootView {

    func addSubviews() {
        addSubview(reposName)
        addSubview(avatarImageView)
        addSubview(devLanguage)
    }
    
    func setConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(20)
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.centerY.equalTo(self)
        }
        
        reposName.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(30)
            make.trailing.equalTo(self).offset(-20)
            make.height.height.equalTo(25)
            make.top.equalTo(self).offset(10)
        }
        
        devLanguage.snp.makeConstraints { make in
            make.leading.equalTo(reposName.snp.leading)
            make.trailing.equalTo(self).offset(-20)
            make.height.equalTo(20)
            make.top.equalTo(reposName.snp.bottom).offset(10)
        }
    }
}
