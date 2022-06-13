//
//  ViewController.swift
//  Doganresim
//
//  Created by Doğan seçilmiş on 26.05.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore



class ViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func giriş(_ sender: Any) {
        if  emailText.text != "" && passwordText.text != ""{
            
            Auth.auth().signIn(withEmail:emailText.text!, password: passwordText.text!) { (data, hata) in
                if hata != nil{
                    self.makeAlert(titleInput: "ERROR", messageInput: hata?.localizedDescription ?? "Error")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else{
            makeAlert(titleInput: "ERROR", messageInput: "Username/Password?")
        }
        
     
        
    }
    @IBAction func kayıtol(_ sender: Any) {
        if  emailText.text != "" && passwordText.text != ""{
            
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { data, hata in
                
            if hata != nil {
                self.makeAlert(titleInput: "ERROR", messageInput: hata?.localizedDescription ?? "ERROR")
            }else{
                self.performSegue(withIdentifier: "toFeedVC", sender: nil)  
            }
                
            }
        }else{
            makeAlert(titleInput: "ERROR", messageInput: "Username/Password?")
        }
    }
    func makeAlert(titleInput:String,messageInput:String) {
        let Alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "ERROR", style: UIAlertAction.Style.default, handler: nil)
        Alert.addAction(okButton)
        self.present(Alert, animated: true, completion: nil)
    }
}

