//
//  AllUsersViewController.swift
//  GithubProfileList
//
//  Created by Pankaj Bhardwaj on 04/08/18.
//  Copyright © 2018 pankajBhardwaj. All rights reserved.
//

import UIKit

protocol UserDetailRouter {
    func routeToUserDetailController(selectedUser:UserResponseDTO)
}

class AllUsersViewController: BaseViewController {
    var viewModel: AllUsersViewModel?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var refreshControl:UIRefreshControl!
    @IBOutlet weak var lefrBarButtonItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewModel = AllUsersViewModel()
        initializeBasicThings()
        fetchData()
        initRefreshControl()
    }
    private func initializeBasicThings() {
        // Change font size for bar Button
        lefrBarButtonItem.setTitleTextAttributes([kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 22, weight: .bold)], for: .normal)
        // Register custom cell to the tableview
        self.tableView?.register(cell: UserTableViewCell.self)
    }
    // Asking Data from view Model
    @objc func fetchData(){
        viewModel?.getUserInfoFromStarting(completionHandler: { (message) in
            if message != nil{
                //show Alert
                if let msg = message{
                    self.alert(message: msg)
                }
                self.refreshControl.endRefreshing()
            }else {
                self.tableView?.reloadData()
                self.activityIndicator.stopAnimating()
                self.refreshControl.endRefreshing()
            }
        })
    }
    private func initRefreshControl(){
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(fetchData), for: UIControlEvents.valueChanged)
        tableView!.addSubview(refreshControl)
    }
}

// Tableview dalegates method
extension AllUsersViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedUser = viewModel?.arrUserData?[indexPath.item]
        {
            self.routeToUserDetailController(selectedUser: selectedUser)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let count = viewModel?.arrUserData?.count {
            if indexPath.row == count - 1 && viewModel?.boolLoading == false && viewModel?.boolMoreDataAvailable == true {
                self.viewModel?.getNextUserInfo(completionHandler: { (message) in
                    if message != nil {
                        // Show Alert
                        if let msg = message{
                            self.alert(message: msg)
                        }
                    }else {
                        self.tableView?.reloadData()
                    }
                })
            }
        }
    }
}
// Tableview data source
extension AllUsersViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.arrUserData?.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UserTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        let user = viewModel?.arrUserData?[indexPath.item]
        cell.updateInterface(title: user?.login)
        
        cell.sessionTask?.cancel()
        cell.sessionTask = cell.userImageView.downloadImage(from: (user?.avatar_url)!, placeholderImageName: "placeholder")
        return cell
    }
}
// Routing
extension  AllUsersViewController : UserDetailRouter {
    func routeToUserDetailController(selectedUser: UserResponseDTO) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let chatViewModel = ChatViewModel()
        chatViewModel.userSelected = selectedUser
        let controller:ChatViewController? = storyboard.instantiateVC()
        controller?.viewModel = chatViewModel
        self.navigationController?.pushViewController(controller ?? UIViewController(), animated: true)
    }
}
