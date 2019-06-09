//
//  GithubRepoDetailCellView.swift
//  MobileGithubRepoBrowser
//
//  Created by Pierre Carion on 6/8/19.
//  Copyright © 2019 Pierre Carion. All rights reserved.
//

import Foundation
import UIKit

class GithubRepoDetailCellView: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var title: String! {
        didSet {
            titleLabel.text = title
        }
    }
    var text: String! {
        didSet {
            textView.text = title
        }
    }
}
