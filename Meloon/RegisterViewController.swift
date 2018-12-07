//
//  RegisterViewController.swift
//  Meloon
//
//  Created by ESPRIT on 03/04/2018.
//  Copyright © 2018 Esprit. All rights reserved.
//

import Alamofire
import UIKit
import SwiftyJSON

class RegisterViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextFieldDelegate  {
    var imagePickerController = UIImagePickerController()
    var selectedImage : UIImage!


    @IBAction func login(_ sender: Any) {
          dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var imageUser: UIImageView!
    
    @IBOutlet weak var pickbutton: UIButton!
    @IBAction func pickAction(_ sender: Any) {
        self.present(imagePickerController, animated: true, completion: nil)
        
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePickerController, animated: true, completion: nil)
    }
    let URL_USER_REGISTER = "http:/localhost/SimplifiediOS/v1/register.php"

    @IBAction func signUp(_ sender: Any) {
        //creating parameters for the post request
        if imageUser.image != nil {
        let imageData = UIImageJPEGRepresentation(imageUser.image!, 1)
        let base64String = imageData?.base64EncodedString(options: .lineLength64Characters)
        let parameters: Parameters=[
            "username":usernameTextField.text!,
            "password":passwordTextField.text!,
            "name":nameTextField.text!,
            "email":emailTextField.text!,
            "phone":phoneTextField.text!,
            "img":base64String!

            
        ]
        
        //Sending http post request
        Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON
            {
                
                response in
                switch(response.result) {
                case .success(_):
                    if let result = response.result.value{
                    
                    //converting it as NSDictionary
                    let jsonData = JSON(result)
                   let message = jsonData["message"].stringValue
                        let alert = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
                        
                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        
                        alert.addAction(alertAction)
                        
                        self.present(alert, animated: true, completion: nil)
                    		
                }
                case .failure(_):
                    print("Error message:")
                    break
        }
        
       
        
            }}}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         usernameTextField.delegate = self
        passwordTextField.delegate = self
        nameTextField.delegate = self
         emailTextField.delegate = self
        phoneTextField.delegate = self
          imagePickerController.delegate = self
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField{
            passwordTextField.becomeFirstResponder()
        } else if textField == emailTextField{
            nameTextField.becomeFirstResponder()
        } else if textField == phoneTextField{
            textField.resignFirstResponder()
        }
        return true
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        self.selectedImage = selectedImage
        self.imageUser.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
