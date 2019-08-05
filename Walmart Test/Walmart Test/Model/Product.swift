//
//  Product.swift
//  Walmart Test
//
//  Created by Consultant on 8/4/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation


//Product class in relation to user
class Product {
    
    var id: Int
    var name: String
    //URL String for picture
    var picture: String
    var price: Double
    //User purchase count
    var countz: Int
    
    //MARK: Plain initializer
    init(id: Int, name: String, picture: String, price: Double, count: Int) {
        self.id = id
        self.name = name
        self.picture = picture
        self.price = price
        self.countz = count
        
    }
    
    //MARK: Initialize from Core Data
    init(from Core: Productz){
        self.id = Int(Core.id)
        self.name = Core.name!
        self.picture = Core.picture!
        self.price = Core.price
        self.countz = Int(Core.count)
    }
    
    
}
