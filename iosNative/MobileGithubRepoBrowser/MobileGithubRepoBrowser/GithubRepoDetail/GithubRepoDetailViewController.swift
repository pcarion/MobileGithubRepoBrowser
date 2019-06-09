//
//  GithubRepoDetailViewController.swift
//  MobileGithubRepoBrowser
//
//  Created by Pierre Carion on 6/8/19.
//  Copyright © 2019 Pierre Carion. All rights reserved.
//

import Foundation
import UIKit

class GithubRepoDetailController: UICollectionViewController {
    var githubRepo: GithubRepository?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = githubRepo?.name ?? "--"
        
//        let paddings:CGFloat = 2.0
//        let numberofItemsPerRow:CGFloat = 3.0
//
//        let collectionViewWidth = collectionView?.frame.width
//        let itemWidth = (collectionViewWidth! - paddings) / numberofItemsPerRow
//
//        let layout = collectionViewLayout as UICollectionViewLayout
//        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 105
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GithubRepoDetailCellView
        
        cell.title = "title \(String(describing: indexPath))"
        cell.text = ".. and text.."
        
        return cell
    }

}

