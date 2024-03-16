//
//  DragAndDropSwiftUIView.swift
//  Swiftly
//
//  Created by Guillermo Garcia Perez on 15/3/24.
//

import SwiftUI

struct DragAndDropSwiftUIView: View {
    @State var delegate : LessonViewController
    @State var data : DragAndDropElement
    @State var answers : [String]
    @State var options : [String]
    @State var buttonDisabled = [true, true, true, true, true, true, true, true, true, true, true]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack {
                Text("Question 1")
                    .frame(alignment: .leading)
                
                Image(systemName: "timer")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .frame(alignment: .trailing)
            }
            
            Text(data.question)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color(.secondarySystemFill))
                )
            
            HStack {

                VStack{
                    Text("Answers")
                    
                    VStack (alignment: .center) {
                        ForEach(0..<answers.count, id: \.self) { i in
                            HStack {
                                Button(action: { deleteButton(position: i) }) {
                                    Image(systemName: "trash")
                                        .imageScale(.large)
                                        .foregroundStyle(.tint)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                .disabled(buttonDisabled[i])
                                
                                Text(answers[i])
                                    .padding(12)
                                    .frame(width: 80)
                                    .background(Color(uiColor: .secondarySystemGroupedBackground))
                                    .cornerRadius(8)
                                    .shadow(radius: 1, x: 1, y: 1)
                                    .draggable(answers[i])
                                    .dropDestination(for: String.self) {droppedItems, location in
                                        answers[i] = droppedItems.first!
                                        for dropped in droppedItems {
                                            options.removeAll(){$0 == dropped}
                                        }
                                        buttonDisabled[i] = false
                                        data.question = data.question.replacingOccurrences(of: "\(i+1). __", with: answers[i])
                                        return true
                                    }
                            }
                        }
                    }.background(
                        RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(Color(.secondarySystemFill)))
                    
                }
                
                VStack{
                    
                    Text("Options")
                    
                    Grid {
                        ForEach(0..<3, id: \.self) { i in
                            GridRow {
                                ForEach(0...3, id: \.self) { j in
                                    if i*3+j < options.count{
                                        Text(options[i*3+j])
                                            .padding(12)
                                            .background(Color(uiColor: .secondarySystemGroupedBackground))
                                            .cornerRadius(8)
                                            .shadow(radius: 1, x: 1, y: 1)
                                            .draggable(options[i*3+j])
                                    }
                                }
                            }
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(Color(.secondarySystemFill)))
                    
                }

                
            }
            
            Button("Next", action: nextButton)
                .labelStyle(.iconOnly)
        }
        .padding()
    }
    
    func deleteButton(position : Int){
        if !answers[position].contains(". __") {
            data.question = data.question.replacingOccurrences(of: answers[position], with: "\(position+1). __")
            options.append(answers[position])
            answers[position]="\(position+1). __"
            buttonDisabled[position] = true
        }
    }
    
    
    func nextButton(){
        
        var results : [Int] = []
        
        for i in 0..<answers.count {
            if answers[i].contains(". __") {
                return
            } else {
                results.append(data.options.firstIndex(of: answers[i])!)
            }
        }
        delegate.next(result: results)
    }
}

var data = DragAndDropElement(
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
                "10", "i", "fact", "main[1]"],
    correctOptions: [0, 2, 3, 1, 3, 1], number: 6)

var emptyAnswers : [String] = ["1. __","2. __","3. __","4. __","5. __","6. __"]


#Preview {
    DragAndDropSwiftUIView(
        delegate: LessonViewController(),
        data: data,
        answers: emptyAnswers,
        options: data.options
        
    )
}
