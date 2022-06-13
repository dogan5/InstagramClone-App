//
//  SettingsViewController.swift
//  Doganresim
//
//  Created by Doğan seçilmiş on 26.05.2022.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore


class SettingsViewController: UIViewController {
   
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
      
    }
    
    @IBAction func çıkış(_ sender: Any) {
        do {
            try  Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        } catch  {
            print("error")
        }
    }
    
}
         
                        
                    

    
