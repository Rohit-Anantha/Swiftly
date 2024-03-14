//
//  FillBlankViewController.swift
//  Swiftly
//
//  Created by Eder Martinez on 3/14/24.
//

import UIKit

class FillBlankViewController: UIViewController {
    
    private var currX = CGFloat(0)
    private var currY = CGFloat(100)
    private var fields: [UITextField] = []
    
    // Distance between multiple lines
    private var step = CGFloat(50)
    
    private var maxWidth = CGFloat(0)
    
    // Padding between UILabel and UITextField
    private let padding = CGFloat(20)

    override func viewDidLoad() {
        super.viewDidLoad()
        maxWidth = view.frame.maxX
                
        putView(text: "Swift is a", isLabel: true)
        putView(isLabel: false)
        putView(text: "language developed by", isLabel: true)
        putView(isLabel: false)
        putView(text: "for iOS development", isLabel: true)
        
        let action = UIAction { _ in
            for i in self.fields {
                print(i.text!)
            }
        }
        
        let submit = UIButton(primaryAction: action)
        submit.setTitle("Submit", for: .normal)
        submit.frame.size = CGSize(width: 50, height: 30)
        submit.center = view.center
        view.addSubview(submit)
        
    }
    
    func putView(text: String = "Answer here", isLabel: Bool) {
        // Sets the childview's frame (width and height)
        // without this the frame is width and height are 0
        if isLabel {
            // Need to account for possibility of text occupying more than 1 line
            let textArray = text.components(separatedBy: " ")
            var currText = ""
            var currLabel = UILabel()
            currLabel.text = ""
            for i in textArray {
                // Adds space even if first in line
                if currLabel.text!.isEmpty {
                    currLabel.text = i
                } else {
                    currLabel.text = currText + " " + i
                }
                currLabel.frame.size = currLabel.intrinsicContentSize
                let currWidth = currLabel.frame.width
                if currWidth + currX > maxWidth {
                    // Need to put on new line currText cannot contain new word without exceeding maxWidth
                    currLabel.frame.origin = CGPoint(x: currX, y: currY)
                    // Reset back to original text
                    currLabel.text = currText
                    currText = i
                    currY += step
                    currX = CGFloat(0)
                    view.addSubview(currLabel)
                    currLabel = UILabel()
                    currLabel.text = ""
                } else {
                    currText += " " + i
                }
            }
            currLabel.frame.origin = CGPoint(x: currX, y: currY)
            currLabel.text = currText
            currX += currLabel.frame.width + padding
            view.addSubview(currLabel)
        } else {
            let field = UITextField()
            // Styles text field
            field.borderStyle = .roundedRect
            field.placeholder = text
            field.frame.size = field.intrinsicContentSize
            let childWidth = field.frame.width
            if childWidth + currX > maxWidth {
                // Place on next line
                currY += step
                currX = CGFloat(0)
            }
            // Fix this to have center of all the same
            field.frame.origin = CGPoint(x: currX, y: currY)
            currX += childWidth + padding
            view.addSubview(field)
            fields.append(field)
        }
    }
}

