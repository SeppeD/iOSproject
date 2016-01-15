//
//  DetailViewController.swift
//  Sint-Petrus
//
//  Created by Seppe Devogelaere on 26/12/15.
//  Copyright © 2015 Seppe Devogelaere. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var takImage = UIImage()
    
    
    override func viewDidLoad() {
        self.refreshDetailView()
    }
    
    
    var vergadering: Vergadering! {
        didSet (newVergadering) {
            self.refreshDetailView()
        }
    }
    
    func refreshDetailView() {
        titleLabel?.text = ""
        dayLabel?.text = ""
        hourLabel?.text = ""
        descriptionLabel?.text = ""
        
        if let vergadering: Vergadering = self.vergadering {
            
            self.title = vergadering.titel
            
            titleLabel?.text = vergadering.titel
            dayLabel?.text = vergadering.dag
            hourLabel?.text = vergadering.uren
            descriptionLabel?.text = vergadering.beschrijving
            
            
            if (vergadering.image != "") {
                if let url = NSURL(string: vergadering.image!) {
                    if let data = NSData(contentsOfURL: url) {
                        self.imageView?.image = UIImage(data: data)
                    } else {
                        self.imageView?.image = takImage
                    }
                }
            } else {
                self.imageView?.image = takImage
            }
        }
    }
    
    
}