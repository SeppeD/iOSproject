//
//  Vergadering.swift
//  Sint-Petrus
//
//  Created by Seppe Devogelaere on 26/12/15.
//  Copyright © 2015 Seppe Devogelaere. All rights reserved.
//

import UIKit

class Vergadering {
    var id: Int?
    var dag: String?
    var titel: String?
    var uren: String?
    var beschrijving: String?
    var image: String?
    
    init(json: NSDictionary) {
        self.id = json["id"] as? Int
        self.dag = json["dag"] as? String
        self.titel = json["titel"] as? String
        self.uren = json["uren"] as? String
        self.beschrijving = json["beschrijving"] as? String
        self.image = json["image"] as? String
    }
    
    init(id: Int, dag: String, titel: String, uren: String, beschrijving: String, image: String) {
        self.id = id
        self.dag = dag
        self.titel = titel
        self.uren = uren
        self.beschrijving = beschrijving
        self.image = image
    }
    
    init (){}
}