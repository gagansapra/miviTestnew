//
//  ViewController.swift
//  miviTest
//
//  Created by user on 07/05/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class LoginControl: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.text = "nmnm@nm.mb"
        self.passwordTextField.text = "12121212"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    MARK:- Methods

    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func showAlertWithError(message : String) {
        let alertController:UIAlertController = UIAlertController.init(title: "Error", message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            alertController .dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
    }
    
//    MARK:- UITextFieldDelegate
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true;
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 8
    }
    
//    MARK:- Actions
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        if (!self.isValidEmail(testStr: self.emailTextField.text!)) {
          self.showAlertWithError(message: "Please enter your valid email address")
        } else if ((self.passwordTextField.text?.count)! < 8) {
            self.showAlertWithError(message: "Please enter your 8 character password")
        } else {
            self.performSegue(withIdentifier: "showDetail", sender: self)
        }
    }
    
    //    MARK:- Layout
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.loginButton.layer.cornerRadius = 4;
    }
}

