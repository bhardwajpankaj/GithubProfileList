//
//  BaseViewController.swift
//  GithubProfileList
//
//  Created by Pankaj Bhardwaj on 04/08/18.
//  Copyright © 2018 pankajBhardwaj. All rights reserved.
//

import UIKit
// This is the baseviewcontroller that is for having common things for the controllers
class BaseViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Current ViewConroller Loaded :",self)
        // Do any additional setup after loading the view.
        initializeTable()
    }
    
    func initializeTable()
    {
        self.tableView?.rowHeight = UITableViewAutomaticDimension;
        self.tableView?.estimatedRowHeight = 44.0 // set to your "average" cell height is
    }
}
