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
    func responseResult( array: [String], maxECG: Int) -> Bool{
        guard let answerArray = maxArray(StringArray: array) else {return false}
        return answerArray <= maxECG
    }
}
