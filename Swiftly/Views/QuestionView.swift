//
//  QuestionView.swift
//  Swiftly
//
//  Created by Eder Martinez on 2/28/24.
//

import SwiftUI

struct QuestionView: View {
//    var topic: String
    var lesson: String
    var body: some View {
        VStack {
            Text("Some questions on \(lesson)")
                .padding(.top, 50)
            Spacer()
        }
    }
}

#Preview {
    QuestionView(lesson: "Lesson 1")
}
