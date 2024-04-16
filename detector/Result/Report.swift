import Foundation
import UIKit

protocol Reports {
    func outputResults(selectedResult: ViewResults?) -> ReportsData?
    func sortedQuestions(reportData: inout ReportsData, answers: String)
    func answerNoYes(component: String) -> Bool
    func answerTruthLie(component: String) -> Bool
    func checkEmptiness(component: String) -> Bool
}

class Report: Reports {

    func outputResults(selectedResult: ViewResults?) -> ReportsData? {
        guard let result = selectedResult else {
            return nil
        }

        var reportData = ReportsData(name: result.name ?? "",
                                     lastname: result.lastname ?? "",
                                     age: result.age ?? "",
                                     questions: [],
                                     answers: [],
                                     answerResults: [],
                                     textViewText: "")

        sortedQuestions(reportData: &reportData, answers: result.answers ?? "")

        return reportData
    }

    func sortedQuestions(reportData: inout ReportsData, answers: String) {
        let components = answers.components(separatedBy: .newlines)
        var currentQuestion = ""
        
        for component in components {
            let trimmedComponents = component.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")
            
            for trimmedComponent in trimmedComponents {
                let formattedComponent = trimmedComponent.trimmingCharacters(in: .whitespacesAndNewlines)
                
                if answerNoYes(component: formattedComponent) {
                    reportData.answers.append(formattedComponent)
                    if !currentQuestion.isEmpty {
                        reportData.questions.append(currentQuestion)
                        currentQuestion = ""
                    }
                } else if answerTruthLie(component: formattedComponent) {
                    reportData.answerResults.append(formattedComponent)
                } else {
                    currentQuestion += " " + formattedComponent
                }
            }
        }
        
        if !currentQuestion.isEmpty {
            reportData.questions.append(currentQuestion)
        }
        reportData.textViewText = zip(zip(reportData.questions, reportData.answers), reportData.answerResults)
            .map { "\($0.0) \($0.1) \($1) \n" }
            .joined()
    }
    
    func answerNoYes(component: String) -> Bool {
        return component.lowercased() == "no" || component.lowercased() == "yes"
    }

    func answerTruthLie(component: String) -> Bool {
        return component.lowercased() == "truth" || component.lowercased() == "lie"
    }

    func checkEmptiness(component: String) -> Bool {
        return !component.isEmpty
    }
}
