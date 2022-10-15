//
//  LoginViewModel.swift
//  GitHubRepoInfinBankTask
//
//  Created by Mekhriddin Jumaev on 25/09/22.
//

import Foundation
import RxSwift
import RxRelay

final class LoginViewModel {
    
    // MARK: Properties
    
    let pushReposVC = BehaviorRelay<Bool>(value: false)
    private var service: NetworkManagerProtocol?
    
    // MARK: Init

    init(service: NetworkManagerProtocol) {
        self.service = service
    }
    
    // MARK: Functions
    
    func setURLRequest() -> URLRequest{
        let uuid = UUID().uuidString
        let authURL = Constants.authURL + uuid
        if let url = URL(string: authURL) {
            let urlRequest = URLRequest(url: url)
            return urlRequest
        }
        return URLRequest(url: URL(string: "")!)
    }
    
    func getGitHubCode(request: URLRequest) -> String? {
        let strURL = (request.url?.absoluteString)! as String
        if strURL.hasPrefix(Constants.redirectURL) {
            if let lowRange = strURL.range(of: "?code="), let upRange = strURL.range(of: "&state=") {
                let code = strURL[lowRange.upperBound..<upRange.lowerBound]
                return String(code)
            }
        }
        return nil
    }
    
    func getAccessToken(_ code: String) {
        service?.getGitGubToken(authCode: code) { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let tokenInfo):
                // save to UserDefaults
                UD.access_token = tokenInfo.access_token
                UD.token_type = tokenInfo.token_type
                UD.scope = tokenInfo.scope
                self.pushReposVC.accept(true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
