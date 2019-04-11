//
//  VC_Authentification.swift
//  bk_s4_35_todo_v2
//
//  Created by Benedikt Kurz on 09.04.19.
//  Copyright © 2019 Benedikt Kurz. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit
import FBSDKCoreKit

class VC_Authentification: UIViewController, FBSDKLoginButtonDelegate {
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
       // self.performSegue(withIdentifier: "segue", sender: self)
        print("completed login")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("ausgelogt")
    }
    
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        
        self.performSegue(withIdentifier: "segue", sender: self)
        return true
    }

    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var handle: AuthStateDidChangeListenerHandle?
  
    let btnFbLogin: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
      //  button.delegate = self
        return button
    }()
    
    @IBOutlet weak var btnFacebookLogin: UIButton!
    
    
    @IBAction func btnSignOn(_ sender: UIButton) {
    
        if (txtUser.text != nil && txtPassword.text != nil) {
        
            Auth.auth().signIn(withEmail: txtUser.text!, password: txtPassword.text!) { (user, error) in
                if user != nil {
                    
                    self.performSegue(withIdentifier: "segue", sender: self)
                    print("eingeloggt")
                } else {
                    print(error)
                }
            }
            
        }
    }
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(btnFbLogin)
        btnFbLogin.center = view.center
        btnFbLogin.delegate = self
        
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        super.viewWillAppear(animated)
        // [START auth_listener]
        handle = Auth.auth().addStateDidChangeListener {
            (auth, user) in
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
