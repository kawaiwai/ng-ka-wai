import SwiftUI

struct ContentView: View {
    @StateObject var model = BiometricModel()
    @State var showAppPage : Bool = false
    var body: some View {
        NavigationStack {
        VStack(spacing: 50) {
            Image("park")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            Text("Hit The Park App")
                .font(.title)
                .font(.system(size: 42, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                    
            Text("You can click to the Icon Below for Face ID Login to the app.")
                .padding()
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)

            if model.isError == true {
                Text("\(model.errorMessage)")
            }
            Button(action: {
                model.evaluatePolicy()
            }, label: {
                Image(systemName: "faceid")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
            }).padding()
        }
        //show the main view of the app
        .fullScreenCover(isPresented: $showAppPage, content: {
            MainView()
        })
        .padding()
        .onAppear {
            model.checkPolicy()
        }
        .onChange(of: model.isAuthenicated) {
            newValue in
            showAppPage = model.isAuthenicated
        }
    }
}
}

struct ContentView_Preview : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
