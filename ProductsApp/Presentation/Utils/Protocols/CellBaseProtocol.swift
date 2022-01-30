//
//  CellBaseProtocol.swift
//  ProductsApp
//
//  Created by Mahmoud Abdelshafi on 28/01/2022.
//

import Foundation
import UIKit

protocol CellBaseProtocol: AnyObject {
    static var reusableIdentifier: String { get }
    static var xibName: String { get }
}
