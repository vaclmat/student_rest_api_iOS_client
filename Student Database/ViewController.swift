//
//  ViewController.swift
//  Student Database
//
//  Created by Vaclav Matousek on 13/05/2019.
//  Copyright © 2019 Vaclav Matousek. All rights reserved.
//

import UIKit
import Foundation
import IBMMobileFirstPlatformFoundation
import SwiftKeychainWrapper
import JWTDecode


class ViewController: UIViewController {
    
    @IBOutlet weak var _username: UITextField!
    @IBOutlet weak var _password: UITextField!
    @IBOutlet weak var _loginbutton: UIButton!
    
    
    @IBAction func LoginButton(_ sender: Any) {
        let username = _username.text
        let password = _password.text
        
        if ( username == "" || password == "" ) {
            return
        }
        
        DoLogin(_user: username!, _pwd: password!)
        
    }
    
    func DoLogin(_user:String, _pwd:String) {
        let request = WLResourceRequest(url: NSURL(string: "/adapters/httpAdapter/login") as URL?, method: WLHttpMethodPost);
        let id = "[ '" + _user + "', '" + _pwd + "']"
        let formParams = ["params": id]
        request?.send(withFormParameters: formParams) { (response, error) -> Void in
            if(error != nil) {
                NSLog(error.debugDescription)
            } else {
                let token:String = response?.responseJSON[AnyHashable("token")] as! String
                NSLog("token: " + String(describing: token))
                let saveSuccessfult: Bool = KeychainWrapper.standard.set(token, forKey: "token")
                print("Save of the token was successful: \(saveSuccessfult)")
                let saveSuccessfulu: Bool = KeychainWrapper.standard.set(_user, forKey: "user")
                print("Save of the user was successful: \(saveSuccessfulu)")
                do {
                    let decoded = try decode(jwt: token)
                    let drole:String = decoded.body["role"] as! String
                    NSLog("User role: " + String(describing: drole))
                    let saveSuccessfulr: Bool = KeychainWrapper.standard.set(drole, forKey: "role")
                    print("Save of the role was successful: \(saveSuccessfulr)")
                } catch {
                    print("Failed to decode")
                }
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}


