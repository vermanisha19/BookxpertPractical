//
//  APIHelper.swift
//  BookxpertPractical
//
//  Created by MACM13 on 15/04/25.
//


import Foundation

class HomeViewModel {
    
    var devices: [DeviceListDetails] = []
    
    func fetchDeviceData() async throws {
        do {
            let data: [DeviceModel] = try await APIHelper.shared.fetchAPIData(url: "https://api.restful-api.dev/objects")
            saveDeviceDetailsToCoreData(devices: data)
        } catch {
            throw error
        }
    }

    func saveDeviceDetailsToCoreData(devices: [DeviceModel]) {
        let context = CoreDataManager.shared.context

        for device in devices {
            let fetchRequest = DeviceListDetails.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", device.id)

            let data: DeviceListDetails
            if let existingDevice = try? context.fetch(fetchRequest).first {
                data = existingDevice
            } else {
                data = DeviceListDetails(context: context)
                data.id = Int64(device.id) ?? 0
            }

            data.name = device.name
            if let deviceData = device.data {
                data.deviceDescription = deviceData.description
                data.capacity = deviceData.dataCapacity ?? deviceData.capacity
                data.generation = deviceData.dataGeneration ?? deviceData.generation
                data.color = deviceData.dataColor ?? deviceData.color
                data.devicePrice = deviceData.price
            }
        }
        CoreDataManager.shared.saveContext()
    }

    
    func fetchDeviceInfoFromCoreData() {
        let fetchRequest = DeviceListDetails.fetchRequest()
        do {
            devices = try CoreDataManager.shared.context.fetch(fetchRequest).sorted { $0.id < $1.id }
        } catch {
            print("Failed to fetch user from Core Data: \(error)")
        }
    }
}
