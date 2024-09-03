//
//  XibTimer.swift
//  detector
//
//  Created by НИКИТА ПЕСНЯК on 11.03.24.
//

import Foundation
import UIKit
@IBDesignable
class XibTimer: UIView{
    @IBOutlet weak var times: UILabel!
//    @IBOutlet var view: XibTimer!
    private var timer: Timer?
    private var time: TimeInterval = 0.0{
        didSet{
            times.text = String(format: "%.1f", time)
        }
    }
    @IBAction  func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {
            _ in self.time += 0.1
        })
    }
    @IBAction func stopTimer(){
        timer?.invalidate()
        time = 0.0
    }
    
    
    
}
