//
//  Ext+UICollectionViewFlowLayout.swift
//  GitHubRepoInfinBankTask
//
//  Created by Mekhriddin Jumaev on 27/09/22.
//

import UIKit

extension UICollectionViewFlowLayout {
    
    func createFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 20
        let availableWidth = width - padding * 2
        let itemWidth = availableWidth

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 25
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 80)
        
        return flowLayout
    }
    
}
