//
//  ProductTableViewCell.swift
//  Walmart Test
//
//  Created by Consultant on 8/4/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var orderCount: UILabel!
    
    static let identifier = "ProductTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(with product: Product){
        self.name.text = product.name
        self.price.text = "$\(String(format: "%.2f", product.price))"
        if product.countz > 0 {
            self.orderCount.text = "You've ordered this product: \(product.countz) times."
        } else {
            self.orderCount.text = ""
        }
        //Make Cache Image
        cacheManager.downloadImage(from: product.picture) { [unowned self] dat in
            if let data = dat, let image = UIImage(data: data) {
                self.productImage.image = image
            }
        }
        
    }

}
