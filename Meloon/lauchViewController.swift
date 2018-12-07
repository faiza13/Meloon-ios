//
//  lauchViewController.swift
//  Meloon
//
//  Created by ESPRIT on 07/04/2018.
//  Copyright © 2018 Esprit. All rights reserved.
//

import UIKit

class lauchViewController: UITabBarController {
    let defaultValues = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if defaultValues.string(forKey: "username") != nil{
            let tabBarViewController = self.storyboard?.instantiateViewController(withIdentifier: "home") as! tabBarViewController
            self.navigationController?.pushViewController(tabBarViewController, animated: true)
            self.dismiss(animated: false, completion: nil)
            
            
        }
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
