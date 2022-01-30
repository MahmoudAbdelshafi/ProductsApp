//
//  Image+CoreDataProperties.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 30/01/2022.
//
//

import Foundation
import CoreData


extension CoreDataImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataImage> {
        return NSFetchRequest<CoreDataImage>(entityName: "Image")
    }

    @NSManaged public var width: Int16
    @NSManaged public var height: Int16
    @NSManaged public var url: String?
    @NSManaged public var img: Product?

}

extension CoreDataImage : Identifiable {

}
