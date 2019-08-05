//
//  ViewModel.swift
//  Walmart Test
//
//  Created by Consultant on 8/4/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation


let viewModel = ViewModel.shared
final class ViewModel {
    
    static let shared = ViewModel()
    private init() {}
    
    var products = [Product](){
        didSet {
            NotificationCenter.default.post(name: Notification.Name("table"), object: nil)
        }
    }
    var orderedProducts = [Product](){
        didSet {
            NotificationCenter.default.post(name: Notification.Name("ordered"), object: nil)
        }
    }
    
    
    func save(product: Product) {
        ProductManager.shared.saveOrder(product)
    }
    
    func load(){
        orderedProducts = ProductManager.shared.load()
    }
    
    //MARK: Align product counts with order history
    func syncProducts() {
        for prod in orderedProducts {
            if let found = products.firstIndex(where: {$0.id == prod.id}) {
                print(products[found].name)
                products[found].countz = prod.countz
            }
            
        }
        NotificationCenter.default.post(name: Notification.Name("table"), object: nil)

    }
    
}
