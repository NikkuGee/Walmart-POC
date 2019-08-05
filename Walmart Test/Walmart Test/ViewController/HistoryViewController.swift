//
//  HistoryViewController.swift
//  Walmart Test
//
//  Created by Consultant on 8/4/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    @IBOutlet weak var historyTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpHistoryTable()
    }
    
    func setUpHistoryTable(){
        historyTable.register(UINib(nibName: ProductTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: ProductTableViewCell.identifier)
        historyTable.tableFooterView = UIView(frame: .zero)
        viewModel.load()
        NotificationCenter.default.addObserver(forName: Notification.Name("ordered"), object: nil, queue: .main) { [unowned self] _ in
            
            self.historyTable.reloadData()
            self.view.layoutIfNeeded()
        }
    }
    

}


extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.orderedProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTable.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
        cell.configure(with: viewModel.orderedProducts[indexPath.row])
        return cell
    }
    
    
    
}

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        historyTable.deselectRow(at: indexPath, animated: true)
        
        let alert = UIAlertController(title: "Order Comfirmation", message: "Are you sure you want to order \(viewModel.products[indexPath.row].name)?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { action in
            print("You have ordered this product")
            viewModel.save(product: viewModel.products[indexPath.row])
            viewModel.syncProducts()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
}

