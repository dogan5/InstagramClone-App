//
//  FeedViewController.swift
//  Doganresim
//
//  Created by Doğan seçilmiş on 26.05.2022.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    var documentArrayID = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirestore()
    }
    func getDataFromFirestore() {
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            
            if error != nil {
                print(error?.localizedDescription)
            }else{
                if snapshot?.isEmpty != true {
                    
                    self.userImageArray.removeAll(keepingCapacity: false)
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.documentArrayID.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        self.documentArrayID.append(documentID)
                        
                        if let postedBy = document.get("PostedBy") as? String{
                            self.userEmailArray.append(postedBy)
                        }
                        if let postComment = document.get("Postcomment") as? String{
                            self.userCommentArray.append(postComment)
                        }
                        if let likes = document.get("likes") as? Int{
                            self.likeArray.append(likes)
                        }
                        if let imageUrl = document.get("imageUrl") as? String{
                            self.userImageArray.append(imageUrl)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! FeedCell
        
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.resimView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.userMailLabel.text = userEmailArray[indexPath.row]
        cell.hiddenLabel.text = documentArrayID[indexPath.row]
        return cell
    }
  
    
}
