// import DeviceActivity
// import FamilyControls
// import ManagedSettings
import Foundation

// extension DeviceActivityName {
//     static let daily = Self("daily")
// }

class AppUsageMonitor {
    static let shared = AppUsageMonitor()
    // let monitor = DeviceActivityMonitor()

    private init() {}

    func startMonitoring(selectedApps: Any) {  // Changed parameter type to Any since FamilyActivitySelection isn't available
        // let schedule = DeviceActivitySchedule(
        //     intervalStart: DateComponents(hour: 0, minute: 0),
        //     intervalEnd: DateComponents(hour: 23, minute: 59),
        //     repeats: true
        // )

        // Task {
        //     do {
        //         try await AuthorizationCenter.shared.requestAuthorization(for: .individual)

        //         try monitor.startMonitoring(
        //             .daily,
        //             during: schedule,
        //             events: [],
        //             applications: selectedApps.applicationTokens
        //         )
        //         print("Started monitoring app usage.")
        //     } catch {
        //         print("Failed to start monitoring: \(error)")
        //     }
        // }
        print("Monitoring functionality disabled until Apple Developer Program enrollment is complete")
    }
}
