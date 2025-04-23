import SwiftUI

struct AppSelectionReviewView: View {
    @ObservedObject var viewModel: AppSelectionViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.green)
                        
                        Text("Apps Selected!")
                            .font(.title)
                            .bold()
                        
                        Text("We'll help you stay mindful of your time on these apps.")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.top)
                    
                    // Selected Apps List
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Your Selected Apps")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ForEach(Array(viewModel.selectedApps), id: \.self) { app in
                            HStack {
                                Image(systemName: "app.fill")
                                    .foregroundColor(.blue)
                                    .font(.title2)
                                    .frame(width: 30)
                                
                                Text(app)
                                    .font(.body)
                                
                                Spacer()
                                
                                Button(action: {
                                    viewModel.toggleApp(app)
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
                                }
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(10)
                            .shadow(radius: 1)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Motivational Message
                    VStack(spacing: 12) {
                        Text("Let's keep you focused this week 🔥")
                            .font(.headline)
                        
                        Text("You'll receive your first usage summary soon.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                    
                    // Continue Button
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGroupedBackground))
        }
    }
}

#Preview {
    AppSelectionReviewView(viewModel: AppSelectionViewModel())
} 