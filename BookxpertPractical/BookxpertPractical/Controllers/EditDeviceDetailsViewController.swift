//
//  EditDeviceDetailsViewController.swift
//  BookxpertPractical
//
//  Created by MACM13 on 15/04/25.
//

import UIKit

class EditDeviceDetailsViewController: UIViewController {
    
    @IBOutlet private weak var deviceName: UITextField!
    @IBOutlet private weak var deviceDescription: UITextField!
    @IBOutlet private weak var deviceColor: UITextField!
    @IBOutlet private weak var devicePrice: UITextField!
    @IBOutlet private weak var deviceCapacity: UITextField!
    @IBOutlet private weak var deviceGeneration: UITextField!
    
    var deviceDetails: DeviceListDetails?
    var updateDeviceDetails: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    private func setUpUI() {
        guard let deviceDetails else {
            showToast(message: "Something went wrong!! Data not passed.")
            return
        }
        deviceName.text = deviceDetails.name
        if let description = deviceDetails.deviceDescription {
            deviceDescription.text = description
        } else {
            deviceDescription.isHidden = true
        }
        
        if let color = deviceDetails.color {
            deviceColor.text = color
        } else {
            deviceColor.isHidden = true
        }
        
        if let price = deviceDetails.devicePrice {
            devicePrice.text = price
        } else {
            devicePrice.isHidden = true
        }
        
        if let capacity = deviceDetails.capacity {
            deviceCapacity.text = capacity
        } else {
            deviceCapacity.isHidden = true
        }
        if let generation = deviceDetails.generation {
            deviceGeneration.text = generation
        } else {
            deviceGeneration.isHidden = true
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        popViewController()
    }
    
    @IBAction func saveDetailsBtnTapped(_ sender: UIButton) {
        updateDetails()
        updateDeviceDetails?()
        popViewController()
    }
    
    private func updateDetails() {
        if let text = deviceName.text, !text.isEmpty {
            deviceDetails?.name = text
        }
        if let text = deviceDescription.text, !text.isEmpty {
            deviceDetails?.deviceDescription = text
        }
        if let text = deviceColor.text, !text.isEmpty {
            deviceDetails?.color = text
        }
        if let text = devicePrice.text, !text.isEmpty {
            deviceDetails?.devicePrice = text
        }
        if let text = deviceCapacity.text, !text.isEmpty {
            deviceDetails?.capacity = text
        }
        if let text = deviceGeneration.text, !text.isEmpty {
            deviceDetails?.generation = text
        }
    }
    
    private func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
