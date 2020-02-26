//
//  VCTable.swift
//  final-ordinario-todolist
//
//  Created by Olivia Sartorius Freschet on 26/2/20.
//  Copyright © 2020 Olivia Sartorius Freschet. All rights reserved.
//

import UIKit
import FirebaseAuth

class VCTable: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var tVCell: TableViewCell!     outlets cannot be references to repeated content - tvc elem already connectet to TVC class
    
    var usr:User?
    
//create TableView obj and set requirements
//    func instantiateUITV() -> UITableView {
//        //let tableV: UITableView = {
//            let tableView = UITableView()
//            tableView.backgroundColor = UIColor.white
//            tableView.translatesAutoresizingMaskIntoConstraints = false
//            return tableView
//        //}
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        tableView?.delegate = self
//        tableView?.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //conform to UITableViewDelegate ans UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 //vs 17?
    }
    //Create a tableViewCell to populate the screen
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellId")!
        return cell
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        do {
            usr = DataHolder.sharedInstance.firUser
            if usr != nil {
                print("User ",usr?.email," signing out!")    //TODO: why do I need to force-unwrap the value?
                try Auth.auth().signOut()
                //CDPersistenceService.deleteAllCodesRecords()
            }
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        //set the VC to it's root
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
