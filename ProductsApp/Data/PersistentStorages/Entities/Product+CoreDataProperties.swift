//
//  Product+CoreDataProperties.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 01/02/2022.
//
//

import Foundation
import CoreData


extension Product {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }
    
    @objc public class func insertProductObject(context: NSManagedObjectContext) -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: "Product", into: context)
    }
    
    @objc public class func insertCoreDataImageObject(context: NSManagedObjectContext) -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: "CoreDataImage", into: context)
    }

    
    @NSManaged public var id: Int16
    @NSManaged public var price: Int16
    @NSManaged public var productDescription: String?
    @NSManaged public var image: CoreDataImage?
    
}

extension Product : Identifiable {
    
}

extension Product {
    static func toProductResponse(_ savedProducts: [Product]) -> [ProductResponseDTO] {
        var productsResponseArray = [ProductResponseDTO]()
        
        for product in savedProducts {
            let image = Image(width: Int(product.image?.width ?? 0),
                              height: Int(product.image?.height ?? 0),
                              url: product.image?.url)
            
            let productResponse = ProductResponseDTO(id: Int(product.id),
                                                     productDescription: product.productDescription,
                                                     image: image,
                                                     price: Int(product.price))
            productsResponseArray.append(productResponse)
        }
        return productsResponseArray
    }
}

extension ProductResponseDTO {
     func toProductCoreDataEntityForInserting(context: NSManagedObjectContext) -> Product? {
        if let productEntity = Product.insertProductObject(context: context) as? Product {
            productEntity.price = Int16(self.price ?? 0)
            productEntity.productDescription = self.productDescription
            productEntity.id = Int16(self.id ?? 0)
            
            if let imageEntity = Product.insertCoreDataImageObject(context: context) as? CoreDataImage {
                imageEntity.height = Int16(self.image?.height ?? 0)
                imageEntity.width = Int16(self.image?.width ?? 0)
                imageEntity.url = self.image?.url
                productEntity.image = imageEntity
            }
            return productEntity
        }
       return nil
    }
}
