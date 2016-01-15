//
//  TakkenView.swift
//  Sint-Petrus
//
//  Created by Seppe Devogelaere on 24/12/15.
//  Copyright © 2015 Seppe Devogelaere. All rights reserved.
//

import UIKit

protocol TakSelectedDelegate: class {
    func takSelected(newTak: String)
}
class TakkenView: UICollectionViewController {
    
    
    @IBOutlet weak var collView: UICollectionView!
    
    weak var delegate: TakSelectedDelegate?
    
    let takken = ["Mini's", "Maxi's", "Welpen", "Kabouters", "Jongverkenners", "Jonggidsen",
        "Verkenners", "Gidsen", "Jalokoko", "Groepsploeg"]
    
    let images = [UIImage(named: "kapoenen"), UIImage(named: "kapoenen"), UIImage(named: "kawels"), UIImage(named: "kawels"), UIImage(named: "jonggivers"), UIImage(named: "jonggivers"), UIImage(named: "givers"), UIImage(named: "givers"), UIImage(named: "akabe"), UIImage(named: "grol")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.takken.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collView.dequeueReusableCellWithReuseIdentifier("TakkenCell", forIndexPath: indexPath) as! TakkenCell
        
        cell.imageView?.image = self.images[indexPath.row]
        cell.titleLabel?.text = self.takken[indexPath.row]
        
        cell.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).CGColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedTak = self.takken[indexPath.row]
        self.delegate?.takSelected(selectedTak)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
