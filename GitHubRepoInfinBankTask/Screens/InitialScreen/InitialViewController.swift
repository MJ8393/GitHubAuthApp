//
//  InitialViewController.swift
//  GitHubRepoInfinBankTask
//
//  Created by Mekhriddin Jumaev on 24/09/22.
//

import UIKit
import SnapKit

final class InitialViewController: BaseViewController {
    
    // MARK: Outlets

    lazy var gitHubLoginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.systemGreen
        button.setTitle("Login with GitHub", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(LoginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var gitHubImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "github")
        return imageView
    }()
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
   
    // MARK: Actions
    
    @objc func LoginButtonPressed() {
        let service: NetworkManagerProtocol = NetworkManager()
        let vc = LoginViewController(viewModel: LoginViewModel(service: service))
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extension RootView

extension InitialViewController: RootView {
    
    func addSubviews() {
        view.addSubview(gitHubLoginButton)
        view.addSubview(gitHubImageView)
    }
    
    func setConstraints() {
        gitHubLoginButton.snp.makeConstraints { make in
            make.center.equalTo(self.view)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
        gitHubImageView.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(gitHubLoginButton).offset(-200)
            make.size.equalTo(CGSize(width: 150, height: 150))
        }
    }
}
