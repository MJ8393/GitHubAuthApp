//
//  ReposViewController.swift
//  GitHubRepoInfinBankTask
//
//  Created by Mekhriddin Jumaev on 24/09/22.
//

import UIKit
import RxSwift

class ReposViewController: BaseViewController {
    
    // MARK: Properties
    
    private let viewModel: ReposViewModel
    private let bag = DisposeBag()
    
    // MARK: Init
    
    init(viewModel: ReposViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: Outlets
    
    private let noRepoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.isHidden = false
        label.text = "Please, search to find more repositories..."
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout.createFlowLayout(in: self.view))
        collectionView.register(ReposCollectionViewCell.self, forCellWithReuseIdentifier: ReposCollectionViewCell.reuseID)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    // MARK: Functions
    
    private func configureNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Repositories"
        
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a github repository"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - Extension UISearchResultsUpdating

extension ReposViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        viewModel.changeSearchBarText(filter)
    }
}

// MARK: - Extension UICollectionViewDelegate and UICollectionViewDataSource

extension ReposViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.repos.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReposCollectionViewCell.reuseID, for: indexPath) as! ReposCollectionViewCell
        cell.setData(repo: viewModel.repos.value[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let urlString = viewModel.setURL(indexPath.row) {
            open(url: urlString)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            viewModel.setPagination()
        }
    }
}

// MARK: - Extension RootView

extension ReposViewController: RootView {

    func addSubviews() {
        view.addSubview(collectionView)
        collectionView.addSubview(noRepoLabel)
    }
    
    func setConstraints() {
        noRepoLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.collectionView)
            make.centerY.equalTo(self.collectionView).offset(-250)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
    
    func bindElements() {
        viewModel.repos.subscribe(onNext: { [weak self] repos in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.noRepoLabel.isHidden = repos.isEmpty ? false : true
            }
        }).disposed(by: bag)
        
        viewModel.showLoadView.subscribe(onNext: { [weak self] isLoading in
            DispatchQueue.main.async {
                isLoading ? self?.showLoadingView() : self?.dissmissLoadingView()
            }
        }).disposed(by: bag)
    }
}
