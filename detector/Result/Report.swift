import Foundation
import UIKit

class Report {
    func outputResults(selectedResult: ViewResults?, nameLable: UILabel!, lastnameLable: UILabel!, ageLable: UILabel!, questions: inout [String], answers: inout [String], answerResults: inout [String], questionField: UITextView!) {
        var textViewText = ""
        if let result = selectedResult {
            sortedQuestions(result.Answers ?? "", answers: &answers, questions: &questions, answerResults: &answerResults)
            nameLable.text = result.Name
            lastnameLable.text = result.Lastname
            ageLable.text = result.Age
            for i in 0..<questions.count {
                textViewText += "\(questions[i])      \(answers[i])      \(answerResults[i])\n"
            }
            questionField.text = textViewText
            print(textViewText)
        } else {
            print("Результат не установлен")
        }
    }
    func sortedQuestions(_ answersText: String, answers: inout [String], questions: inout [String], answerResults: inout [String]) {
        let components = answersText.components(separatedBy: .whitespacesAndNewlines)
        var currentQuestion = ""
        for component in components {
            if answerNoYes(component: component) {
                answers.append(component)
                if сheckEmptiness(component: currentQuestion) {
                    questions.append(currentQuestion)
                    currentQuestion = ""
                }
            } else if answerTruthLie(component: component) {
                answerResults.append(component)
            } else {
                if сheckEmptiness(component: component) {
                    currentQuestion += " " + component
                }
            }
        }
        if !currentQuestion.isEmpty {
            questions.append(currentQuestion)
        }
    }
    func answerNoYes(component: String) -> Bool{
        return component.lowercased() == "no" || component.lowercased() == "yes"
    }
    func answerTruthLie(component: String) -> Bool{
        return component.lowercased() == "truth" || component.lowercased() == "lie"
    }
    func сheckEmptiness(component: String) -> Bool{
        return !component.isEmpty
    }
    }
   
