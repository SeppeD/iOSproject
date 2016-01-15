//
//  VergaderingViewController.swift
//  Sint-Petrus
//
//  Created by Seppe Devogelaere on 26/12/15.
//  Copyright © 2015 Seppe Devogelaere. All rights reserved.
//

import UIKit

class VergaderingViewController: UITableViewController, TakSelectedDelegate {
    
    var urlTak = ""
    var geselecteerdeTak = ""
    var takImage = UIImage()
    var vergaderingen = [Vergadering]()
    var geselecteerdeVergadering = Vergadering(id: 0, dag: "", titel: "",uren: "",beschrijving: "",image: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        if Reachability.isConnectedToNetwork() == false {
            let alertController = UIAlertController(title: "Geen internetverbinding", message:
                "Er konden geen vergaderingen geladen worden, controleer of u verbonden bent met het internet.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section==0) {
            return 1
        }
        return vergaderingen.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 {
            self.performSegueWithIdentifier("showContact", sender: self)
        } else {
            geselecteerdeVergadering = vergaderingen[indexPath.row]
            self.performSegueWithIdentifier("showVergadering", sender: self)
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.section==0) {
            return 50
        }
        return 80
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.section==0) {
            let cell: ContactCell = tableView.dequeueReusableCellWithIdentifier("ContactCell", forIndexPath: indexPath) as! ContactCell
            
            
            /*let selectedView = UIView()
            selectedView.backgroundColor = UIColor.brownColor()
            cell.selectedBackgroundView = selectedView*/
            
            return cell
            
        }
        else {
            
            let cell: VergaderingCell = tableView.dequeueReusableCellWithIdentifier("VergaderingCell", forIndexPath: indexPath) as! VergaderingCell
            
            cell.dayLabel.text = vergaderingen[indexPath.row].dag
            cell.titleLabel.text = vergaderingen[indexPath.row].titel
            cell.vergaderingImage.image = takImage
            
            let selectedView = UIView()
            selectedView.backgroundColor = UIColor.brownColor()
            cell.selectedBackgroundView = selectedView
            
            return cell
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showTakken") {
            let takkenView = segue.destinationViewController as! TakkenView
            takkenView.delegate = self;
        }
        if segue.identifier == "showVergadering" {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            controller.navigationItem.leftItemsSupplementBackButton = true
            controller.vergadering = geselecteerdeVergadering
            controller.takImage = takImage
            
            
        } else if segue.identifier == "showContact" {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! ContactViewController
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            controller.navigationItem.leftItemsSupplementBackButton = true
            controller.tak = geselecteerdeTak
            controller.takImage = takImage
        }
        
    }
    
    
    func takSelected(newTak: String) {
        geselecteerdeTak = newTak
        print("Tak is changed: " + geselecteerdeTak)
        self.setAttributes(geselecteerdeTak)
        self.refreshVergaderingView()
    }
    
    func refreshVergaderingView() {
        self.title = geselecteerdeTak
        self.loadData()
    }
    
    func setAttributes(selectedTak: String) {
        let charSet = Set<Character>("abcdefghijklmnopqrstuvwxyz".characters)
        urlTak = String(selectedTak.lowercaseString.characters.filter {charSet.contains($0)})
        var takImageString = ""
        
        if (urlTak == "minis" || urlTak == "maxis") {
            takImageString = "kapoenen"
        } else if (urlTak == "welpen" || urlTak == "kabouters") {
            takImageString = "kawels"
        } else if (urlTak == "jongverkenners" || urlTak == "jonggidsen") {
            takImageString = "jonggivers"
        } else if (urlTak == "verkenners" || urlTak == "gidsen") {
            takImageString = "givers"
        } else if (urlTak == "jalokoko") {
            takImageString = "akabe"
        } else if (urlTak == "groepsploeg") {
            takImageString = "grol"
        }
        
        takImage = UIImage(named: takImageString)!
        
        
    }
    
    func loadData() {
        
        if geselecteerdeTak == "" {
            takSelected("Groepsploeg")
        }
        
        vergaderingen.removeAll()
        
        if Reachability.isConnectedToNetwork() == true {
            
            let url = NSURL(string: "http://seppedevogelaere.tk/apps/" + urlTak + ".json")
            print(url)
            
            if let JSONData = NSData(contentsOfURL: url!) {
                do {
                    let parsed = try NSJSONSerialization.JSONObjectWithData(JSONData, options: .MutableContainers) as? NSArray
                    
                    for verg in parsed! {
                        let verg = Vergadering(json: verg as! NSDictionary)
                        vergaderingen.append(verg)
                    }
                    
                    //print(parsed)
                    print(vergaderingen.count)
                    
                    
                } catch let parseError {
                    print(parseError)
                }
            }
            
        }
        
        self.tableView.reloadData()
    }
    
}