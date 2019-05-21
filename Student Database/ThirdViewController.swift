//
//  ThirdViewController.swift
//  Student Database
//
//  Created by Vaclav Matousek on 15/05/2019.
//  Copyright © 2019 Vaclav Matousek. All rights reserved.
//

import UIKit
import Foundation
import IBMMobileFirstPlatformFoundation
import SwiftKeychainWrapper

class ThirdViewController: UIViewController {

    @IBOutlet weak var _username: UITextField!
    @IBOutlet weak var _finduserbutton: UIButton!
    @IBOutlet weak var _logoutbutton: UIButton!
    @IBOutlet weak var _userdataarea: UITextView!
    
    @IBAction func FindUser(_ sender: Any) {
        let retrievedToken: String = KeychainWrapper.standard.string(forKey: "token")!
        print("Retrieved token is: \(retrievedToken)")
        let sid:String = _username.text!
        
        if( sid == "") {
            return
        } else {
            print("username : \(sid)")
            let params = "[ '" + retrievedToken + "', '" + sid + "']"
            let request = WLResourceRequest(url: NSURL(string: "/adapters/httpAdapter/getUserByName") as URL?, method: WLHttpMethodGet);
        
            let formParams = ["params": params]
            request?.send(withFormParameters: formParams as [AnyHashable : Any]) { (response, error) -> Void in
                if(error != nil) {
                    NSLog(error.debugDescription)
                } else {
                    let result = response?.responseJSON[AnyHashable("API user")] as! Dictionary<String, String>
                    NSLog("result: " + String(describing: result))
                    DispatchQueue.main.async {
                        self._userdataarea.text = String()
                        self._userdataarea.text = String(describing: result)
                        self._userdataarea.scrollRangeToVisible(NSRange(location: 0, length: 0))
                    }
                }
            }
        }
    }
    
    @IBAction func Logout(_ sender: Any) {
        let removeSuccessfult: Bool = KeychainWrapper.standard.removeObject(forKey: "token")
        print("Token was successfuly removed: \(removeSuccessfult)")
        let removeSuccessfulu: Bool = KeychainWrapper.standard.removeObject(forKey: "user")
        print("User was successfuly removed: \(removeSuccessfulu)")
        let removeSuccessfulr: Bool = KeychainWrapper.standard.removeObject(forKey: "role")
        print("Role was successfuly removed: \(removeSuccessfulr)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _userdataarea.delegate = self as? UITextViewDelegate
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
