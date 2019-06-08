//
//  GithubUserInformationViewController.swift
//  MobileGithubRepoBrowser
//
//  Created by Pierre Carion on 6/7/19.
//  Copyright © 2019 Pierre Carion. All rights reserved.
//

import Foundation

import UIKit

class GithubUserInformationViewController: UIViewController {
    var githubUser: GithubUserModel?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var repoCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = self.githubUser {
            self.title = user.login
            self.nameLabel.text? = user.name
            self.emailLabel.text? = user.email
            self.companyLabel.text? = user.company
            self.locationLabel.text? = user.location
            self.repoCountLabel.text? = "\(user.publicReposCount)"
            self.bioTextView.text? = user.bio

            if let imageUrl = user.avatarUrl {
                GithubApi.shared.download(downloadUrl: imageUrl) { (imageData: NSData? , errorMessage: String?) in
                    if let imageData = imageData {
                        DispatchQueue.main.async {
                            
                            // #3 - Animate the appearance of the Messier image.
                            UIView.animate(withDuration: 1.0, animations: {
                                self.imageView.alpha = 1.0
                                self.imageView?.image = UIImage(data: imageData as Data)
                                self.view.setNeedsDisplay()
                            })
                        }
                    }
                }
            }
        }
    }
}
