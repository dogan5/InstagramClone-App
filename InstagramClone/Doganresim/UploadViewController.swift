//
//  UploadViewController.swift
//  Doganresim
//
//  Created by Doğan seçilmiş on 26.05.2022.
//

import UIKit
import FirebaseStorage
import Firebase
import FirebaseFirestore
import FirebaseAuth



class UploadViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var textfield : UITextField!
    @IBOutlet weak var resim : UIImageView!
    @IBOutlet weak var yukle : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resim.isUserInteractionEnabled = true
        let dokunmatik = UITapGestureRecognizer(target: self , action: #selector(resimSec))
        resim.addGestureRecognizer(dokunmatik)
        
   
    }
    @objc func resimSec(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController,animated:true , completion: nil)
        
    }
    func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
        resim.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true,completion: nil)
    }
    func makeAlert(title:String,message:String){
        let Alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Error", style: UIAlertAction.Style.default, handler: nil)
        Alert.addAction(okButton)
        self.present(Alert, animated: true, completion: nil)
    }
    @IBAction func yukle2(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = resim.image?.jpegData(compressionQuality: 0.5){
                
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("/(uuid).jpg")
            imageReference.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                }else{
                    
                    imageReference.downloadURL { url, error in
                        if error == nil{
                            let imageUrl = url?.absoluteString
                            
                        let FirestoreDatabase = Firestore.firestore()
                        var FirestoreReference : DocumentReference? = nil
                            let firestorePost = ["imageUrl" : imageUrl!,"PostedBy" : Auth.auth().currentUser!.email!,"Postcomment" : self.textfield.text!,"date":FieldValue.serverTimestamp(),"likes" : 0 ] as [String : Any]
                        
                        FirestoreReference = FirestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                            if error != nil {
                                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                            }else{
                                self.resim.image = 	UIImage(named: "dokunbana")
                                self.textfield.text = ""
                                self.tabBarController?.selectedIndex = 0
                            }
                            
                        })
                                    
                            
                        
                            
                        
                    }
                }
            }
            
            
        }
        
        
        
    }


}
    }
    
