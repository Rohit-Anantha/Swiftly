//
//  FillTheBlankViewController.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 9/3/24.
//

// View Controller for Lesson Questions with Fill in the Blank style

import UIKit

class FillTheBlankViewController: UIViewController, LessonElementViewController {
    
    
    // MARK: - Documentation
    
    /*
     Eder did this VC in a another file, I didn't have enough time to do this myself. Thanks Eder! Idk how it works, we still have to integrate it.
     */
    
    
    // MARK: - Variables
    
    // Protocol Variables
    var delegate: LessonViewController!
    var number: Int!
    var timer = 0
    var stopTimer = false
    
    // Storyboard variables
    
    // Other variables
    var data : FillTheBlankElement!
    
    private var fields: [UITextField] = []
    
    
    // MARK: - View Controller Events

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // In case we set up a timer
        //let timerSymbol = UIImage(systemName: "timer")
        //let timerText = UILabel("\(self.timer)")
        
        let backgroundView = UIView()
        backgroundView.frame = CGRect(x: 20, y: 100, width: view.frame.width - CGFloat(40), height: view.frame.height / 2)
        backgroundView.backgroundColor = .lightGray
        backgroundView.layer.cornerRadius = 10
        view.addSubview(backgroundView)
        addText(text: data.question, fieldIndexes: data.index, parent: backgroundView)
        
        let action = UIAction() { _ in
            let results = self.buttonAction()
            if results.count == self.fields.count {
                // Guillermo, a '1' represents that the user is correct.
                // A '0' represents that the user is incorrect.
                var userCorrectAnswers: [Int] = []
                for i in results {
                    userCorrectAnswers.append(i ? 1 : 0)
                }
                self.delegate.next(result: userCorrectAnswers, timer: self.timer)
            }
        }
        
        let button = UIButton(primaryAction: action)
        view.addSubview(button)
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .accent
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints: [NSLayoutConstraint] = []
        
        constraints.append(button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        
        // Height
        constraints.append(button.heightAnchor.constraint(equalToConstant: CGFloat(50)))
        
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.black, for: .normal)
        NSLayoutConstraint.activate(constraints)
        
        // If we time these
//        if self.data.isTimed {
//            // Set the timer up
//            //self.timerLabel.text = formatTime(timer)
//
//            // Add the task that will decrease the timer
//            let queue = DispatchQueue(label: "TimerQueue", qos: .default)
//            queue.async {
//                while !self.stopTimer && self.timer > 0 {
//                    usleep(1000000)
//                    DispatchQueue.main.async {
//                        self.timer -= 1
//                        //self.timerLabel.text = self.formatTime(self.timer)
//                    }
//                }
//                if self.timer <= 0 {
//                    DispatchQueue.main.sync{
//                        
//                        let alert = UIAlertController(
//                            title: "Oh no!",
//                            message: "Seems like you ran out of time! You will be taken back to the roadmap with a penalty on your score.",
//                            preferredStyle: .actionSheet)
//                        alert.addAction(UIAlertAction(
//                            title: "Ok",
//                            style: .default) {  (alert) in
//                                Task {await self.delegate.decreaseScore()}
//                            })
//                        
//                        self.present(alert,animated: true)
//                        
//                        self.delegate.userRanOutOfTime()
//                    }
//                }
//            }
//            
//        } else {
//            //self.timerLabel.isHidden = true
//            //self.timerSymbol.isHidden = true
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.stopTimer = true
    }
    
    func buttonAction() -> [Bool] {
        var results: [Bool] = []
        for i in 0..<fields.count {
            guard let text = fields[i].text else { return results }
            let answer = data.question[data.index[i]]
            guard !text.isEmpty else { return results }
            results.append(text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == answer.trimmingCharacters(in: .whitespacesAndNewlines).lowercased())
        }
        return results
    }
    
    
    func addText(text: [String], fieldIndexes: [Int], parent: UIView, padding: CGFloat = CGFloat(15), outsidePadding: CGFloat = CGFloat(40)) {
        let minWidth = outsidePadding
        let maxWidth = parent.bounds.width - outsidePadding
        let minHeight = outsidePadding
        var currentXValue = minWidth - padding
        var currentYValue = minHeight
        func getLabel() -> UILabel {
            let label = UILabel()
            label.frame.origin.x = currentXValue + padding
            parent.addSubview(label)
            return label
        }
        func createUIField() -> UITextField {
            let field = UITextField()
            field.borderStyle = .roundedRect
            field.placeholder = "Answer"
            field.sizeToFit()
            field.frame.origin.x = currentXValue + padding
            field.center.y = currentYValue
            parent.addSubview(field)
            fields.append(field)
            return field
        }
        func nextLine() {
            currentXValue = minWidth - padding
            currentYValue += CGFloat(50)
        }
        var label: UILabel!
        for i in 0..<text.count {
            if fieldIndexes.contains(i) {
                // Add any previous text
                // Add textField
                if label != nil {
                    label.sizeToFit()
                    label.center.y = currentYValue
                    currentXValue += label.frame.width + padding
                    label = nil
                }
                let field = createUIField()
                if currentXValue + field.frame.width + padding > maxWidth {
                    // Add would result in textfield being over maxWidth
                    nextLine()
                    field.frame.origin.x = currentXValue + padding
                    field.center.y = currentYValue
                }
                currentXValue += field.frame.width + padding
            } else {
                let word = text[i]
                if label == nil {
                    label = getLabel()
                }
                let previousText = label.text
                label.text = previousText != nil ? previousText! + " " + word : word
                label.sizeToFit()
                if currentXValue + label.frame.width + padding > maxWidth {
                    label.center.y = currentYValue
                    nextLine()
                    label.text = previousText
                    if previousText == nil {
                        label.removeFromSuperview()
                    }
                    label = getLabel()
                    label.center.y = currentYValue
                    label.text = word
                    label.sizeToFit()
                }
            }
        }
        if let label = label {
            label.center.y = currentYValue
        }
        parent.frame.size.height = currentYValue + outsidePadding
    }
    

    // MARK: - Actions

    
    
    // MARK: - Protocols
    
    func setup(data: LessonElement, delegate: LessonViewController, counter: Int, timer : Int, isReview: Bool) {
        self.delegate = delegate
        self.number = counter
        self.data = data as? FillTheBlankElement
        self.timer = timer
    }
}
