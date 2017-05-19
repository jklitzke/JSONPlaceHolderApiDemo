//
//  DetailViewController.swift
//  JSONPlaceHolderApiDemo
//
//  Created by James Klitzke on 1/18/17.
//  Copyright © 2017 James Klitzke. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if  let address = self.user?.address,
        let street = address.street,
        let city = address.city,
        let zipcode = address.zipcode {
            if let label = self.detailDescriptionLabel {
                label.text = "Address: \(street), \(city), \(zipcode)"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var user: User? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }


}

