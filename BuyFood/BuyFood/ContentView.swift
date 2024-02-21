

import SwiftUI

struct ContentView: View {
    @State var changeScreen = false
    var body: some View {
        NavigationStack{
            VStack(spacing:50){
                Image("icons8-grocery-100")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                Text("Online Buy food grocery")
                
                
                Button(){
                    changeScreen = true
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius:50)
                        Text("Get Started").foregroundColor(.white).bold()
                    }
                }.frame(width: 200, height: 70)
                    .foregroundColor(.purple)
                
            }.navigationDestination(isPresented: $changeScreen) {
                HomeSwiftUIView()
            }
        }
    }
}

#Preview {
    ContentView()
}
