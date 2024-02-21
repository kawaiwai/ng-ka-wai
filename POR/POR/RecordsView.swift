import SwiftUI

struct ParkRecord: Codable, Identifiable {
    var id = UUID().uuidString
    var title: String
    var content: String

    static func json(records: [ParkRecord]) -> String {
        do {
            let data = try JSONEncoder().encode(records)
            let string = String(data: data, encoding: .utf8)
            return string ?? "[]"
        } catch {
            print("Error encoding records: \(error)")
        }
        return "[]"
    }

    static func get(string: String) -> [ParkRecord] {
        do {
            if let data = string.data(using: .utf8) {
                let records = try JSONDecoder().decode([ParkRecord].self, from: data)
                return records
            }
        } catch {
            print("Error decoding records: \(error)")
        }
        return []
    }
}

struct RecordsView: View {
    @AppStorage("records") var recordJSON: String = ""
    @State var records: [ParkRecord] = []
    @State var title: String = ""
    @State var content: String = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Date", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Place", text: $content)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        addRecord()
                    }) {
                        Label("", systemImage: "plus")
                    }
                    .padding()
                }
                .padding()

                List {
                    ForEach(records) { record in
                        VStack(alignment: .leading) {
                            Text(record.title)
                                .font(.headline)
                                .foregroundColor(.green)
                            Text(record.content)
                        }
                        .padding(5)
                    }
                    .onDelete(perform: deleteRecord)
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("Hit the Park Records")
                
            }
        }
        .onAppear {
            self.records = ParkRecord.get(string: recordJSON)
        }
    }

    func addRecord() {
        guard !title.isEmpty && !content.isEmpty else { return }

        records.append(ParkRecord(title: title, content: content))
        title = ""
        content = ""
        save()
    }

    func deleteRecord(at offsets: IndexSet) {
        records.remove(atOffsets: offsets)
        save()
    }

    func save() {
        self.recordJSON = ParkRecord.json(records: self.records)
    }
}

struct RecordsView_Preview: PreviewProvider {
    static var previews: some View {
        RecordsView()
    }
}
