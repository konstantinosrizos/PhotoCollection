//
//  SectionHeaderView.swift
//  PhotoCollection
//
//  Created by Konstantinos Rizos on 28/01/2019.
//  Copyright © 2019 Konstantinos Rizos. All rights reserved.
//

import UIKit


class SectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    var photoCategory: PhotoCategory! {
        didSet {
            categoryTitleLabel.text = photoCategory.title
            categoryImageView.image = UIImage(named: photoCategory.categoryImageName)
        }
    }
}
