//
//  DragAndDropSwiftUIView.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 15/3/24.
//

import SwiftUI

struct DragAndDropSwiftUIView: View {
    @State private var toDoTasks: [String] = ["if", "for", "class", "+="]
    @State private var inProgressTasks: [String] = ["","",""]
    @State var data : DragAndDropElement

    var body: some View {
        HStack(spacing: 12) {
            KanbanView(title: "Answers", tasks: inProgressTasks)
            KanbanView(title: "Options", tasks: toDoTasks)
        }
        .padding()
    }
}

struct KanbanView: View {

    let title: String
    let tasks: [String]

    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.footnote.bold())
            
            //ForEach((1...3), id: \.self) { task in
            //    HStack {
                    ForEach(tasks, id: \.self) { task in
                        Text(task)
                            .padding(12)
                            .background(Color(uiColor: .secondarySystemGroupedBackground))
                            .cornerRadius(8)
                            .shadow(radius: 1, x: 1, y: 1)
                            .draggable(task)
                    }
                //}
            //    .padding(.vertical)
            //}
        }
    }
}

#Preview {
    DragAndDropSwiftUIView(
        data: DragAndDropElement(
            type: .question(type: .dragAndDrop),
            question: """
                   //Calculate factorial
                   fact = 10
                   _0 i in 1..<_1 {
                       fact _2 i
                       _3("fact is now \\(fact)")
                   }
                   _4("Result is \\(_5)")
                   """,
              options: ["for", "if", "while", "do", "then",
                        "10", "i", "fact", "main[1]", "nil",
                        "=", "+", "*=", "in",
                        "fact", "print", "do", "show",
                        "if", "show", "print", "now",
                        "result", "fact", "100", "fact(10)"],
              correctOptions: [0, 2, 3, 1, 3, 1])
    )
}
