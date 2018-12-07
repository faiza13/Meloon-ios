//
//  CommentViewController.swift
//  Meloon
//
//  Created by ESPRIT on 14/04/2018.
//  Copyright © 2018 Esprit. All rights reserved.
//

import UIKit
import Alamofire

class CommentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var commentTableView: UITableView!
    
    @IBOutlet weak var contents: UITextField!
    
    @IBOutlet weak var currentUserImage: UIImageView!
    @IBAction func sendButton(_ sender: Any) {
            sendcomment ()
    }
    //a list to store heroes
    var commentArray = [AnyObject]()
    
    
    var comments = [Comment]()
    let getAllComment = "http:/localhost/SimplifiediOS/v1/getAllComment.php"
    let commentvideoURL = "http:/localhost/SimplifiediOS/v1/commentPublication.php"

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return comments.count
    }
    
    
    //the method returning each cell of the list
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as!CommentTableViewCell
        
        //getting the hero for the specified position
        let comment: Comment
        comment = comments[indexPath.row]
        
        //displaying values
        cell.username.text = comment.username
        cell.textComment.text = comment.contents
           let strURL1:String = "http://localhost/SimplifiediOS/v1/"+comment.imageUser!
        Alamofire.request(strURL1).responseImage { response in
            debugPrint(response)
            
            if let image = response.result.value {
                cell.imageUser.image = image
            }
        }
       
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
        }
        
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
        }
        
        
        //displaying image
       
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaultValues = UserDefaults.standard

        print("commeeeeent")
        print(UserDefaults.standard.string(forKey: "idPublication"))
        
        currentUserImage.layer.cornerRadius = 8.0
        currentUserImage.clipsToBounds = true
        
        
        let  imageUser = defaultValues.string(forKey: "imageUser")
        
        
        let strURL1:String = "http://localhost/SimplifiediOS/v1/"+imageUser!
        
        Alamofire.request(strURL1).responseImage { response in
            debugPrint(response)
            
            if let image = response.result.value {
                self.currentUserImage.image = image
            }
        }
        
        let parameters = [
            "id":  UserDefaults.standard.string(forKey: "idPublication")!
            
        ]
        Alamofire.request(getAllComment, method: .post, parameters: parameters).responseJSON { response in
            
            
            let result = response.result
          
        print(result)
            if let dict = result.value as? Dictionary<String,AnyObject> {
               
                if let innerDict = dict["comments"] {
                    if innerDict.count != 0 {
                    self.commentArray = innerDict as! [AnyObject]
                    for i in 0...innerDict.count-1 {
                        let id = self.commentArray[i]["id"] as! String
                        let content = self.commentArray[i]["content"] as! String
                        let publication_id = self.commentArray[i]["publication_id"] as! String
                        let idUser = self.commentArray[i]["idUser"] as! String
                        let username = self.commentArray[i]["username"] as! String
                        let email = self.commentArray[i]["email"] as! String
                        let imageUser = self.commentArray[i]["imageUser"] as! String

                        
                        
                        
                        
                        self.comments.append(Comment( id: id, contents: content, idUser: idUser, username: username, email: email, imageUser: imageUser   ))
                        
                    }
                    
                    self.commentTableView.reloadData()
                }
                
            }
            
            
            
        }
        
        
        self.commentTableView.reloadData()
        // Do any additional setup after loading the view, typically from a nib
            
            
            
        
            
        }
      
        
        
        
      
    }
    func sendcomment (){
        let parameters = [
            "id":  UserDefaults.standard.string(forKey: "idPublication")!,
            "contents": contents.text!,
            "userid":  UserDefaults.standard.string(forKey: "userid")!
            
            ] as [String : Any]
        Alamofire.request(commentvideoURL, method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
                
                self.contents.text = ""
                let result = response.result
                
                let dict = result.value as? Dictionary<String,AnyObject>
                let innerDict = dict!["comments"]
                if innerDict?.count != 0 {
                    self.commentArray = innerDict as! [AnyObject]
                    
                        let id = self.commentArray[(innerDict?.count)!-1]["id"] as! String
                        let content = self.commentArray[(innerDict?.count)!-1]["content"] as! String
                        let publication_id = self.commentArray[(innerDict?.count)!-1]["publication_id"] as! String
                        let idUser = self.commentArray[(innerDict?.count)!-1]["idUser"] as! String
                        let username = self.commentArray[(innerDict?.count)!-1]["username"] as! String
                        let email = self.commentArray[(innerDict?.count)!-1]["email"] as! String
                        let imageUser = self.commentArray[(innerDict?.count)!-1]["imageUser"] as! String
                        self.comments.append(Comment( id: id, contents: content, idUser: idUser, username: username, email: email, imageUser: imageUser   ))
                    
                    self.commentTableView.reloadData()
                }
                
                print(innerDict!)
                
               // self.commentArray = innerDict! as! [AnyObject]
                self.commentTableView.reloadData()
                
                
                
                
                
                // let res = response.result.value as! NSDictionary
                //et nblike = res.object(forKey: "nblike") as! Int
                // cell.nblike.setTitle(String(nblike), for: UIControlState.normal)
                //self.tableview.reloadData();
                
                //example if there is an id
                //let error = res.object(forKey: "error") as! Bool
                //print(error)
                
            case .failure(let error):
                print(error)
            }
            
        }
        self.commentTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
