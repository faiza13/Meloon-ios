//
//  FollowingViewController.swift
//  Meloon
//
//  Created by ESPRIT on 16/04/2018.
//  Copyright © 2018 Esprit. All rights reserved.
//

import UIKit
import Alamofire

class FollowingViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var followingTableView: UITableView!
    
    var usersArray = [AnyObject]()
    var idUser = ""
    let URL_GET_DATA = "http:/localhost/SimplifiediOS/v1/getAllFollowing.php"
    let deleteFollowingURL = "http:/localhost/SimplifiediOS/v1/unfollow.php"

    
    
    var users = [User]()
    
    //the method returning size of the list
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return users.count
    }
    
    
    //the method returning each cell of the list
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        
        let defaultValues = UserDefaults.standard
        
       
            
        
        if  self.idUser == defaultValues.string(forKey: "userid")! {
        
             //let cell = Bundle.main.loadNibNamed("followingTableViewCell", owner: self, options: nil)?.first as!followingTableViewCell
            //getting the hero for the specified position
            
             let cell = tableView.dequeueReusableCell(withIdentifier: "followcell", for: indexPath) as!FollowFinalTableViewCell
            let user: User
            user = users[indexPath.row]
            
            //displaying values
            cell.username.text = user.username
            cell.email.text = user.email
            cell.unfollow.isHidden = false
            cell.unfollow.isEnabled = true
            
            cell.unfollow.accessibilityHint = user.id
            cell.unfollow.addTarget(self, action: #selector(self.unfollowfunc(sender:)), for: .touchUpInside)
            
            
            let strURL1:String = "http://localhost/SimplifiediOS/v1/"+user.imageUser!
            
            
            //displaying image
            Alamofire.request(strURL1).responseImage { response in
                debugPrint(response)
                
                if let image = response.result.value {
                    cell.imageUser.image = image
                }
            }
            return cell

             }
        else {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "followcell", for: indexPath) as!FollowFinalTableViewCell
            
          
        let user: User
        user = users[indexPath.row]
        
        //displaying values
        cell.username.text = user.username
        cell.email.text = user.email
        
      
        
        
        
            let strURL1:String = "http://localhost/SimplifiediOS/v1/"+user.imageUser!

        
        //displaying image
        Alamofire.request(strURL1).responseImage { response in
            debugPrint(response)
            
            if let image = response.result.value {
                cell.imageUser.image = image
            }
        }
            return cell

        
    }
     
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let parameters = [
            "idUser": self.idUser
            
            
            ] as [String : Any]
        
        Alamofire.request(URL_GET_DATA, method: .post, parameters: parameters).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String,AnyObject> {
                if let innerDict = dict["following"] {
                    if innerDict.count != 0 {
                        print(innerDict)
                        self.usersArray = innerDict as! [AnyObject]
                        for i in 0...innerDict.count-1 {
                            let id = self.usersArray[i]["idUser"] as! String
                            let email = self.usersArray[i]["email"] as! String
                            let username = self.usersArray[i]["username"] as! String
                            let image = self.usersArray[i]["imageUser"] as! String
                         
                            
                            
                            
                            
                            
                            self.users.append(User(id: id, username: username, email: email, imageUser: image))
                            
                        }
                        
                        self.followingTableView.reloadData()
                    } }
                
            }
            
            
            
        }
      
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func unfollowfunc(sender: UIButton){
        let defaultValues = UserDefaults.standard

        let buttonTag = sender.tag
        let idFollowing = sender.accessibilityHint
        print("heeeere")
        print(idFollowing)
        print(defaultValues.string(forKey: "userid"))

       
        let parameters = [
            "idFollowing": idFollowing! ,
            "idCurrent": defaultValues.string(forKey: "userid")!
         
            
            ] as [String : Any]
        Alamofire.request(deleteFollowingURL, method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success:
                
            
                let result = response.result
                
                let dict = result.value as? Dictionary<String,AnyObject>
                print("tessssst")
                print(dict!["success"])
                let innerDict = dict!["success"] as! Int
                if innerDict == 1 {
                    
                    self.users.removeAll(keepingCapacity: true)
                    if let innerDict = dict!["following"] {
                        if innerDict.count != 0 {
                            print(innerDict)
                            self.usersArray = innerDict as! [AnyObject]
                            for i in 0...innerDict.count-1 {
                                let id = self.usersArray[i]["idUser"] as! String
                                let email = self.usersArray[i]["email"] as! String
                                let username = self.usersArray[i]["username"] as! String
                                let image = self.usersArray[i]["imageUser"] as! String
                                
                                
                                
                                
                                
                                self.users.append(User(id: id, username: username, email: email, imageUser: image))
                                
                            }
                            
                            self.followingTableView.reloadData()
                        }
                        self.followingTableView.reloadData()

                    }
                    
              
               

                }
                
              
            
            case .failure(let error):
                print("errrr")
                print(error)
            }
            
        }
        self.followingTableView.reloadData()

        
        
    }
    
   
    
}
