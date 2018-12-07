//
//  ProfileViewController.swift
//  XcodeLoginExample
//
//  Created by Belal Khan on 01/06/17.
//  Copyright © 2017 Belal Khan. All rights reserved.
//

import UIKit
import  AlamofireImage
import Alamofire

class ProfileViewController: UIViewController , UICollectionViewDelegate ,  UICollectionViewDataSource {
    
    var nameCreator  = ""
    let getProfilURL = "http:/localhost/SimplifiediOS/v1/getProfil.php"
    let URL_GET_DATA = "http:/localhost/SimplifiediOS/v1/showPublicationProfil.php"
    let URL_GET_PINNED = "http:/localhost/SimplifiediOS/v1/showPublicationProfilPinned.php"
      let followurl = "http:/localhost/SimplifiediOS/v1/follow.php"
      let unfollowurl = "http:/localhost/SimplifiediOS/v1/unfollowuser.php"
    let getEtatFollow = "http:/localhost/SimplifiediOS/v1/getEtatFollow.php"

    
    var publicationArray = [AnyObject]()
    
    
    var publications = [Publication]()

    var userArray = [AnyObject]()
    
    @IBOutlet weak var follow: UIButton!
    @IBAction func follow(_ sender: Any) {
       
            if(follow.titleLabel?.text=="UnFollow"){
                follow.backgroundColor = UIColor.blue
                follow.setTitleColor(UIColor.white, for: .normal)
                
                follow.setTitle("Follow", for: .normal)
               
              
       
            
            
            
                let parameters = [
                    "you": self.nameCreator  ,
                    
                    "me":  UserDefaults.standard.string(forKey: "userid")! ,
                    
                    ] as [String : Any]
                Alamofire.request(unfollowurl , method: .post, parameters: parameters).responseJSON { response in
                    switch response.result {
                    case .success:
                        let result = response.result
                        
                        let dict = result.value as? Dictionary<String,AnyObject>
                        let innerDict = dict!["success"]
                        print(innerDict)
                        
                    case .failure(let error):
                        print(error)
                    }
                    
                }
            
            
            
            }
        
        

    
                
            
            else{
                follow.backgroundColor = UIColor.darkGray
                follow.setTitleColor(UIColor.white, for: .normal)
                follow.setTitle("UnFollow", for: .normal)
                
                
                let parameters = [
                    "you": self.nameCreator  ,
                    
                    "me":  UserDefaults.standard.string(forKey: "userid")! ,
                    
                    ] as [String : Any]
                Alamofire.request(followurl , method: .post, parameters: parameters).responseJSON { response in
                    switch response.result {
                    case .success:
                        let result = response.result
                        
                        let dict = result.value as? Dictionary<String,AnyObject>
                        let innerDict = dict!["success"]
                        print(innerDict)
                        
                    case .failure(let error):
                        print(error)
                    }
                    
                }
            
            }
        
            
            
            
            
         
    }
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func segmentAction(_ sender: Any) {
        
        if segmentedControl.selectedSegmentIndex == 0
        {
            loadImages (URL_GET_DATA: URL_GET_DATA)

            
        }
        else if segmentedControl.selectedSegmentIndex == 1 {
            print("helooooooooooooooo ")

            loadImages (URL_GET_DATA: URL_GET_PINNED)

            
        }
        
    }
    @IBOutlet weak var collectionView: UICollectionView!
    var users = [User]()
    var user = User()

   
    //label again don't copy instead connect
    @IBOutlet weak var imageUser: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    
    @IBAction func toFollowing(_ sender: Any) {
     
        let followingViewController = self.storyboard?.instantiateViewController(withIdentifier: "Following") as! FollowingViewController
        followingViewController.idUser = user.id!

        self.navigationController?.pushViewController(followingViewController, animated: true)
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func logout(_ sender: Any) {
        print("logoutttttt")
        //removing values from default
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        
        //switching to login screen
        //let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        //elf.navigationController?.pushViewController(loginViewController, animated: true)
       /* let tabBarViewController = self.storyboard?.instantiateViewController(withIdentifier: "home") as! tabBarViewController
        performSegue(withIdentifier: "logout", sender: nil)
        
        tabBarViewController.dismiss(animated: false, completion: nil)
        */
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDel.window?.rootViewController = loginVC

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageUser.layer.cornerRadius = imageUser.frame.size.width / 2
        imageUser.clipsToBounds = true
       collectionView.delegate  = self
        collectionView.dataSource  = self
         var layout  = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
        layout.minimumLineSpacing = 2
       
        print("helooooooooooooooo ")
        print(nameCreator)
        loadProfil ()
        loadImages (URL_GET_DATA: URL_GET_DATA)
        
        
        self.collectionView.reloadData()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadImages (URL_GET_DATA : String) {
         self.publications.removeAll()
        let parameters = [
            "id":  self.nameCreator
            ] as [String : Any]
        Alamofire.request(URL_GET_DATA, method: .post , parameters: parameters).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String,AnyObject> {
                if let innerDict = dict["publications"] {
                    if innerDict.count != 0 {
                        print(innerDict)
                        self.publicationArray = innerDict as! [AnyObject]
                        for i in 0...innerDict.count-1 {
                            let id = self.publicationArray[i]["id"] as! String
                            let nameCreator = self.publicationArray[i]["username"] as! String
                            let image = self.publicationArray[i]["image"] as! String
                            let imageUser = self.publicationArray[i]["imageUser"] as! String
                            let description = self.publicationArray[i]["description"] as! String
                            
                            
                            let nbjaime = self.publicationArray[i]["nbjaime"] as! String
                            
                            
                            
                            self.publications.append(Publication( id: id , description: description, image: image, nameCreator: nameCreator , imageCreator : imageUser, nbjaime : nbjaime))
                            
                        }
                        
                        self.collectionView.reloadData()
                    } }
                
            }
            
            
            
        }
        self.collectionView.reloadData()

    }
    func loadProfil (){
        
        
        let defaultValues = UserDefaults.standard
        
        if  self.nameCreator == "" {
         
            self.nameCreator = defaultValues.string(forKey: "username")!
          
            let  email = defaultValues.string(forKey: "useremail")
                 let  userid = defaultValues.string(forKey: "userid")
              let  userphone = defaultValues.string(forKey: "userphone")
            let  imageUser = defaultValues.string(forKey: "imageUser")

           
            self.user  =  User(id: userid!, firstName: nameCreator, username: nameCreator, email: email!, phone: userphone!, imageUser: imageUser!, nbfollow: 0,  nbfollowed: 0)
            self.usernameLabel.text = nameCreator
            self.emailLabel.text = email
            let strURL1:String = "http://localhost/SimplifiediOS/v1/"+imageUser!

            Alamofire.request(strURL1).responseImage { response in
                debugPrint(response)
                
                if let image = response.result.value {
                    self.imageUser.image = image
                }
            }
            
            
            
            
        } else {
            if self.nameCreator == defaultValues.string(forKey: "username")! {
                follow.isHidden = true
                let  email = defaultValues.string(forKey: "useremail")
                let  userid = defaultValues.string(forKey: "userid")
                let  userphone = defaultValues.string(forKey: "userphone")
                let  imageUser = defaultValues.string(forKey: "imageUser")
                
                self.user  =  User(id: userid!, firstName: nameCreator, username: nameCreator, email: email!, phone: userphone!, imageUser: imageUser!, nbfollow: 0,  nbfollowed: 0)
                self.usernameLabel.text = nameCreator
                self.emailLabel.text = email
                let strURL1:String = "http://localhost/SimplifiediOS/v1/"+imageUser!

                Alamofire.request(strURL1).responseImage { response in
                    debugPrint(response)
                    
                    if let image = response.result.value {
                        self.imageUser.image = image
                    }
                }
                
            }
            else {
            loadEtatFollow()
            print(defaultValues.string(forKey: "username"))
            let parameters = [
                "username": self.nameCreator
                
                
                ] as [String : Any]
            Alamofire.request(getProfilURL, method: .post, parameters: parameters).responseJSON { response in
                switch response.result {
                case .success:
                    
                    let result = response.result
                    
                    let dict = result.value as? Dictionary<String,AnyObject>
                    let innerDict = dict!["user"]
                    if innerDict?.count != 0 {
                        self.userArray = innerDict as! [AnyObject]
                        
                        let idUser = self.userArray[(innerDict?.count)!-1]["idUser"] as! String
                        var username = self.userArray[(innerDict?.count)!-1]["username"] as! String
                        let email = self.userArray[(innerDict?.count)!-1]["email"] as! String
                        let phone = self.userArray[(innerDict?.count)!-1]["phone"] as! String
                        let imageUser = self.userArray[(innerDict?.count)!-1]["imageUser"] as! String
                        
                        
                        
                        
                        
                        
                        self.user  =  User(id: idUser, firstName: username, username: username, email: email, phone: phone, imageUser: imageUser, nbfollow: 0, nbfollowed: 0)
                        
                        
                        self.usernameLabel.text = self.user.username
                        self.emailLabel.text = self.user.email
                        
                        let strURL1:String = "http://localhost/SimplifiediOS/v1/"+self.user.imageUser!
                        
                        
                        Alamofire.request(strURL1).responseData(completionHandler: { response in
                            debugPrint(response)
                            
                            debugPrint(response.result)
                            
                            if let image1 = response.result.value {
                                let image = UIImage(data: image1)
                               self.imageUser.image = image
                                
                            }
                        })
                       
                        
                        
                    }
                    
                    print(innerDict!)
                case .failure(let error):
                    print(error)
                }
                
            }
            
        }
        
        }
    }

    
    
    func loadEtatFollow (){
        print(self.nameCreator )
        print(UserDefaults.standard.string(forKey: "userid")!)
        
         let parameters = [
                "username": self.nameCreator  ,
            
                
                "idCurrent":  UserDefaults.standard.string(forKey: "userid")! ,
                
                ] as [String : Any]
            Alamofire.request(getEtatFollow , method: .post, parameters: parameters).responseJSON { response in
                switch response.result {
                case .success:
                    let result = response.result
                    
                    let dict = result.value as? Dictionary<String,AnyObject>
                    var innerDict = dict!["test"] as! Int
                    print("test")
                    print(innerDict)
                    if innerDict == 1 {
                        self.follow.setTitleColor(UIColor.white , for: .normal)

                        self.follow.setTitle("UnFollow", for: .normal)

                        self.follow.backgroundColor = UIColor.darkGray
                        self.follow.isHidden = false
                        
                        
                    }
                    else{
                        self.follow.setTitleColor(UIColor.white , for: .normal)

                        self.follow.setTitle("Follow", for: .normal)

                        self.follow.backgroundColor = UIColor.blue
                        
                        self.follow.isHidden = false

                        
                        
                    }
                    
                case .failure(let error):
                    print(error)
                }
                
            }
            
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return publications.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        
        let publication = publications[indexPath.row]
        
       cell.descp.text =  publication.description
        let strURL1:String = "http://localhost/SimplifiediOS/v1/"+publication.image!
       
        
        Alamofire.request(strURL1).responseData(completionHandler: { response in
            debugPrint(response)
            
            debugPrint(response.result)
            
            if let image1 = response.result.value {
                let image = UIImage(data: image1)
                cell.image?.image = image
                
            }
        })
        
        return cell
        
    }
    
    
    
    
}
