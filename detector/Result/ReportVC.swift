//
//  ReportVC.swift
//  detector
//
//  Created by НИКИТА ПЕСНЯК on 15.02.24.
//

import UIKit

class ReportVC: UIViewController {
    @IBOutlet private weak var nameLable: UILabel!
    @IBOutlet private weak var lastnameLable: UILabel!
    @IBOutlet private weak var ageLable: UILabel!
    @IBOutlet private weak var questionField: UITextView!
    private let report = Report()
    var selectedResult: ViewResults?
    var currentQuestion = ""
    var currentAnswer = ""
    var questions: [String] = []
    var answers: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        report.outputResults(selectedResult: selectedResult, nameLable: nameLable, lastnameLable: lastnameLable, ageLable: ageLable, questions: &questions, answers: &answers, questionField: questionField)
       
    }

}
