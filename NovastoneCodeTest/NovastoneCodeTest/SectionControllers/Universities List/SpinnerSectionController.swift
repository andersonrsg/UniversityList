//
//  SpinnerSectionController.swift
//  NovastoneCodeTest
//
//  Created by Anderson Gralha on 22/08/20.
//  Copyright © 2020 Anderson Gralha. All rights reserved.
//

import IGListKit

class SpinnerSectionController {
    
    static func spinnerSectionController() -> ListSingleSectionController {
        let configureBlock = { (item: Any, cell: UICollectionViewCell) in
            guard let cell = cell as? SpinnerCollectionViewCell else { return }
            cell.activityIndicator.startAnimating()
        }

        let sizeBlock = { (item: Any, context: ListCollectionContext?) -> CGSize in
            guard let context = context else { return .zero }
            return CGSize(width: context.containerSize.width, height: 100)
        }

        return ListSingleSectionController(cellClass: SpinnerCollectionViewCell.self,
                                           configureBlock: configureBlock,
                                           sizeBlock: sizeBlock)
    }
}
