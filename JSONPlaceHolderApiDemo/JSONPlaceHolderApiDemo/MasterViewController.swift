//
//  MasterViewController.swift
//  JSONPlaceHolderApiDemo
//
//  Created by James Klitzke on 1/18/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    let showDetailSegue = "showDetail"
    let cellIdentifier = "Cell"
    
    var detailViewController: DetailViewController? = nil
    
    lazy var jsonServices : JSONPlaceHolderServicesProtocol = JSONPlaceHolderServices.sharedInstnace
    var users = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        jsonServices.getListOfUsers(success: {
            [unowned self] users in
            self.users = users
            DispatchQueue.main.async {
                [unowned self] in
                self.tableView.reloadData()
            }
        }, failure: {
            [unowned self] error, response in
            self.showServiceError()
        })

    }

    func showServiceError() {
        let alert = UIAlertController(title: "We're Sorry", message: "We couldn't get the list of libraires right now.  Please try again later.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showDetailSegue {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.user = users[indexPath.row]
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        cell.textLabel!.text = users[indexPath.row].username ?? "N/A"
        return cell
    }
}

