//
//  UploadViewController.swift
//  Meloon
//
//  Created by ESPRIT on 23/04/2018.
//  Copyright © 2018 Esprit. All rights reserved.
//

import UIKit
import Alamofire

class UploadViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate ,UITextViewDelegate		 {
 var imagePickerController = UIImagePickerController()
    @IBOutlet weak var imageView: UIImageView!
    var selectedImage : UIImage!
    let defaultValues = UserDefaults.standard

    @IBOutlet weak var descriptionText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionText.delegate = self
        descriptionText.text = "Placeholder"
        descriptionText.textColor = UIColor.lightGray
      
        descriptionText.becomeFirstResponder()
        
        descriptionText.selectedTextRange = descriptionText.textRange(from: descriptionText.beginningOfDocument, to: descriptionText.beginningOfDocument)
        imagePickerController.delegate = self
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            textView.text = "Describe it ..."
            textView.textColor = UIColor.lightGray
            
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            
            return false
        }
            
            // Else if the text view's placeholder is showing and the
            // length of the replacement string is greater than 0, clear
            // the text view and set its color to black to prepare for
            // the user's entry
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    @IBAction func pickImage(_ sender: Any) {
       
    }
    
    @IBAction func pick(_ sender: Any) {
        self.present(imagePickerController, animated: true, completion: nil)
        
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePickerController, animated: true, completion: nil)
    }
    @IBAction func upload(_ sender: Any) {
        let myUrl =  "http:/localhost/SimplifiediOS/v1/upload.php"
        let imageData = UIImageJPEGRepresentation(imageView.image!, 1)
        let base64String = imageData?.base64EncodedString(options: .lineLength64Characters)
        let param = [
            "img":base64String! ,
            "description": descriptionText.text ,
           
            "idCreator" :  UserDefaults.standard.string(forKey: "userid")!
            ] as [String : Any]
        if  base64String! != nil {
        Alamofire.request(myUrl,method: .post, parameters: param).responseJSON
            {
                response in print(response)
                
                if (response.result.isSuccess) {
                    /* if let JSON = response.result.value {
                     }*/
                print("truuuuue")
                    
                    
                    self.defaultValues.set(1, forKey: "fromupload")

                    
                 
                self.tabBarController?.selectedIndex = 0
               
                }
        }}
    
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        self.selectedImage = selectedImage
        self.imageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
   
    
    
    
    
    
}
