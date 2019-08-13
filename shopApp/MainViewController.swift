//
//  MainViewController.swift
//  shopApp
//
//  Created by Artem Esolnyak on 06/08/2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    var notesArray:NSMutableArray?
    var plistPath:String?
    var currentSelectedBuyItem:String?
  
    let items = Item.getItems()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        plistPath = appDelegate.plistPathInDocument
        // Extract the content of the file as NSData
        let data:NSData =  FileManager.default.contents(atPath: plistPath!)! as NSData
        do{
            notesArray = try PropertyListSerialization.propertyList(from: data as Data, options: PropertyListSerialization.MutabilityOptions.mutableContainersAndLeaves, format: nil) as? NSMutableArray
        }catch{
            print("Error occured while reading from the plist file")
        }
        self.tableView.reloadData()
    }
 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray!.count
    }
    
    @IBAction func onBuyButtonTap(_ sender: UIButton) {
        currentSelectedBuyItem = sender.titleLabel?.text
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let productDict = notesArray?.object(at: indexPath.row) as! Dictionary<String,String>
        cell.buyButton?.setTitle(productDict["name"], for: .normal)
        return cell
    }

   

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller
        
        if segue.identifier == "buy_section"{
            let viewController:BuyViewController = segue.destination as! BuyViewController
            viewController.notesArray = notesArray
            viewController.id = currentSelectedBuyItem
        }
    }
    
    @IBAction func cancelAction(_ segue: UIStoryboardSegue ) {
        
    }
   

}
