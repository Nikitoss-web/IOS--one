import Foundation
import UIKit

class Report {
    func outputResults(selectedResult: ViewResults?, nameLable: UILabel!, lastnameLable: UILabel!, ageLable: UILabel!, questions: inout [String], answers: inout [String], questionField: UITextView!) {
        var textViewText = ""
        if let result = selectedResult {
            sortedQuestions(result.Answers ?? "", answers: &answers, questions: &questions)
            nameLable.text = result.Name
            lastnameLable.text = result.Lastname
            ageLable.text = result.Age
            for i in 0..<questions.count {
                textViewText += "\(questions[i])      \(answers[i])\n"
            }
            questionField.text = textViewText
            print(textViewText)
        } else {
            print("Результат не установлен")
        }
    }

    func sortedQuestions(_ answersText: String, answers: inout [String], questions: inout [String]) {
        let components = answersText.components(separatedBy: .whitespacesAndNewlines)
        var currentQuestion = ""

        for component in components {
            if component.lowercased() == "no" || component.lowercased() == "yes" {
                answers.append(component)

                if !currentQuestion.isEmpty {
                    questions.append(currentQuestion)
                    currentQuestion = ""
                }
            } else {
                if !component.isEmpty {
                    currentQuestion += " " + component
                }
            }
        }

        if !currentQuestion.isEmpty {
            questions.append(currentQuestion)
        }

        for i in 0..<questions.count {
            print("Вопрос: \(questions[i])")
            print("Ответ: \(answers[i])")
        }
    }
}
