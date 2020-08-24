//
//  UniversityDetailViewModel.swift
//  NovastoneCodeTest
//
//  Created by Anderson Gralha on 21/08/20.
//  Copyright © 2020 Anderson Gralha. All rights reserved.
//

import UIKit

protocol UniversityDetailViewModelDelegate {
    func didSetWebPage(url: String)
}

class UniversityDetailViewModel {
    var url: String = ""
    var delegate: UniversityDetailViewModelDelegate?
    
    func setWebPage(url: String) {
        self.url = url
        delegate?.didSetWebPage(url: self.url)
    }
    
}
