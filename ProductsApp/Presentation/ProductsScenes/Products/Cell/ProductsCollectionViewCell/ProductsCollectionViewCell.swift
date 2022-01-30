//
//  ProductsCollectionViewCell.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 28/01/2022.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell, CellBaseProtocol {

    static let reusableIdentifier = String(describing: ProductsCollectionViewCell.self)
    static let xibName = String(describing: ProductsCollectionViewCell.self)
    
    @IBOutlet private weak var img: UIImageView!
    @IBOutlet private weak var priceLbl: UILabel!
    @IBOutlet private weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    func configure(product: ProductEntity) {
        img.downloadImage(withUrl: product.image?.url ?? "")
        priceLbl.text = "\(product.price ?? 0)$"
        descriptionLbl.text = "\(product.productDescription ?? "")"
    }
}
