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
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save() {
        //        dump(notes) //クラスのインスタンスがインデント付きで確認可能
        do{
            let data = try JSONEncoder().encode(notes)
            let url = getDocumentDirectory().appendingPathComponent("notes")
            try data.write(to: url)
        } catch {
            print("Saving data has failed!")
        }
    }
    
    func load(){
        DispatchQueue.main.async {
            do{
                let url = getDocumentDirectory().appendingPathComponent("notes")
                let data = try Data(contentsOf: url)
                notes = try JSONDecoder().decode([Note].self, from: data)
                
            } catch {
                
            }
        }
    }
    
    func delete(offsets: IndexSet) {
            notes.remove(atOffsets: offsets)
            save()
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
            
            if notes.count >= 1 {
                List{
                    ForEach(0..<notes.count, id: \.self) { i in
                        NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)){
                            HStack {
                                Capsule()
                                    .frame(width: 4)
                                    .foregroundColor(.accentColor)
                                Text(notes[i].text)
                                    .lineLimit(1)
                                    .padding(.leading, 5)
                            }
                        }
                    }
                    //: LOOP
                    .swipeActions(edge: .leading) {
                        Button {
                            print("Task done")
                        } label: {
                            Image(systemName: "checkmark.square.fill")
                        }
                        .tint(.blue)
                        .font(.system(size: 45, weight: .semibold))
                        .imageScale(.large)
                    }
                    .swipeActions(edge: .trailing) {
                        Button() {
                            print(notes)
//                            delete(offsets: <#T##IndexSet#>)
//                            notes.remove(at: notes.index)
//                            save()
                        } label: {
                            Image(systemName: "trash.square.fill")
                        }
                        .tint(.red)
                        .font(.system(size: 25))
                        .imageScale(.large)
                    }
                    
                    HStack{
                        //: 遂行したタスクリスト}
                        Image(systemName:"text.badge.checkmark")
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundColor(.accentColor)
                            .onTapGesture{print("Complate tasks")}
                        
                        Spacer()
                        
                        //: ゴミ箱行きのタスクリスト
                        
                        Image(systemName:"trash")
                            .font(.system(size: 25, weight: .semibold))
                            .foregroundColor(.accentColor)
                            .onTapGesture{ print("Trash tasks")}
                            .padding(.trailing)
                        
                    }
                    .listRowBackground(Color.clear)
                }
            } else {
                Spacer()
                Image(systemName:"note.text")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.25)
                    .padding(25)
                Spacer()
            }
        } //: VSTACK end
        .navigationTitle("FastTasks")
        .onAppear(perform: {
            load()
        })
    }
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
