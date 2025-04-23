import SwiftUI
// import FamilyControls

struct ContentView: View {
    // @StateObject var viewModel = AppSelectionViewModel()
    // @State private var isPickerPresented = false

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "globe")
                .font(.system(size: 40))
            Text("Hello, Keeper!")
                .font(.title)
                .bold()

            Button(action: {
                // viewModel.requestAuthorization()
                // isPickerPresented = true
                print("Get Started tapped")
            }) {
                Text("Get Started")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
    }

            Spacer()
        }
        // .familyActivityPicker(
        //     isPresented: $isPickerPresented,
        //     selection: $viewModel.selection
        // )
    }
}
