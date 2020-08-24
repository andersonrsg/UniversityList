//
//  UniversityListCollectionViewCell.swift
//  NovastoneCodeTest
//
//  Created by Anderson Gralha on 22/08/20.
//  Copyright © 2020 Anderson Gralha. All rights reserved.
//

import UIKit

class UniversityListCollectionViewCell: UICollectionViewCell {

    static let font: UIFont = UIFont()
    
    var object: University! {
        didSet {
            self.nameLabel.text = self.object.name
            self.countryLabel.text = self.object.country
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(for university: University?) {
        guard let university = university else { return }
        self.object = university
    }

}
