//
//  DataHolder.swift
//  final-ordinario-todolist
//
//  Created by Olivia Sartorius Freschet on 26/2/20.
//  Copyright © 2020 Olivia Sartorius Freschet. All rights reserved.
//

import UIKit
import Firebase


class DataHolder: NSObject {
    
    static let sharedInstance:DataHolder = DataHolder()
    
    func initFirebase() {
        FirebaseApp.configure()
    }
    

}
