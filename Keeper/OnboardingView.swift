import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var currentPage = 0
    
    var body: some View {
        TabView(selection: $currentPage) {
            WelcomePage()
                .tag(0)
            
            PermissionsPage()
                .tag(1)
            
            NotificationPreferencesPage()
                .tag(2)
            
            AppSelectionIntroPage()
                .tag(3)
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .overlay(alignment: .bottom) {
            if currentPage == 3 {
                Button(action: {
                    hasCompletedOnboarding = true
                }) {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 20)
                }
            }
        }
    }
}

struct WelcomePage: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: "hourglass.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            Text("Welcome to Keeper")
                .font(.largeTitle)
                .bold()
            
            Text("Track and manage your app usage habits with precision. Focus on what matters most.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

struct PermissionsPage: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: "lock.shield.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            Text("App Usage Monitoring")
                .font(.title)
                .bold()
            
            Text("We'll request permission to monitor your app usage. This helps us track only the apps you care about.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

struct NotificationPreferencesPage: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: "bell.badge.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            Text("Reports")
                .font(.title)
                .bold()
            
            Text("Get weekly insights about your app usage. Choose between daily or weekly notifications.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

struct AppSelectionIntroPage: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: "app.badge.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            Text("Select Your Apps")
                .font(.title)
                .bold()
            
            Text("Choose which apps you want to track. We'll focus on monitoring these specific apps for you.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

#Preview {
    OnboardingView()
} 
