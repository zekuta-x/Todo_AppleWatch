//
//  DetailView.swift
//  WatchTodo WatchKit Extension
//
//  Created by 鳥山英峻 on 2022/04/17.
//

import SwiftUI

struct DetailView: View {
    // MARK: - PROPERY
    
    let note: Note
    let count: Int
    let index: Int
    
    // MARK: - BODY
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 3) {
            HStack{
                Capsule()
                    .frame(height: 1)
                
                Image(systemName:"note.text")
                
                Capsule()
                    .frame(height: 1)
            }
            .foregroundColor(.accentColor)
            .padding(.top, 5)
            .padding(.bottom, 5)
            
            Text("\(note.text)")
                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            HStack{
                Image(systemName:"gear")
                    .imageScale(.large)
                
                Spacer()
                
                Text("\(count) / \(index + 1)")
                
                Spacer()
                
                Image(systemName:"info.circle")
                    .imageScale(.large)
            }
        }
        .padding(3)
        
    }
}


// MARK: - PREVIEW

struct DetailView_Previews: PreviewProvider {
    static var sampleData: Note = Note(id: UUID(), text: "Hello, World!")
    
    static var previews: some View {
        DetailView(note: sampleData, count: 5, index: 1)
    }
}

