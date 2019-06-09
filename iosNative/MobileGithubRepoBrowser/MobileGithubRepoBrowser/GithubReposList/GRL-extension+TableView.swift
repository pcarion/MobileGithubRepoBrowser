//
//  GRL-extension+TableView.swift
//  MobileGithubRepoBrowser
//
//  Created by Pierre Carion on 6/8/19.
//  Copyright © 2019 Pierre Carion. All rights reserved.
//

import Foundation
import UIKit

extension GithubReposListViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        }
        if let cell = cell {
            cell.textLabel?.text = self.repositories[indexPath.row].name
            cell.detailTextLabel?.text = self.repositories[indexPath.row].value(propName: "description")
            cell.accessoryType = .disclosureIndicator
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // we update the property containing the selectd repo so
        // that we can then retrieve when performing the segue transition
        let repository = self.repositories[indexPath.row] as GithubRepository
        self.selectedRepo = repository

        // showRepoDetails
        performSegue(withIdentifier: "showRepoDetails", sender: self)
    }
    
}
