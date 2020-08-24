//
//  UniversitySectionController.swift
//  NovastoneCodeTest
//
//  Created by Anderson Gralha on 22/08/20.
//  Copyright © 2020 Anderson Gralha. All rights reserved.
//

import UIKit
import IGListKit

class UniversitySectionController: ListSectionController {
    
    private var object: University?

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 55)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        
        guard let cell = collectionContext?.dequeueReusableCellFromStoryboard(withIdentifier: "UniversityListCollectionViewCell", for: self, at: index) as? UniversityListCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        
        cell.configure(for: object)
        return cell
    }

    override func didUpdate(to object: Any) {
        guard let object = object as? University else { return }
        self.object = object
    }
    
    override func didSelectItem(at index: Int) {
        guard let object = object else { return }
        (self.viewController as? UniversityListViewController)?.delegate?.navigateToUniversityDetail(university: object)
    }

}
