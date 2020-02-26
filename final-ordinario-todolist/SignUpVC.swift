//
//  SignUpVC.swift
//  final-ordinario-todolist
//
//  Created by Olivia Sartorius Freschet on 26/2/20.
//  Copyright © 2020 Olivia Sartorius Freschet. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpVC: UIViewController {

    @IBOutlet weak var newMail: UITextField!
    @IBOutlet weak var newPass: UITextField!
    @IBOutlet weak var repeatPass: UITextField!
    
    var usr:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToLogin(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func signup(_ sender: UIButton) {
        if (newPass.text != repeatPass.text) {
            let alertController = UIAlertController(title: "Password does not match", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            Auth.auth().createUser(withEmail: newMail.text!, password: newPass.text!) { (authDataResult, error) in
                if error == nil {
                    self.usr = DataHolder.sharedInstance.firUser
                    if self.usr != nil {
                        print("USER ",self.usr?.email," was created")
                        //alerts
                        let alertCont = UIAlertController(title: "You have created an account!", message: "You will be automatically signed in", preferredStyle: .alert)//vs .actionSheet (greyish)
                        let alertAct = UIAlertAction(title: "Neat, take me there pls", style: .cancel, handler:{action in self.backToLogin(sender)} )
                        alertCont.addAction(alertAct)
                        self.present(alertCont, animated: true)
                    }
                }
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
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
