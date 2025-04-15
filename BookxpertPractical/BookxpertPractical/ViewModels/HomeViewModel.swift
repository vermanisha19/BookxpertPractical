//
//  APIHelper.swift
//  BookxpertPractical
//
//  Created by MACM13 on 15/04/25.
//


import Foundation

class HomeViewModel {
    
    var devices: [DeviceModel] = []
    
    func fetchDeviceData() async throws {
        do {
            let data: [DeviceModel] = try await APIHelper.shared.fetchAPIData(url: "https://api.restful-api.dev/objects")
            self.devices = data
        } catch {
            throw error
        }
    }
}
