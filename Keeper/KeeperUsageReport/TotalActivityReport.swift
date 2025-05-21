//
//  TotalActivityReport.swift — build‑able on iOS 17 SDK
//  KeeperUsageReport
//
//  REVISED 2025‑05‑21 — verified no compiler errors in clean project.
//
import DeviceActivity
import SwiftUI

// MARK: – Context key ---------------------------------------------------------

extension DeviceActivityReport.Context {
    static let totalActivity = Self("Total Activity")
}

// MARK: – Shared helpers ------------------------------------------------------

private let appGroupID = "group.com.tannerflake.Keeper"

private func saveUsageToAppGroup(_ usage: [String : TimeInterval]) {
    guard let defaults = UserDefaults(suiteName: appGroupID) else { return }
    defaults.set(usage, forKey: "appUsageStats")
}

// MARK: – Report Scene --------------------------------------------------------

struct TotalActivityReport: DeviceActivityReportScene {
    let context: DeviceActivityReport.Context = .totalActivity
    let content: (String) -> TotalActivityView

    func makeConfiguration(
        representing data: DeviceActivityResults<DeviceActivityData>
    ) async -> String {

        for await datum in data {
            dump(datum) // Logs the contents to inspect structure in console
        }

        return "Logged DeviceActivityData contents"
    }
}
