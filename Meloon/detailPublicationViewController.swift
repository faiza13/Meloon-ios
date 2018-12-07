//
//  detailPublicationViewController.swift
//  Meloon
//
//  Created by ESPRIT on 14/04/2018.
//  Copyright © 2018 Esprit. All rights reserved.
//

import UIKit
import Alamofire

class detailPublicationViewController: UIViewController {
    
    
    
   
  
    @IBOutlet weak var pin: UIBarButtonItem!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var imagePub: UIImageView!
    
    @IBOutlet weak var nameCreator: UILabel!
    
    @IBOutlet weak var descPub: UITextView!
    
    
    var publicationArray = [AnyObject]()
    
    
    var publications = [Publication]()
    
    
    var idPublication = ""
    
    let URL_GET_DATA = "http:/localhost/SimplifiediOS/v1/detailPublication.php"
    var pub = Publication()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("heeeeeere")
        print(idPublication)
        sendDetail ()
        
    }
    @IBOutlet weak var share: UIBarButtonItem!
    var activityViewController:UIActivityViewController?
    // textField .text = "Some Test"
    
    @IBAction func share(_ sender: Any) {
       
        let activityViewController = UIActivityViewController(
            activityItems: [ "Some Test" as NSString],
            applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func pin(_ sender: Any) {
        
        if publications[0] != nil {
            
            
            "http://localhost/SimplifiediOS/v1/"+self.publications[0].image!
            
            
            let myUrl =  "http:/localhost/SimplifiediOS/v1/PinImage.php"
           
            let imageData = UIImageJPEGRepresentation(imagePub.image!, 1)
            let base64String = imageData?.base64EncodedString(options: .lineLength64Characters)
            
            let param = [
                "img":base64String! ,
                "description": self.publications[0].description as! String,
                
                "idCreator" :  UserDefaults.standard.string(forKey: "userid")!
                ] as [String : Any]
            Alamofire.request(myUrl,method: .post, parameters: param).responseJSON
                {
                    response in print(response)
                    
                    if (response.result.isSuccess) {
                        /* if let JSON = response.result.value {
                         }*/
                        print("truuuuue")
                    }
            }
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendDetail (){
        let parameters = [
            "id":  self.idPublication
            
            ] as [String : Any]
        
        
        
        
        Alamofire.request(URL_GET_DATA, method: .post , parameters: parameters).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String,AnyObject> {
                if let innerDict = dict["publication"] {
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
                        
                        
                        
                    }
                    
                    self.descPub.text = self.publications[0].description
                    self.nameCreator.text = self.publications[0].nameCreator
                    
                    let strURL1:String = "http://localhost/SimplifiediOS/v1/"+self.publications[0].image!
                    let strURL2:String = "http://localhost/SimplifiediOS/v1/"+self.publications[0].imageCreator!
                    
                    Alamofire.request(strURL1).responseData(completionHandler: { response in
                        debugPrint(response)
                        
                        debugPrint(response.result)
                        
                        if let image1 = response.result.value {
                            let image = UIImage(data: image1)
                            self.imagePub.image = image
                            
                        }
                    })
                    Alamofire.request(strURL2).responseData(completionHandler: { response in
                        debugPrint(response)
                        
                        debugPrint(response.result)
                        
                        if let image1 = response.result.value {
                            let image = UIImage(data: image1)
                            self.image.image = image
                            
                        }
                    })
                    
                    
                }
                
                
                
                
                
            }
            
            
        }
        
        
        
    }
    
    
    
}


