//
//  Item.swift
//  shopApp
//
//  Created by Artem Esolnyak on 06/08/2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import Foundation

struct Item {
    let name : String
    let description: String
    let cost: String
    
    static let standartItems = ["KokaKoka-Cola", "M4A1", "Skyline", "Million things"]
    
    static func getItems() -> [Item] {
        var items = [Item]()
        for item in standartItems {
            items.append(Item(name: item, description: "someWords", cost: "34$"))
        }
        return items
    }
    
}
