//
//  FeedCell.swift
//  Doganresim
//
//  Created by Doğan seçilmiş on 30.05.2022.
//

import UIKit
import Firebase
import FirebaseFirestore

class FeedCell: UITableViewCell {

    @IBOutlet weak var hiddenLabel: UILabel!
    @IBOutlet weak var userMailLabel: UILabel!
    @IBOutlet weak var resimView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func likeButton(_ sender: Any) {
        let FirestoreDatabase = Firestore.firestore()
        if let likeCount = Int(likeLabel.text!){
            
            let likeStore = ["likes" : likeCount + 1] as [String : Any]
            FirestoreDatabase.collection("Posts").document(hiddenLabel.text!).setData(likeStore, merge: true)
            

        }
        
        
    }
    
}
