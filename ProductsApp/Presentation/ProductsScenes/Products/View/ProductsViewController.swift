//
//  ProductsViewController.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 28/01/2022.
//

import UIKit

final class ProductsViewController: UIViewController {
    
    //MARK: - Properties
    
    private var viewModel: ProductsViewModel!
    private var transitionAnimator: ViewControllerAnimatorProtocol!
    private let navTitle = "Products list"
    private var currentVisibleCell = UICollectionViewCell()
    
    //MARK: - IBoutlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    //MARK: - Create
    
    static func create(with viewModel: ProductsViewModel, transitionAnimator: ViewControllerAnimatorProtocol) -> ProductsViewController {
        let vc = ProductsViewController.loadFromNib()
        vc.viewModel = viewModel
        vc.transitionAnimator = transitionAnimator 
        return vc
    }
    
    // MARK: - ViewLifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
}

//MARK: - Private Functions

extension ProductsViewController {
    
    private func bind(to viewModel: ProductsViewModel) {
        viewModel.products.observe(on: self, observerBlock: updateProducts(_:))
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
    }
    
    
    private func updateProducts(_ products: ProductsPage) {
        self.collectionView.reloadInputViews()
        self.collectionView.reloadData()
        if let layout = collectionView
            .collectionViewLayout as? PinterestLayout {
            //layout.delegate = self
            layout.cache.removeAll()
        }
        
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        self.showAlert(title: viewModel.errorTitle, message: error)
    }
    
    private func setupUI() {
        registerCollectionView()
        setupNavBar()
    }
    
    private func setupNavBar() {
        self.title = navTitle
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)]
    }
    
    private func registerCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: ProductsCollectionViewCell.xibName, bundle: nil)
        collectionView.register(nib,
                                forCellWithReuseIdentifier: ProductsCollectionViewCell.reusableIdentifier)
        setCollectionViewLayout()
    }
    
    private func setCollectionViewLayout() {
        if let layout = collectionView
            .collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
    }
}


//MARK: - Collection View DataSource & Delegate

extension ProductsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductsCollectionViewCell.reusableIdentifier,
            for: indexPath)
                as? ProductsCollectionViewCell else {
                    fatalError("Couldn't dequeue \(ProductsCollectionViewCell.self)")
                }
        self.currentVisibleCell = cell
        cell.configure(product: viewModel.products.value.products[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.value.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row)
    }
}

//MARK: - Pinterest Layout Delegate

extension ProductsViewController: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return CGFloat(viewModel.collectionViewHeight(indexPath: indexPath))
    }
}

//MARK: - Scroll View

extension ProductsViewController {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.products.value.products.count - 1 {
            viewModel.loadNextPage()
        }
    }
}

//MARK: - Transition Delegate

extension ProductsViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionAnimator.originFrame = currentVisibleCell.contentView.frame
        transitionAnimator.presenting = true
        return transitionAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionAnimator.presenting = false
        return transitionAnimator
    }
}
