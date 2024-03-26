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
    private let viewModel = ReportVCModel()
    var selectedResult: ViewResults?
       override func viewDidLoad() {
           super.viewDidLoad()
           
           viewModel.setupReport(selectedResult: selectedResult, nameLable: nameLable, lastnameLable: lastnameLable, ageLable: ageLable, questionField: questionField)
       }

}
