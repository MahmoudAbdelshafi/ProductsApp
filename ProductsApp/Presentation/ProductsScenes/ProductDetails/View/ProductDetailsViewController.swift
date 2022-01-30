//
//  ProductDetailsViewController.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 29/01/2022.
//

import UIKit

final class ProductDetailsViewController: UIViewController {
    
    //MARK: - Properties
    
    /// View Model Instance of the ProductDetailsViewModel Protocol
    private var viewModel: ProductDetailsViewModel!
    
    //MARK: - IBOutlets
    
    ///  UIImageView To display the product Image
    @IBOutlet private weak var productImg: UIImageView!
    ///  UIImageView To display the product description text
    @IBOutlet private weak var descriptionLbl: UILabel!
    
    
    //MARK: - Create
    
    /// Function to init and load xib ViewController file of the ProductDetailsViewController with the required dependencies
    /// - Parameter viewModel: The view Model abstraction dependency type
    /// - Returns: ProductDetailsViewController intialized and injected with required dependencies
    static func create(with viewModel: ProductDetailsViewModel) -> ProductDetailsViewController {
        let vc = ProductDetailsViewController.loadFromNib()
        vc.viewModel = viewModel
        return vc
    }
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(to: viewModel)
    }
    
    //MARK: - IBAtions
    
    /// Dismiss UIButton Action To Dismiss the ViewController
    /// - Parameter sender: Refares to the sender of the action
    @IBAction func dismissBtnPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    //MARK: - Private Functions
    
    /// Function to bind the ProductDetailsViewModelOutput observable data types
    /// - Parameter viewModel: ProductDetailsViewModelOutput
    private func bind(to viewModel: ProductDetailsViewModelOutput) {
        viewModel.productDetails.observe(on: self) { [weak self] in self?.updateView($0!) }
    }
    
    /// Fuction to perform updates on observed changes of ProductDetailsViewModelOutput data values changes
    /// - Parameter dataModel: ProductDetailsDataViewModel is a structure for ProductDetailsViewModel requierd data
    private func updateView(_ dataModel: ProductDetailsDataViewModel) {
        productImg.downloadImage(withUrl: dataModel.imgUrl)
        descriptionLbl.text = dataModel.discription
    }
    
}
