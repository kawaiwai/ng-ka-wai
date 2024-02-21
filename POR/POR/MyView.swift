//
//  MyView.swift
//  PORApp
//
//  Created by ituser on 1/31/24.
//

import SwiftUI

struct MyView: View {
var person: Person // Assuming you have a Person model
 
 var body: some View {
     VStack(spacing: 20) {
         Image(systemName: "person")
             .font(.system(size: 100))
             .foregroundColor(.blue)
         
         Text(person.name)
             .font(.title)
             .fontWeight(.bold)
         
         Text("Age: \(person.age)")
             .font(.subheadline)
         
         Text("Email: \(person.email)")
             .font(.subheadline)
         
         Spacer()
     }
     .padding()
     .navigationBarTitle("Account Details")
 }
}

struct MyView_Preview: PreviewProvider {
 static var previews: some View {
     let person = Person(name: "John Doe", age: 30, email: "johndoe@example.com")
     return MyView(person: person)
     MyView()
 }
}
