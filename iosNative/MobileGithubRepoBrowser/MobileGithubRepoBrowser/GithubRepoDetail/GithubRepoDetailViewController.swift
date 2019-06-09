//
//  GithubRepoDetailViewController.swift
//  MobileGithubRepoBrowser
//
//  Created by Pierre Carion on 6/8/19.
//  Copyright © 2019 Pierre Carion. All rights reserved.
//

import Foundation
import UIKit

struct RepoProps {
    var title: String
    var value: String
}

class GithubRepoDetailController: UICollectionViewController {
    var githubRepo: GithubRepository?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = githubRepo?.name ?? "--"
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let repo = githubRepo {
            return repo.props.count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GithubRepoDetailCellView
        if let repo = githubRepo {
            let prop = repo.props[indexPath.item]
            cell.title = prop.name
            cell.text = prop.value
        }
        
        return cell
    }

}

