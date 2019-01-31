//
//  DetailViewController.swift
//  PhotoCollection
//
//  Created by Konstantinos Rizos on 28/01/2019.
//  Copyright © 2019 Konstantinos Rizos. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
        navigationItem.title = "Photo"
        
    }
}

