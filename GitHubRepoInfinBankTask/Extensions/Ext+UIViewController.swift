//
//  Ext+UIViewController.swift
//  GitHubRepoInfinBankTask
//
//  Created by Mekhriddin Jumaev on 27/09/22.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    
    func open(url: String) {
        if let newUrl = URL(string: url.trimmed) {
            if UIApplication.shared.canOpenURL(newUrl) {
                UIApplication.shared.open(newUrl, completionHandler: nil)
            }
        }
    }
    
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemGray5
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    func dissmissLoadingView(){
        DispatchQueue.main.async {
            if let container = containerView {
                container.removeFromSuperview()
            }
            containerView = nil
        }
    }
    
}
