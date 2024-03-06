//
//  Settings.swift
//  Swiftly
//
//  Created by Eder Martinez on 3/3/24.
//

import Foundation
import SwiftUI

struct UserSettings {
    var firstName: String
    var lastName: String
    var theme: Color
}

extension UserSettings {
    static var defaultUser: UserSettings {
        UserSettings(firstName: "John", lastName: "Cena", theme: .green)
    }
}
