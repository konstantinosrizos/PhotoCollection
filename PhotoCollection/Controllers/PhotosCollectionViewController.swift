//
//  PhotosCollectionViewController.swift
//  PhotoCollection
//
//  Created by Konstantinos Rizos on 28/01/2019.
//  Copyright © 2019 Konstantinos Rizos. All rights reserved.
//

import UIKit


class PhotosCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    var photoCategories: [PhotoCategory] = PhotosLibrary.fetchPhotos()
    
    struct Storyboard {
        static let photoCell = "PhotoCell"
        static let sectionHeaderView = "SectionHeaderView"
        static let showDetailVC = "ShowImageDetail"
        
        static let leftAndRightPaddings: CGFloat = 2.0
        static let numberOfItemsPerRow: CGFloat = 3.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionViewWidth = collectionView?.frame.width
        let itemWidth = (collectionViewWidth! - Storyboard.leftAndRightPaddings) / Storyboard.numberOfItemsPerRow
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    // Target Action
    @IBAction func addNewItemTap(_ sender: Any) {
        
        addFirstCategoryImage()
        addSecondCategoryImage()
        addThirdCategoryImage()
        addFourthCategoryImage()
    }
    
    func addFirstCategoryImage() {
        
        // Get random image
        let firstCategoryImageNames = photoCategories[0].imageNames
        let randomIndex = Int(arc4random()) % firstCategoryImageNames.count
        let randomImageName = firstCategoryImageNames[randomIndex]
        
        // Add new image into your data model
        photoCategories[0].imageNames.append(randomImageName)
        
        // Update the Collection View
        // collectionView?.reloadData()
        let insertedIndexPath = IndexPath(item: firstCategoryImageNames.count, section: 0)
        collectionView?.insertItems(at: [insertedIndexPath])
    }
    
    func addSecondCategoryImage() {
        
        // Get random image
        let firstCategoryImageNames = photoCategories[1].imageNames
        let randomIndex = Int(arc4random()) % firstCategoryImageNames.count
        let randomImageName = firstCategoryImageNames[randomIndex]
        
        // Add new image into your data model
        photoCategories[1].imageNames.append(randomImageName)
        
        // Update the Collection View
        // collectionView?.reloadData()
        let insertedIndexPath = IndexPath(item: firstCategoryImageNames.count, section: 1)
        collectionView?.insertItems(at: [insertedIndexPath])
    }
    
    func addThirdCategoryImage() {
        
        // Get random image
        let firstCategoryImageNames = photoCategories[2].imageNames
        let randomIndex = Int(arc4random()) % firstCategoryImageNames.count
        let randomImageName = firstCategoryImageNames[randomIndex]
        
        // Add new image into your data model
        photoCategories[2].imageNames.append(randomImageName)
        
        // Update the Collection View
        // collectionView?.reloadData()
        let insertedIndexPath = IndexPath(item: firstCategoryImageNames.count, section: 2)
        collectionView?.insertItems(at: [insertedIndexPath])
    }
    
    func addFourthCategoryImage() {
        
        // Get random image
        let firstCategoryImageNames = photoCategories[3].imageNames
        let randomIndex = Int(arc4random()) % firstCategoryImageNames.count
        let randomImageName = firstCategoryImageNames[randomIndex]
        
        // Add new image into your data model
        photoCategories[3].imageNames.append(randomImageName)
        
        // Update the Collection View
        // collectionView?.reloadData()
        let insertedIndexPath = IndexPath(item: firstCategoryImageNames.count, section: 3)
        collectionView?.insertItems(at: [insertedIndexPath])
    }
    
    
    // UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return photoCategories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoCategories[section].imageNames.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.photoCell, for: indexPath) as! PhotoCell
        let photoCategory = photoCategories[indexPath.section]
        let imageNames = photoCategory.imageNames
        let imageName = imageNames[indexPath.item]
        
        cell.imageName = imageName
        cell.delegate = self
        
        return cell
    }
    
    // Section Header View
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Storyboard.sectionHeaderView, for: indexPath) as! SectionHeaderView
        let category = photoCategories[indexPath.section]
        sectionHeaderView.photoCategory = category
        
        return sectionHeaderView
    }
    
    // UICollectionViewDelegate
    
    var selectedImage: UIImage!
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let category = photoCategories[indexPath.section]
        selectedImage = UIImage(named: category.imageNames[indexPath.item])
        
        performSegue(withIdentifier: Storyboard.showDetailVC, sender: nil)
    }
    
    // Delete Items
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        addBarButtonItem.isEnabled = !editing
        if let indexPaths = collectionView?.indexPathsForVisibleItems {
            for indexPath in indexPaths {
                if let cell = collectionView?.cellForItem(at: indexPath) as? PhotoCell {
                    cell.isEditing = editing
                }
            }
        }
    }
    
    // Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Storyboard.showDetailVC {
            let detailVC = segue.destination as! DetailViewController
            detailVC.image = selectedImage
        }
    }
}

extension PhotosCollectionViewController: PhotoCellDelegate {
    
    func delete(cell: PhotoCell) {
        if let indexPath = collectionView?.indexPath(for: cell) {
            photoCategories[indexPath.section].imageNames.remove(at: indexPath.item)
            collectionView?.deleteItems(at: [indexPath])
        }
    }
}
