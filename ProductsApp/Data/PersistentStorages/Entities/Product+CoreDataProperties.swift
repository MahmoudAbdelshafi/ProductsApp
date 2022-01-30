//
//  Product+CoreDataProperties.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 30/01/2022.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var id: Int16
    @NSManaged public var productDescription: String?
    @NSManaged public var price: Int16
    @NSManaged public var image: CoreDataImage?

}

extension Product : Identifiable {

}
