//
//  LoginViewController.swift
//  GitHubRepoInfinBankTask
//
//  Created by Mekhriddin Jumaev on 26/09/22.
//

import UIKit
import WebKit
import RxSwift

class LoginViewController: BaseViewController {
    
    // MARK: Properties
    
    private let viewModel: LoginViewModel
    private let bag = DisposeBag()
    
    // MARK: Init
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: Outlets
    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        return webView
    }()
    
    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
        openWebView()
    }
    
    // MARK: Actions
    
    @objc func cancelAction() {
        navigationController?.popViewController(animated: true)
    }

    @objc func refreshAction() {
        self.webView.reload()
    }
    
    // MARK: Functions
    
    func configureNavigationBar() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelAction))
        navigationItem.leftBarButtonItem = cancelButton
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshAction))
        navigationItem.rightBarButtonItem = refreshButton
        navigationItem.title = "github.com"
    }
    
    func openWebView() {
        let urlRequest = viewModel.setURLRequest()
        self.webView.load(urlRequest)
    }
}

// MARK: - Extension WKNavigationDelegate

extension LoginViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let request = navigationAction.request
        if let code = viewModel.getGitHubCode(request: request) {
            viewModel.getAccessToken(code)
        }
        decisionHandler(.allow)
    }
}

// MARK: - Extension RootView

extension LoginViewController: RootView {
    
    func addSubviews() {
        view.addSubview(webView)
    }
    
    func setConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
    }
    
    func bindElements() {
        viewModel.pushReposVC.subscribe(onNext: { [weak self] pushReposVC in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let service: NetworkManagerProtocol = NetworkManager()
                let vc = ReposViewController(viewModel: ReposViewModel(service: service))
                pushReposVC ? self.navigationController?.pushViewController(vc, animated: true) : print("Error")
            }
        }).disposed(by: bag)
    }
}
