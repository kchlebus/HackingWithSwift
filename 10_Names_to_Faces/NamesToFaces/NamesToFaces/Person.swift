//
//  Person.swift
//  NamesToFaces
//
//  Created by Kamil Chlebuś on 17/01/2018.
//  Copyright © 2018 Kamil Chlebuś. All rights reserved.
//

import Foundation

class Person: NSObject {
    
    var name: String
    var imagePath: URL
    
    init(name: String, imagePath: URL) {
        self.name = name
        self.imagePath = imagePath
    }
    
}
