//
//  NameTest+CoreDataProperties.swift
//  detector
//
//  Created by НИКИТА ПЕСНЯК on 26.02.24.
//
//

import Foundation
import CoreData


extension NameTest {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NameTest> {
        return NSFetchRequest<NameTest>(entityName: "NameTest")
    }

    @NSManaged public var name_test: String?
    @NSManaged public var objectId: String?
    @NSManaged public var test_number: String?
   @NSManaged public var questions: NSSet?

}

// MARK: Generated accessors for questions
extension NameTest {

    @objc(addQuestionsObject:)
    @NSManaged public func addToQuestions(_ value: Questions)

    @objc(removeQuestionsObject:)
    @NSManaged public func removeFromQuestions(_ value: Questions)

    @objc(addQuestions:)
    @NSManaged public func addToQuestions(_ values: NSSet)

    @objc(removeQuestions:)
    @NSManaged public func removeFromQuestions(_ values: NSSet)

}

extension NameTest : Identifiable {

}
