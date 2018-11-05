//
//  ListArrray+CoreDataProperties.swift
//  
//
//  Created by Sriram Prasad on 05/11/18.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension ListArrray {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListArrray> {
        return NSFetchRequest<ListArrray>(entityName: "ListArrray")
    }

    @NSManaged public var names: String?

}
