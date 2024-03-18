//
//  FillBlankViewController.swift
//  Swiftly
//
//  Created by Eder Martinez on 3/14/24.
//

// NOT YET IMPLEMENTED IN OUR APP

import UIKit

class FillBlankViewController: UIViewController {
    private var fields: [UITextField] = []
    
    private var step = CGFloat(0)
    
    private var minWidth = CGFloat(10)
    private var maxWidth: CGFloat!
    private let padding = CGFloat(20)
    
    private var currX: CGFloat!
    private var currY: CGFloat!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        maxWidth = view.frame.maxX - minWidth
        currX = minWidth
        currY = CGFloat(100)
        
        step = CGFloat(50)
        
        putView(text: "Swift is a", isLabel: true)
        putView(isLabel: false)
        putView(text: "language developed by Apple for", isLabel: true)
        putView(isLabel: false)
        putView(text: "development. It replaced Objective", isLabel: true)
        putView(isLabel: false)
        
        
        let answers = ["programming", "iOS", "C"]
        let action = UIAction { _ in
            var wrongText = false
            for i in 0..<self.fields.count {
                guard let fieldText = self.fields[i].text else {
                    wrongText = true
                    break
                }
                if fieldText.lowercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) != answers[i].lowercased() {
                    wrongText = true
                    break
                }
            }
            print(wrongText ? "Incorrect" : "Correct")
        }
        
        let submit = UIButton(primaryAction: action)
        submit.setTitle("Submit", for: .normal)
        submit.frame.size = CGSize(width: 50, height: 30)
        submit.center = view.center
        view.addSubview(submit)
    }
    
    func putView(text: String = "Answer here", isLabel: Bool) {
        if isLabel {
            // Need to account for possibility of text occupying more than 1 line
            let textArray = text.components(separatedBy: " ")
            var currText = ""
            var currLabel = UILabel()
//            currLabel.text = ""
            for i in textArray {
//                currLabel.text = currLabel.text!.isEmpty ? i : currText + " " + i
                currLabel.text = currLabel.text == nil ? i : currText + " " + i
                // resets the size of frame
                currLabel.frame.size = currLabel.intrinsicContentSize
                
                if currLabel.frame.width + currX > maxWidth {
                    // Need to put on new line currText cannot contain new word without exceeding maxWidth
                    currLabel.frame.origin = CGPoint(x: currX, y: currY)
                    currLabel.center.y = currY
                    
                    // Reset back to original text without the string that made currWidth + currX > maxWidth
                    currLabel.text = currText
                    currText = i
                    currY += step
                    currX = minWidth
                    view.addSubview(currLabel)
                    currLabel = UILabel()
//                    currLabel.text = ""
                } else {
                    currText += " " + i
                }
            }
            currLabel.text = currText
            currLabel.frame.size = currLabel.intrinsicContentSize
            
            currLabel.frame.origin = CGPoint(x: currX, y: currY)
            currLabel.center.y = currY
            currX += currLabel.frame.width + padding
            
            view.addSubview(currLabel)
        } else {
            let field = UITextField()
            field.borderStyle = .roundedRect
            field.placeholder = text
            
            field.frame.size = field.intrinsicContentSize
            if field.frame.width + currX > maxWidth {
                // Place on next line
                currY += step
                currX = minWidth
            }
            // Fix this to have center of all the same
            field.frame.origin = CGPoint(x: currX, y: currY)
            field.center.y = currY
            currX += field.frame.width + padding
            view.addSubview(field)
            fields.append(field)
        }
    }
}
