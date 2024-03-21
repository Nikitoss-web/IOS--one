//
//  CalculatingResult.swift
//  detector
//
//  Created by НИКИТА ПЕСНЯК on 16.03.24.
//

import Foundation
import UIKit

class CalculatingResult{
    
    
    func maxArray(StringArray: [String]) -> Int?{
        var intArray: [Int] = []
        for i in StringArray{
            if let intValue = Int(i){
                intArray.append(intValue)
            }
        }
        
        return intArray.max() ?? 0
    }
    
    func responseResult(resultView: UIView!, array: [String], maxECG: Int){
        if let answerArray = maxArray(StringArray: array){
            if answerArray <= maxECG{
                resultView.backgroundColor = .green
            }
            else{
                resultView.backgroundColor = .red
            }
            
            
            
        }
    }
    
    
}
