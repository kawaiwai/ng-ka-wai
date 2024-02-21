//
//  RecordsView.swift
//  PORApp
//
//  Created by ituser on 1/31/24.
//

import SwiftUI


struct Record : Codable, Identifiable {
    var id = UUID().uuidString
    var title: String
    var content : String
    
    
    static func json(records : [Record]) -> String {
        do {
            let data = try JSONEncoder().encode(records)
            let string = String(data: data, encoding: .utf8)
            return string ?? "[]"
        } catch _ {
            
        }
        return "[]"
    }
    
    static func get(string : String) -> [Record]{
        do {
            if let data = string.data(using: .utf8) {
                let records = try JSONDecoder().decode([Record].self, from: data)
                return records
            }
        } catch _ {
            
        }
        return []
    }
}

struct RecordsView: View {
    
    @AppStorage("records") var recordJSON : String = ""
    @State var records : [Record] = []
    @State var title : String = ""
    @State var content : String = ""
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("title", text: $title).textFieldStyle(.roundedBorder)
                    TextField("content", text: $content).textFieldStyle(.roundedBorder)
                    Button(action: {
                        records.append(Record(title: title, content: content))
                        title = ""
                        content = ""
                        save()
                    }, label: {
                        Text("Add")
                    }).padding()
                }.padding()
                List {
                    
                    ForEach(records) {
                        record in
                        VStack (alignment: .leading){
                            Text("\(record.title)")
                                .font(.headline)
                            Text("\(record.content)")
                        }.padding(5)
                    }.onDelete(perform: { indexSet in
                        records.remove(atOffsets: indexSet)
                        save()
                    })
                }
                .listStyle(.grouped)
                .navigationTitle("My Records")
            }
        }
        .onAppear {
            self.records = Record.get(string: recordJSON)
        }
    }
    
    func save() {
        self.recordJSON = Record.json(records: self.records)
    }
}

struct RecordsView_Preview : PreviewProvider {
    static var previews: some View {
        RecordsView(records: [])
    }
}
