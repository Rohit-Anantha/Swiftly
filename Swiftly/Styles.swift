//
//  Styles.swift
//  Swiftly
//
//  Created by Akın B on 3/17/24.
//

import Foundation
import UIKit

class RoundedButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set the desired margins
        let horizontalMargin: CGFloat = 30.0
        
        // Adjust the button's width to fill the superview horizontally with margins
        
        // Set the button's frame height to 40 pixels
        let buttonHeight: CGFloat = 40.0
        
        translatesAutoresizingMaskIntoConstraints = false // Ensure that Auto Layout constraints are used
        
        // Add width constraint
        widthAnchor.constraint(equalToConstant: 300).isActive = true
        heightAnchor.constraint(equalToConstant: 40).isActive = true // Fixed height
        
        setTitleColor(UIColor.white, for: .normal)
        
        
        // Apply rounded corners
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.backgroundColor = UIColor(named: "AccentColor")?.cgColor
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
        
        // Set up Auto Layout constraints to fill superview horizontally with margins
        translatesAutoresizingMaskIntoConstraints = false // Ensure that Auto Layout constraints are used
        
        // Add width constraint
        widthAnchor.constraint(equalToConstant: 300).isActive = true
        heightAnchor.constraint(equalToConstant: 40).isActive = true // Fixed height
        
    }
    

}

