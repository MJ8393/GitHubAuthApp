//
//  BaseViewController.swift
//  GitHubRepoInfinBankTask
//
//  Created by Mekhriddin Jumaev on 25/09/22.
//

import UIKit

open class BaseViewController: UIViewController {
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "")
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable, message: "")
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
    }

}

