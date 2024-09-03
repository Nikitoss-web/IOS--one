//
//  Results+CoreDataProperties.swift
//  detector
//
//  Created by НИКИТА ПЕСНЯК on 26.02.24.
//
//

import Foundation
import CoreData


extension Results {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Results> {
        return NSFetchRequest<Results>(entityName: "Results")
    }

    @NSManaged public var age: String?
    @NSManaged public var answers: String?
    @NSManaged public var lastname: String?
    @NSManaged public var name: String?

}

extension Results : Identifiable {

}
