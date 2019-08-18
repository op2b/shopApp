//
//  NewItemTableViewController.swift
//  shopApp
//
//  Created by Artem Esolnyak on 06/08/2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import UIKit

class NewItemTableViewController: UITableViewController {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var costLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
     descriptionView.isEditable = true
        
    }
    
  
    
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       view.endEditing(true)
    }
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        
        // Save note to plist
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let pathForThePlistFile = appDelegate.plistPathInDocument
        
        // Extract the content of the file as NSData
        let data:NSData =  FileManager.default.contents(atPath: pathForThePlistFile)! as NSData
        // Convert the NSData to mutable array
        do{
            let notesArray = try PropertyListSerialization.propertyList(from: data as Data, options: PropertyListSerialization.MutabilityOptions.mutableContainersAndLeaves, format: nil) as! NSMutableArray
            notesArray.add(["name":nameLabel.text, "description": descriptionView.text, "cost":costLabel.text])
            
            
            // Save to plist
            notesArray.write(toFile: pathForThePlistFile, atomically: true)
            
        }catch{
            print("An error occurred while writing to plist")
        }
        // Dismiss the modal controller
        appDelegate.serializeDataToJSON()
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension NewItemTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension NewItemTableViewController: UITextViewDelegate{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            textView.resignFirstResponder()
            return true
        }
        return false
    }
}
