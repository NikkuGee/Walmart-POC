//
//  OrderViewController.swift
//  Walmart Test
//
//  Created by Consultant on 8/4/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {

    @IBOutlet weak var orderTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTable()
        setUpProducts()
    }
    
    func setUpProducts(){
        //For Testing
        viewModel.products = [Product(id: 1, name: "Apple", picture: "https://i1296.photobucket.com/albums/ag2/NIkkuge/apple_zpsmh0ut3ln.jpg?width=400&height=400&crop=1:1,smart", price: 1.00, count: 0),
                              Product(id: 2, name: "Banana", picture: "https://i1296.photobucket.com/albums/ag2/NIkkuge/banana_zpsubxwfxcz.jpg?width=400&height=400&crop=1:1,smart", price: 0.70, count: 0),
                              Product(id: 3, name: "Cherries", picture: "https://i1296.photobucket.com/albums/ag2/NIkkuge/cherries_zpsfoep8plc.jpg?width=400&height=400&crop=1:1,smart", price: 1.00, count: 0),
                              Product(id: 4, name: "Chocolate Ice Cream", picture: "https://i1296.photobucket.com/albums/ag2/NIkkuge/chocolate%20ice%20cream_zpsrtitomdd.jpg?width=400&height=400&crop=1:1,smart", price: 2.00, count: 0),
                              Product(id: 5, name: "Vanilla Ice Cream", picture: "https://i1296.photobucket.com/albums/ag2/NIkkuge/vanilla%20ice%20cream_zpsjglhywue.jpg?width=400&height=400&crop=1:1,smart", price: 2.00, count: 0),
                              Product(id: 6, name: "Metropolitan Ice Cream", picture: "https://i1296.photobucket.com/albums/ag2/NIkkuge/metropolitan_zpsfczgqnku.jpg?width=400&height=400&crop=1:1,smart", price: 2.30, count: 0),
                              Product(id: 7, name: "Strawberry Ice Cream", picture: "https://i1296.photobucket.com/albums/ag2/NIkkuge/strawberry%20ice%20cream_zpsrqzr1mik.jpg?width=400&height=400&crop=1:1,smart", price: 2.00, count: 0),
                              Product(id: 8, name: "Wheat Bread", picture: "https://i1296.photobucket.com/albums/ag2/NIkkuge/wheat%20bread_zps0ufobsqr.jpg?width=400&height=400&crop=1:1,smart", price: 1.00, count: 0),
                              Product(id: 9, name: "Whole Grain Bread", picture: "https://i1296.photobucket.com/albums/ag2/NIkkuge/whole%20grain_zpscogxeb51.jpg?width=400&height=400&crop=1:1,smart", price: 1.00, count: 0),
                              Product(id: 10, name: "White Bread", picture: "https://i1296.photobucket.com/albums/ag2/NIkkuge/white%20bread_zps3hsqxrsq.jpg?width=400&height=400&crop=1:1,smart", price: 1.00, count: 0)
        ]
    }
    
    func setUpTable(){
        orderTable.register(UINib(nibName: ProductTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: ProductTableViewCell.identifier)
        orderTable.tableFooterView = UIView(frame: .zero)

        NotificationCenter.default.addObserver(forName: Notification.Name("table"), object: nil, queue: .main) { [unowned self] _ in
            self.orderTable.reloadData()
            self.view.layoutIfNeeded()
        }
        
        
        viewModel.load()
        viewModel.syncProducts()
    }

}

extension OrderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
        cell.configure(with: viewModel.products[indexPath.row])
        return cell
    }
    
    
    
}

extension OrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        orderTable.deselectRow(at: indexPath, animated: true)
        
        let alert = UIAlertController(title: "Order Comfirmation", message: "Are you sure you want to order \(viewModel.products[indexPath.row].name)?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { action in
            print("You have ordered this product")
            viewModel.save(product: viewModel.products[indexPath.row])
            viewModel.load()
            viewModel.syncProducts()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
}
