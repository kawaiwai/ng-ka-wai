import SwiftUI


struct ParkRecord : Codable, Identifiable {
    var id = UUID().uuidString
    var title: String
    var content : String
    
    
    static func json(records : [ParkRecord]) -> String {
        do {
            let data = try JSONEncoder().encode(records)
            let string = String(data: data, encoding: .utf8)
            return string ?? "[]"
        } catch _ {
            
        }
        return "[]"
    }
    
    static func get(string : String) -> [ParkRecord]{
        do {
            if let data = string.data(using: .utf8) {
                let records = try JSONDecoder().decode([ParkRecord].self, from: data)
                return records
            }
        } catch _ {
            
        }
        return []
    }
}

struct RecordsView: View {
    
    @AppStorage("records") var recordJSON : String = ""
    @State var records : [ParkRecord] = []
    @State var title : String = ""
    @State var content : String = ""
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Date", text: $title).textFieldStyle(.roundedBorder)
                    TextField("Place you go", text: $content).textFieldStyle(.roundedBorder)
                    Button(action: {
                        records.append(ParkRecord(title: title, content: content))
                        title = ""
                        content = ""
                        save()
                    }){Image(systemName: "plus")
                    }
                    .padding()
                }.padding()
                List {
                    
                    ForEach(records) {
                        record in
                        VStack (alignment: .leading){
                            Text("\(record.title)")
                                .font(.headline)
                                .foregroundStyle(.purple)
                            Text("\(record.content)")
                        }.padding(5)
                    }.onDelete(perform: { indexSet in
                        records.remove(atOffsets: indexSet)
                        save()
                    })
                }
                .listStyle(.grouped)
                .navigationTitle("Hit the Park Records")
            }
        }
        .onAppear {
            self.records = ParkRecord.get(string: recordJSON)
        }
    }
    
    func save() {
        self.recordJSON = ParkRecord.json(records: self.records)
    }
}

struct RecordsView_Preview : PreviewProvider {
    static var previews: some View {
        RecordsView(records: [])
    }
}
