//
//  PersonCell.swift
//  NamesToFaces
//
//  Created by Kamil Chlebuś on 16/01/2018.
//  Copyright © 2018 Kamil Chlebuś. All rights reserved.
//

import UIKit

class PersonCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = 3
        imageView.layer.masksToBounds = true
        layer.cornerRadius = 7
    }
    
}
