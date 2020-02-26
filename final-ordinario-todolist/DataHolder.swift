//
//  DataHolder.swift
//  final-ordinario-todolist
//
//  Created by Olivia Sartorius Freschet on 26/2/20.
//  Copyright © 2020 Olivia Sartorius Freschet. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class DataHolder: NSObject {
    
    static let sharedInstance:DataHolder = DataHolder()
    
    var firUser: User?
    
    func initFirebase() {
        FirebaseApp.configure()
        
        Auth.auth().addStateDidChangeListener {(auth, user) in
            print("listener called")
            if let usr = user {
                DataHolder.sharedInstance.firUser = usr
            }
        }
    }
    
}
