//
//  ContactViewController.swift
//  Sint-Petrus
//
//  Created by Seppe Devogelaere on 15/01/16.
//  Copyright © 2016 Seppe Devogelaere. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
    
    @IBOutlet weak var contactImageView: UIImageView!
    
    @IBOutlet weak var takLabel: UILabel!
    
    
    @IBOutlet weak var leiding1: UILabel!
    @IBOutlet weak var leiding2: UILabel!
    @IBOutlet weak var leiding3: UILabel!
    @IBOutlet weak var leiding4: UILabel!
    @IBOutlet weak var leiding5: UILabel!
    @IBOutlet weak var leiding6: UILabel!
    
    @IBOutlet weak var smsLeiding1: UIButton!
    @IBOutlet weak var smsLeiding2: UIButton!
    @IBOutlet weak var smsLeiding3: UIButton!
    @IBOutlet weak var smsLeiding4: UIButton!
    @IBOutlet weak var smsLeiding5: UIButton!
    @IBOutlet weak var smsLeiding6: UIButton!
    
    @IBOutlet weak var callLeiding1: UIButton!
    @IBOutlet weak var callLeiding2: UIButton!
    @IBOutlet weak var callLeiding3: UIButton!
    @IBOutlet weak var callLeiding4: UIButton!
    @IBOutlet weak var callLeiding5: UIButton!
    @IBOutlet weak var callLeiding6: UIButton!
    
    
    let miniLeiding = ["Isaac", "+32476406410",
        "Noor","+32492608003",
        "Thijs","+32498450480",
        "Alix","+32488750760",
        "Margaux","+32470055900"]
    
    let maxiLeiding = ["Pauline","+32472858847",
        "Joachim","+32489947288",
        "Lieze","+32489303202",
        "Wolf","+32474090851",
        "Anoek","+32476824608"]
    
    let welpenLeiding = ["Akela","+32470380505",
        "Baloo","+32492558206",
        "Raksha","+32470566686",
        "Rikki-tikki-tavi","+32474197937",
        "Shere-Khan","+32489303180"]
    
    let kabouterLeiding = ["Roesh","+32498378410",
        "Bamboo","+32478082471",
        "Eska","+32497549617",
        "Sila","+32488408664",
        "Mila","+32471737179"]
    
    let jongverkennerLeiding = ["Hellen","+32471496338",
        "Ella","+32476364589",
        "Benjamin","+32473587023",
        "Matthias","+32474330693"]
    
    let jonggidsenLeiding = ["Marie","+32473464694",
        "Geraldine","+32479025053",
        "Helena","+32492558207",
        "Lore","+32497899853"]
    
    let verkennerLeiding = ["Liesbet","+324494318386",
        "Romeo","+32479838663",
        "Alix","+32496511995",
        "Laurens","+32479174448"]
    
    let gidsenLeiding = ["Lucas","+32471738141",
        "Hannah","+32472308795",
        "Seppe","+32486691943",
        "Timothy","+32497305696"]
    
    let jaloLeiding = ["Dries","+32498248172",
        "Louise","+32497175548",
        "Margo","+32493713081",
        "Eline","+32495837328"]
    
    let groepsleiding = ["Hendrik Taelman", "+32477067778",
        "Femke Van Acker", "+32489303190",
        "Dries Van Ryckeghem", "+32498248172",
        "Jil Den Hartog", "+32477272576",
        "Ward Buyssens", "+32491439027",
        "Guido Eeckhaoudt", "+32496025117"
    ]
    
    
    var takImage = UIImage()
    var leiding = [String]()
    
    
    override func viewDidLoad() {
        self.refreshDetailView()
    }
    
    
    var tak: String! {
        didSet (newTak) {
            self.refreshDetailView()
        }
    }
    
    func refreshDetailView() {
        self.contactImageView?.image = takImage
        self.title = tak
        
        fillLabels()
        
    }
    
    
    
    func fillLabels() {
        
        leiding = setLeidingArray()
        
        takLabel?.text = tak
        
        leiding5?.hidden = true
        leiding6?.hidden = true
        smsLeiding5?.hidden = true
        smsLeiding6?.hidden = true
        callLeiding5?.hidden = true
        callLeiding6?.hidden = true
        
        
        leiding1?.text = leiding[0]
        leiding2?.text = leiding[2]
        leiding3?.text = leiding[4]
        leiding4?.text = leiding[6]
        
        if leiding.count > 9 {
            leiding5?.hidden = false
            smsLeiding5?.hidden = false
            callLeiding5?.hidden = false
            
            leiding5?.text = leiding[8]
        }
        
        if leiding.count > 11 {
            leiding6?.hidden = false
            smsLeiding6?.hidden = false
            callLeiding6?.hidden = false
            
            leiding6?.text = leiding[10]
        }
        
    }
    
    
    func setLeidingArray() -> [String] {
        
        switch tak {
            
        case "Mini's":
            return miniLeiding
        case "Maxi's":
            return maxiLeiding
        case "Welpen":
            return welpenLeiding
        case "Kabouters":
            return kabouterLeiding
        case "Jongverkenners":
            return jongverkennerLeiding
        case "Jonggidsen":
            return jonggidsenLeiding
        case "Verkenners":
            return verkennerLeiding
        case "Gidsen":
            return gidsenLeiding
        case "Jalokoko":
            return jaloLeiding
        default:
            return groepsleiding
            
        }
        
    }
    
    
    @IBAction func callLeider(sender: UIButton) {
        
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: "tel://")!) {
            
            let tel = "tel://" + leiding[setLeidingGetal(sender)]
            UIApplication.sharedApplication().openURL(NSURL(string: tel)!)
        } else {
            
            let alertController = UIAlertController(title: leiding[setLeidingGetal(sender)-1] + " bellen", message:
                "Dit apparaat kan geen telefoongesprekken starten.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func smsLeider(sender: UIButton) {
        if UIApplication.sharedApplication().canOpenURL(NSURL(string: "sms://")!) {
            
            let sms = "sms://" + leiding[setLeidingGetal(sender)]
            UIApplication.sharedApplication().openURL(NSURL(string: sms)!)
        } else {
            
            let alertController = UIAlertController(title: leiding[setLeidingGetal(sender)-1] + " een bericht sturen", message:
                "Dit apparaat kan geen berichten sturen.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    
    func setLeidingGetal(button: UIButton) -> Int {
        var leidingGetal = 0
        
        switch button {
        case smsLeiding1, callLeiding1:
            leidingGetal = 1
        case smsLeiding2, callLeiding2:
            leidingGetal = 3
        case smsLeiding3, callLeiding3:
            leidingGetal = 5
        case smsLeiding4, callLeiding4:
            leidingGetal = 7
        case smsLeiding5, callLeiding5:
            leidingGetal = 9
        case smsLeiding6, callLeiding6:
            leidingGetal = 11
        default:
            leidingGetal = 0
        }
        
        return leidingGetal
    }

    
}
