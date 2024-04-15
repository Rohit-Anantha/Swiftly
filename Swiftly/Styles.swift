//
//  Styles.swift
//  Swiftly
//
//  Created by Akın B on 3/17/24.
//

import Foundation
import UIKit



class RoundedButton: UIButton {
    override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            commonInit()
        }
        
        private func commonInit() {
            // Apply rounded corners
            layer.cornerRadius = 8
            layer.masksToBounds = true
            backgroundColor = UIColor(named: "offSelect")
            alpha = 0.75
            setTitleColor(UIColor(named: "textColor"), for: .normal)
            titleLabel?.numberOfLines = 0
            layer.shadowColor = UIColor.black.cgColor
            clipsToBounds = false
            layer.shadowOpacity = 0.5
            layer.shadowOffset = CGSizeMake(5, 5)
            layer.shadowRadius = 2
            self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            titleLabel?.textAlignment = .center
            self.titleLabel?.font = UIFont(name: "Avenir-Book", size: 17)
                    
        }
    /*
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set the desired margins
        let horizontalMargin: CGFloat = 30.0
        
        // Adjust the button's width to fill the superview horizontally with margins
        
        // Set the button's frame height to 40 pixels
        let buttonHeight: CGFloat = 40.0
        
        translatesAutoresizingMaskIntoConstraints = false // Ensure that Auto Layout constraints are used
        // Apply rounded corners
        layer.cornerRadius = 8
        layer.masksToBounds = true
        self.titleLabel?.numberOfLines = 0
        //self.layer.borderWidth = 2.0
        //self.layer.borderColor = UIColor.black.cgColor

    }
     */
}

import UIKit

class RoundedTextField: UITextField {
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        // Apply rounded corners
        layer.cornerRadius = 8 // You can adjust the corner radius as needed
        layer.masksToBounds = true
        self.backgroundColor = .white
        let originalTextColor = UIColor(named: "textColor")
        let lowerOpacityColor = originalTextColor?.withAlphaComponent(0.5)
        self.textColor = originalTextColor

        if let placeholderText = self.placeholder {
                    // Create an attributed string for placeholder text with desired color
            let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: lowerOpacityColor ?? .black])
                    
                    // Set the attributed placeholder text
                    self.attributedPlaceholder = attributedPlaceholder
                }
                
        
        // Set up Auto Layout constraints to fill superview horizontally with margins
        translatesAutoresizingMaskIntoConstraints = false // Ensure that Auto Layout constraints are used
        
        // Add width constraint
        widthAnchor.constraint(equalToConstant: 300).isActive = true
        heightAnchor.constraint(equalToConstant: 40).isActive = true // Fixed height
        
    }
    
    

}

class RoundedTextView: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
            super.init(frame: frame, textContainer: textContainer)
            commonInit()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            centerTextVertically()
        }
        
    private func centerTextVertically() {
        let fittingSize = CGSize(width: bounds.width - textContainerInset.left - textContainerInset.right, height: CGFloat.greatestFiniteMagnitude)
        let textSize = sizeThatFits(fittingSize)
        let verticalInset = max(0, (bounds.height - textSize.height - contentInset.top - contentInset.bottom) / 2)
        contentOffset.y = -verticalInset
    }
    private func commonInit(){
        layer.cornerRadius = 6
        layer.shadowColor = UIColor.black.cgColor
        self.textColor = UIColor(named: "textColor")
        clipsToBounds = false
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSizeMake(5, 5)
        layer.shadowRadius = 2
        textContainer.maximumNumberOfLines = 0
        textContainer.lineBreakMode = .byWordWrapping
        isSelectable = false
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .center
        font = UIFont(name: "Avenir-Book", size: 20)
        
        backgroundColor = UIColor(named: "textBoxBackground")
    }
    
    func constrain(width: CGFloat, height:CGFloat ){
        NSLayoutConstraint.activate([
                    widthAnchor.constraint(equalToConstant: width),
                    heightAnchor.constraint(equalToConstant: height)
                ])
    }
}

