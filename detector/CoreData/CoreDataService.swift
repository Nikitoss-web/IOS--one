import Foundation
import CoreData

final class CoreDataService {
    static var shared = CoreDataService()
    private init() {}
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    func saveQuestions(with tests: [Test]) {
        context.perform { [weak self] in
            guard let self = self else { return }
            for test in tests {
            if isQuestionAlreadySavedTest(name_test: test.name_test, objectId: test.objectId) {
                deleteOldTest(objectId: test.objectId)
            }
                let newTest = NameTest(context: self.context)
                newTest.name_test = test.name_test
                newTest.test_number = test.test_number
                newTest.objectId = test.objectId
            }
            self.saveContext()
        }
    }
    func fetchQuestions() -> [String] {
        let fetchRequest: NSFetchRequest<NameTest> = NameTest.fetchRequest()
        
        do {
            let nameTests = try context.fetch(fetchRequest)
            let testNames = nameTests.compactMap { $0.name_test }
            return testNames
        } catch {
            print("Failed to fetch test names: \(error)")
            return []
        }
    }
    func isQuestionAlreadySavedTest(name_test: String, objectId: String) -> Bool {
        let fetchRequest: NSFetchRequest<NameTest> = NameTest.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: SearchFormatBases.name_testObjectId.rawValue, name_test, objectId)

        do {
            let matchingQuestions = try context.fetch(fetchRequest)
            return !matchingQuestions.isEmpty
        } catch {
            print("Error checking if question is already saved: \(error)")
            return false
        }
    }
    func deleteOldTest(objectId: String) {
        let fetchRequest: NSFetchRequest<NameTest> = NameTest.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: SearchFormatBases.objectId.rawValue, objectId)

        do {
            let matchingQuestions = try context.fetch(fetchRequest)
            for question in matchingQuestions {
                context.delete(question)
            }
            print("Old questions deleted successfully")
        } catch {
            print("Error deleting old questions: \(error)")
        }
    }
    func saveNameTest(with questions1: QuestionResponse) {
        context.perform { [weak self] in
            guard let self = self else { return }

            let questionString = questions1.question.map { $0.questions }.joined(separator: ", ")

            if isQuestionAlreadySaved(questions: questionString, ownerId: questions1.name_test) {
                deleteOldQuestions(questions: questionString, ownerId: questions1.name_test)
            }

            let newquestions = Questions(context: self.context)
            newquestions.questions = questionString
            newquestions.ownerId = questions1.name_test
            self.saveContext()
        }
    }
    func deleteOldQuestions(questions: String, ownerId: String) {
        let fetchRequest: NSFetchRequest<Questions> = Questions.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: SearchFormatBases.ownerId.rawValue, ownerId)

        do {
            let matchingQuestions = try context.fetch(fetchRequest)
            for question in matchingQuestions {
                context.delete(question)
            }
            print("Old questions deleted successfully")
        } catch {
            print("Error deleting old questions: \(error)")
        }
    }
    func isQuestionAlreadySaved(questions: String, ownerId: String) -> Bool {
        let fetchRequest: NSFetchRequest<Questions> = Questions.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: SearchFormatBases.questionsOwnerId.rawValue, questions, ownerId)

        do {
            let matchingQuestions = try context.fetch(fetchRequest)
            return !matchingQuestions.isEmpty
        } catch {
            print("Error checking if question is already saved: \(error)")
            return false
        }
    }
    func fetchQuestionsFromCoreData(forownerId ownerId: String) -> [String]? {
        let fetchRequest: NSFetchRequest<Questions> = Questions.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: SearchFormatBases.ownerId.rawValue, ownerId)
        var questionsArray: [String] = []
        do {
            let questions = try context.fetch(fetchRequest)
            
            let questionStrings = questions.compactMap { $0.questions }
            if let questionsString = questionStrings.first {
                questionsArray = questionsString.components(separatedBy: ", ")
            }
            
            return questionsArray
        } catch {
            print("Failed to fetch questions from Core Data: \(error)")
            return nil
        }
    }
    private func saveContext () {
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let errors = error as NSError
                    fatalError("Unresolved error \(errors), \(errors.userInfo)")
                }
            }
        }
    }

