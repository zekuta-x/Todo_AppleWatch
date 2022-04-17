//
//  ContentView.swift
//  WatchTodo WatchKit Extension
//
//  Created by 鳥山英峻 on 2022/04/16.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTY
    
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    
    // MARK: - FUNCTION
    
    func save() {
        dump(notes)
    }
    
    // MARK: - BODY
    
    
    var body: some View {
        VStack{
            HStack(alignment: .center, spacing: 6) {
                TextField("Add New Task", text: $text)
                Button {
                    guard text.isEmpty == false else { return }
                    let note = Note(id: UUID(), text: text)
                    notes.append(note)
                    text = ""
                    save()
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 42, weight: .semibold))
                }
                .fixedSize()
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.accentColor)
                //.buttonStyle(BorderedButtonStyle(tint: .accentColor))
            } //: HSTACK
            Spacer()
            
            Text("\(notes.count)")
        } //: VSTACK
        .navigationTitle("Notes")
    }
}

    // MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
