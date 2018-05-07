//
//  UserDetailControl.swift
//  miviTest
//
//  Created by user on 07/05/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class UserDetailControl: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var emailSubscription: UILabel!
    @IBOutlet weak var contactNoLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var userDetail : NSDictionary = NSDictionary()
    var userDetailArray :[NSDictionary] = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.readJson(fileName: "Data") { (response) in
            print(response)
            let userDetail = response as! NSDictionary
            let accDetail:[String : Any]  = (userDetail["data"] as! [String :Any])["attributes"] as! [String : Any]
            let title : String = (accDetail["title"] != nil) ? accDetail["title"] as! String : ""
            let firstName : String = (accDetail["first-name"] != nil) ? accDetail["first-name"] as! String : ""
            let lastName : String = (accDetail["last-name"] != nil) ? accDetail["last-name"] as! String : ""
            self.nameLabel.text = title+" "+firstName+" "+lastName
            self.dobLabel.text = (accDetail["date-of-birth"] != nil) ? accDetail["date-of-birth"] as! String : ""
            self.contactNoLabel.text = (accDetail["contact-number"] != nil) ? accDetail["contact-number"] as! String : ""
            let emailString = (accDetail["email-address"] != nil) ? accDetail["email-address"] as! String : ""
            let verified:Bool = accDetail["email-address-verified"] as! Bool
            let verifiedString:String = (verified == true) ? "Verified" : "unverified"
            self.emailLabel.text = emailString + "(\(verifiedString))"
            let verifiedSub:Bool = accDetail["email-subscription-status"] as! Bool
            let subStatus:String = (verifiedSub == true) ? "Yes" : "No"
            self.emailSubscription.text = subStatus;
            
            for indexValue in userDetail["included"] as! [Any] {
                self.userDetailArray.append(indexValue as! NSDictionary)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func readJson(fileName : String,completion:@escaping(_  array : Any)->()) {
        do {
            if let file = Bundle.main.url(forResource: fileName, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    completion(object)
                } else if let object = json as? [Any] {
                    // json is an array
                    completion(object)
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK:- uitableView delegates & datasource
    
    
    func numberOfSections(in tableView: UITableView) -> Int  {
        return self.userDetailArray.count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let includeAr :[[String:Any]] = self.userDetail["included"] as! [[String:Any]]
        let subValue :[String : Any] = self.userDetailArray[section] as! [String : Any]
        let headerTitle = (subValue["type"] as! String)
        return headerTitle.capitalizingFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // let includeAr :[[String:Any]] = self.userDetail["included"] as! [[String:Any]]
        let subValue :[String : Any] = self.userDetailArray[section] as! [String : Any]
        let attributes :[String : Any] = subValue["attributes"] as! [String : Any]
        return attributes.count;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let accCell:ListCell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        let subValue :[String : Any] = self.userDetailArray[indexPath.section] as! [String : Any]
        let attributes :NSDictionary = subValue["attributes"] as! NSDictionary
        
        let leftValue:String = attributes.allKeys[indexPath.row] as! String
        let leftStringValue = leftValue.replacingOccurrences(of: "-", with: " ")
        accCell.leftLabel.text = leftStringValue.capitalizingFirstLetter()+":-"
        let rightValue = attributes.allValues[indexPath.row]
        if rightValue is NSNull {
            accCell.rightLabel.text = "-"
        } else  {
            if rightValue is Bool {
                let status:Bool = rightValue as! Bool
                accCell.rightLabel.text = (status == true) ? "Yes" : "No"
            } else {
                accCell.rightLabel.text = "\(rightValue)"
            }
        }
        return accCell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableViewAutomaticDimension
    }
    
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

