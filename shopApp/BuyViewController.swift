//
//  BuyViewController.swift
//  shopApp
//
//  Created by Kirill Koshaev on 07/08/2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import UIKit

class BuyViewController: UIViewController {

    var notesArray:NSMutableArray?
    var id:String?
    
   
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UITextView!
    @IBOutlet weak var costLbl: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for dict in notesArray!{
            let d = dict as! Dictionary<String,String>
            if d["name"] == id{
                titleLbl.text = d["name"]
                descriptionLbl.text = d["description"]
                costLbl.text = d["cost"]
            }
        }
 
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
