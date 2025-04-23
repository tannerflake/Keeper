import SwiftUI

struct AppSelectionView: View {
    @StateObject private var viewModel = AppSelectionViewModel()
    @State private var showingReview = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Select apps to monitor")) {
                    ForEach(viewModel.availableApps, id: \.self) { app in
                        HStack {
                            Image(systemName: "app.fill")
                                .foregroundColor(.blue)
                            
                            Text(app)
                            
                            Spacer()
                            
                            if viewModel.selectedApps.contains(app) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.blue)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.toggleApp(app)
                        }
                    }
                }
                
                Section {
                    Text("Selected apps: \(viewModel.selectedApps.count)")
                        .foregroundColor(.secondary)
                    
                    if !viewModel.selectedApps.isEmpty {
                        Button(action: {
                            showingReview = true
                        }) {
                            Text("Review Selection")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .navigationTitle("App Selection")
            .onAppear {
                viewModel.loadSelectedApps()
            }
            .sheet(isPresented: $showingReview) {
                AppSelectionReviewView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    AppSelectionView()
} 