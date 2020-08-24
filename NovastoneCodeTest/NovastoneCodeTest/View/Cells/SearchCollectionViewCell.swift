//
//  SearchCollectionViewCell.swift
//  NovastoneCodeTest
//
//  Created by Anderson Gralha on 22/08/20.
//  Copyright © 2020 Anderson Gralha. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        self.contentView.addSubview(view)
        return view
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        searchBar.frame = contentView.bounds
    }
    
}
