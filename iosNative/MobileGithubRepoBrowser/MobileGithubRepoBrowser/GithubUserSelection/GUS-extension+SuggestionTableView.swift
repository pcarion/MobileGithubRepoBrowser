//
//  GUS-extension+SuggestionTableView.swift
//  MobileGithubRepoBrowser
//
//  Created by Pierre Carion on 6/7/19.
//  Copyright © 2019 Pierre Carion. All rights reserved.
//

import Foundation
import UIKit

extension GithubUserSelectionViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("suggestedUserName", suggestedUserName);
        return suggestedUserName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = suggestedUserName[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
