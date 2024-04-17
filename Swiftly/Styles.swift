//
//  Styles.swift
//  Swiftly
//
//  Created by Akın B on 3/17/24.
//  Mainly worked on by Rohit after initial

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
        layer.masksToBounds = true
        backgroundColor = UIColor(named: "offSelect")
        alpha = 0.75
        setTitleColor(UIColor(named: "textColor"), for: .normal)
        titleLabel?.numberOfLines = 0
        clipsToBounds = true
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 6.0
        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        titleLabel?.textAlignment = .center
        self.titleLabel?.font = UIFont(name: "Avenir-Book", size: 17)
        
    }
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
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1.0
        
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
    }
    
    private func commonInit(){
        layer.cornerRadius = 6
        layer.shadowColor = UIColor.black.cgColor
        self.textColor = UIColor(named: "textColor")
        // clipsToBounds = false
        // layer.shadowOpacity = 0.5
        // layer.shadowOffset = CGSize(width: 10, height: 10)
        // layer.shadowRadius = 10
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1.0
        textContainer.maximumNumberOfLines = 0
        textContainer.lineBreakMode = .byWordWrapping
        isSelectable = false
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .center
        font = UIFont(name: "Avenir-Book", size: 20)
        
        isScrollEnabled = true
        isUserInteractionEnabled = true
        
        backgroundColor = UIColor(named: "textBoxBackground")
    }
    
    func constrain(width: CGFloat, height:CGFloat ){
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width),
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
}

class CodeTextView: UITextView {
    // MARK: - Initialization
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        // Apply code style
        applyCodeStyle()
    }
    
    // MARK: - Code Style
    private func applyCodeStyle() {
        // Set font to a monospaced font
        if let font = UIFont(name: "Menlo-Regular", size: 15) {
            self.font = font
        }
        
        // Set background color
        self.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        
        // Add padding
        self.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        // Optionally, you can also adjust other properties such as text color, border, etc.
        self.textColor = UIColor.black
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 6.0
        translatesAutoresizingMaskIntoConstraints = false
        isSelectable = false

    }
    func constrain(width: CGFloat, height:CGFloat ){
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width),
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
