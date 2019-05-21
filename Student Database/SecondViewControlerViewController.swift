//
//  SecondViewControlerViewController.swift
//  Student Database
//
//  Created by Vaclav Matousek on 15/05/2019.
//  Copyright © 2019 Vaclav Matousek. All rights reserved.
//

import UIKit
import Foundation
import IBMMobileFirstPlatformFoundation
import SwiftKeychainWrapper

class SecondViewControlerViewController: UIViewController {

    @IBOutlet weak var _StudentID: UITextField!
    @IBOutlet weak var _getallbutton: UIButton!
    @IBOutlet weak var _getbyidbutton: UIButton!
    @IBOutlet weak var _logout: UIButton!
    @IBOutlet weak var _dataarea: UITextView!
    
    @IBAction func Logout(_ sender: Any) {
        let removeSuccessfult: Bool = KeychainWrapper.standard.removeObject(forKey: "token")
        print("Token was successfuly removed: \(removeSuccessfult)")
        let removeSuccessfulu: Bool = KeychainWrapper.standard.removeObject(forKey: "user")
        print("User was successfuly removed: \(removeSuccessfulu)")
        let removeSuccessfulr: Bool = KeychainWrapper.standard.removeObject(forKey: "role")
        print("Role was successfuly removed: \(removeSuccessfulr)")
        
    }
    
    @IBAction func GetAllStudents(_ sender: Any) {
        let retrievedToken: String? = KeychainWrapper.standard.string(forKey: "token")
        print("Retrieved token is: \(retrievedToken!)")
        
        let request = WLResourceRequest(url: NSURL(string: "/adapters/httpAdapter/getAllStudents") as URL?, method: WLHttpMethodGet);
        let params = "[ '" + retrievedToken! + "']"
        let formParams = ["params": params]
        request?.send(withFormParameters: formParams as [AnyHashable : Any]) { (response, error) -> Void in
            if(error != nil) {
                NSLog(error.debugDescription)
            } else {
                var aos = Array<Dictionary<String, String>>()
                aos = response?.responseJSON[AnyHashable("students")] as! [Dictionary<String, String>]
                NSLog("result: " + String(describing: aos))
                DispatchQueue.main.async {
                    self._dataarea.text = String()
                    self._dataarea.insertText(String(describing: aos))
                }
            }
        }
    }
    
    @IBAction func GetStudentByID(_ sender: Any) {
        let sid = _StudentID.text
        
        if( sid == "") {
            return
        }
        
        DoGetStudentByID(_ID: sid!)
        
    }
    
    func DoGetStudentByID(_ID:String) {
        let retrievedToken: String = KeychainWrapper.standard.string(forKey: "token")!
        print("Retrieved token is: \(retrievedToken)")
        print("ID : \(_ID)")
        
        let params = "[ '" + retrievedToken + "', '" + _ID + "']"
        let request = WLResourceRequest(url: NSURL(string: "/adapters/httpAdapter/getStudentByID") as URL?, method: WLHttpMethodGet);
        
        let formParams = ["params": params]
        request?.send(withFormParameters: formParams as [AnyHashable : Any]) { (response, error) -> Void in
            if(error != nil) {
                NSLog(error.debugDescription)
            } else {
               
                
                let result = response?.responseJSON[AnyHashable("student")] as! Dictionary<String, String>
               
                NSLog("result: " + String(describing: result))
//                self._dataarea.text = result as String
                DispatchQueue.main.async {
                    self._dataarea.text = String()
                    self._dataarea.text = String(describing: result)
                    self._dataarea.scrollRangeToVisible(NSRange(location: 0, length: 0))
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _dataarea.delegate = self as? UITextViewDelegate

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
