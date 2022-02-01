//
//  CoreDataImage+CoreDataProperties.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 01/02/2022.
//
//

import Foundation
import CoreData


extension CoreDataImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataImage> {
        return NSFetchRequest<CoreDataImage>(entityName: "CoreDataImage")
    }
    
    @NSManaged public var height: Int16
    @NSManaged public var url: String?
    @NSManaged public var width: Int16

}

