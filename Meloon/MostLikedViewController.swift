//
//  ViewController.swift
//  CustomTableView
//
//  Created by Belal Khan on 30/07/17.
//  Copyright © 2017 Belal Khan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage


//adding class DataSource and Delegate for our TableView
class MostLikedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var publicationsTableView: UITableView!
    
    var test = 0 ;
    struct jaime {
        var idvideo: Int
        var nbjaime: Int
        
    }
    var tabidjaime = [Int]()
    var tabnbjaime = [jaime]()
    //the Web API URL
    let URL_GET_DATA = "http:/localhost/SimplifiediOS/v1/showMostLikedPublication.php"
    let likeURL = "http:/localhost/SimplifiediOS/v1/likePublication.php"
    let unlikeURL = "http:/localhost/SimplifiediOS/v1/unlikePublication.php"
    
    
    
    

    
  
    
    //a list to store heroes
    var publicationArray = [AnyObject]()
    
    
    var publications = [Publication]()
    
    //the method returning size of the list
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return publications.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // performSegue(withIdentifier: "toDetailsPublication", sender: nil)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print(tapGestureRecognizer.view!.tag)
        let buttonTag = tapGestureRecognizer.view!.tag
        let nameCreator = tapGestureRecognizer.view!.accessibilityHint
        let ProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "profil") as! ProfileViewController
        ProfileViewController.nameCreator = nameCreator!
        self.navigationController?.pushViewController(ProfileViewController, animated: true)
        
        self.dismiss(animated: false, completion: nil)
        
        
    }
    
    
    //the method returning each cell of the list
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "likedCell", for: indexPath) as! MostLikedTableViewCell
        
        //getting the hero for the specified position
        let publication: Publication
        publication = publications[indexPath.row]
        //displaying image
        
        
        
        //  cell.imageCreator.image = publication.imageCreator
        
        //  var url:NSURL? = NSURL(string: publication.image!)
        //  var data:NSData? = NSData(contentsOf : url! as URL)
        //  var urlcreator:NSURL? = NSURL(string: publication.imageCreator!)
        //  var datacreator:NSData? = NSData(contentsOf : urlcreator! as URL)
        // cell.imagePublication?.image = UIImage(data : data! as Data)
        //cell.imageCreator?.image = UIImage(data : datacreator! as Data)
        let strURL1:String = "http://localhost/SimplifiediOS/v1/"+publication.image!
        let strURL2:String = "http://localhost/SimplifiediOS/v1/"+publication.imageCreator!
        
        Alamofire.request(strURL2).responseData(completionHandler: { response in
            debugPrint(response)
            
            debugPrint(response.result)
            
            if let image1 = response.result.value {
                let image = UIImage(data: image1)
                cell.imageCreator?.image = image
                
            }
        })
        Alamofire.request(strURL1).responseData(completionHandler: { response in
            debugPrint(response)
            
            debugPrint(response.result)
            
            if let image1 = response.result.value {
                let image = UIImage(data: image1)
                cell.imagePublication?.image = image
                
            }
        })
        cell.descriptionPublication?.text = publication.description
        cell.nameCreator?.text = publication.nameCreator
        let idPublication = publicationArray[indexPath.row]["id"] as! String
        let nameCreator = publicationArray[indexPath.row]["username"] as! String
        let nbjaime = publicationArray[indexPath.row]["nbjaime"] as! String
        
        cell.nblikeButton.text = nbjaime
        cell.commentButton.accessibilityHint = String(idPublication)
        cell.commentButton.addTarget(self, action: #selector(self.commentfunc(sender:)), for: .touchUpInside)
        
       
        cell.likeButton.tag = indexPath.row
        cell.likeButton.accessibilityHint = String(idPublication)
        cell.likeButton.addTarget(self, action: #selector(self.connected(sender:)), for: .touchUpInside)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(tapGestureRecognizer:)))
        cell.imageCreator.isUserInteractionEnabled = true
        cell.imageCreator.tag = indexPath.row
        cell.imageCreator.accessibilityHint = String(nameCreator)
        cell.imageCreator.addGestureRecognizer(tapGestureRecognizer)
        
        
        
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetching data from web api
        
        Alamofire.request(URL_GET_DATA, method: .get).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String,AnyObject> {
                if let innerDict = dict["publications"] {
                    if innerDict.count != 0 {
                        print(innerDict)
                        self.publicationArray = innerDict as! [AnyObject]
                        for i in 0...innerDict.count-1 {
                            let id = self.publicationArray[i]["id"] as! String
                            let description = self.publicationArray[i]["description"] as! String
                            let nameCreator = self.publicationArray[i]["username"] as! String
                            let image = self.publicationArray[i]["image"] as! String
                            let imageUser = self.publicationArray[i]["imageUser"] as! String
                            let nbjaime = self.publicationArray[i]["nbjaime"] as! String
                            
                            
                            
                            
                            
                            self.publications.append(Publication( id: id , description: description, image: image, nameCreator: nameCreator , imageCreator : imageUser, nbjaime: nbjaime))
                            
                        }
                        
                        self.publicationsTableView.reloadData()
                    } }
                
            }
            
            
            
        }
        
        
        self.publicationsTableView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func commentfunc(sender: UIButton){
        test = 1 ;
        let buttonTag = sender.tag
        let idvideostr = sender.accessibilityHint
        UserDefaults.standard.set(idvideostr, forKey: "idPublication") //setObject
        performSegue(withIdentifier: "likedToComment", sender: nil)
        
        
    }
    @objc func profilfunc(sender: UIButton){
        
        let buttonTag = sender.tag
        let nameCreator = sender.accessibilityHint
        let ProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "profil") as! ProfileViewController
        ProfileViewController.nameCreator = nameCreator!
        self.navigationController?.pushViewController(ProfileViewController, animated: true)
        
        self.dismiss(animated: false, completion: nil)
        
        
        
    }
    
    @objc func connected(sender: UIButton){
        test = 1 ;
        
        
        let buttonTag = sender.tag
        let idPublication = sender.accessibilityHint
        
        let indexPath = NSIndexPath(row: sender.tag, section: 0)
        
        let cell =    publicationsTableView.cellForRow(at: indexPath as IndexPath) as! MostLikedTableViewCell
        let publication: Publication
        publication = publications[indexPath.row]
        
        
        var g : NSIndexPath = NSIndexPath(row: buttonTag, section: 0)
        var t : MostLikedTableViewCell = self.publicationsTableView.cellForRow(at: g as IndexPath) as!  MostLikedTableViewCell
        //loadlist()
        
        if t.likeButton.currentImage == UIImage(named: "like-1"){
            t.likeButton.setImage(UIImage(named: "like-2"), for: UIControlState.normal)
            let v = t.nblikeButton.text
            var nbl = Int(v!)!
            nbl = nbl + 1
            
            t.nblikeButton.text = String(nbl)
            
            let parameters = [
                "id":  Int(idPublication!)  ,
                
                "userid":  UserDefaults.standard.string(forKey: "userid")! ,
                "nbjaime": nbl
                
                ] as [String : Any]
            Alamofire.request(likeURL, method: .post, parameters: parameters).responseJSON { response in
                switch response.result {
                case .success:
                    let result = response.result
                    
                    let dict = result.value as? Dictionary<String,AnyObject>
                    let innerDict = dict!["success"]
                    print(innerDict)
                    
                    
                    
                    
                    
                    
                    
                    self.test = 1
                    
                case .failure(let error):
                    print(error)
                }
                
            }
            
            
            
        }else {
            t.likeButton.setImage(UIImage(named: "like-1"), for: UIControlState.normal)
            let v = t.nblikeButton.text
            var nbl = Int(v!)
            nbl = nbl! - 1
            t.nblikeButton.text = String(nbl!)
            
            let parameters = [
                "id":  Int(idPublication!)  ,
                
                "userid":  UserDefaults.standard.string(forKey: "userid")! ,
                "nbjaime": nbl
                
                ] as [String : Any]
            Alamofire.request(unlikeURL, method: .post, parameters: parameters).responseJSON { response in
                switch response.result {
                case .success:
                    let result = response.result
                    
                    let dict = result.value as? Dictionary<String,AnyObject>
                    let innerDict = dict!["success"]
                    print(innerDict)
                    
                    
                    
                    
                    
                    
                    
                    self.test = 1
                    
                case .failure(let error):
                    print(error)
                }
                
            }
        }
        
        
    }
    
    
    
    
    
}




