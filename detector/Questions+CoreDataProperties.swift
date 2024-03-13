//
//  Questions+CoreDataProperties.swift
//  detector
//
//  Created by НИКИТА ПЕСНЯК on 28.02.24.
//
//

import Foundation
import CoreData


extension Questions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Questions> {
        return NSFetchRequest<Questions>(entityName: "Questions")
    }

    @NSManaged public var questions: String?
    @NSManaged public var ownerId: String?
    @NSManaged public var name_test: NameTest?

}

extension Questions : Identifiable {

}
