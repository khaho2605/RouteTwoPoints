//
//  ViewController.swift
//  RouteTwoPoints
//
//  Created by My Vo on 4/6/17.
//  Copyright © 2017 My Vo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Test branch
        showAlertGetLocation()
        
        emailTextField.delegate = self
        let email = UserDefaults.standard
        if(email.value(forKey: "email") != nil){
            emailTextField.text = email.value(forKey: "email") as? String
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Next(_ sender: Any) {
        let _email = emailTextField.text
        if _email == "" {
            self.displayAlertMessage(messageToDisplay: "Vui lòng nhập email!")
        }else if !isValidEmail(testStr: _email!) {
            self.displayAlertMessage(messageToDisplay: "Email không đúng, vui lòng kiểm tra lại!")
        } else {
            let email = UserDefaults.standard
            email.setValue(emailTextField.text, forKey: "email")
            email.synchronize()
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func displayAlertMessage(messageToDisplay: String) {
        let alertController = UIAlertController(title: "Thông báo", message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            print("Ok button tapped");
            
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
    
    func showAlertGetLocation()  {
        let flagShowAlert = UserDefaults.standard
        if(flagShowAlert.value(forKey: "flag") == nil ){
            
            let strTitle = "Ứng dụng muốn gửi dữ liệu lên server" as String
            let alert = UIAlertController(title:strTitle, message: " Để thực hiện quá trình gửi điểm đi và điểm đến, ứng dụng muốn gửi dữ liệu của bạn lên server!", preferredStyle: UIAlertControllerStyle.alert)
            
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Don't Allow", style: .destructive, handler:{(UIAlertAction) -> Void in
                self.nextButton.isEnabled = false
            }))
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(UIAlertAction) -> Void in
                flagShowAlert.setValue(0, forKey: "flag")
                flagShowAlert.synchronize()
            }))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
}
