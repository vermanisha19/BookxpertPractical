//
//  ViewController+Extension.swift
//  BookxpertPractical
//
//  Created by Nisha on 13/04/25.
//


import UIKit

extension UIViewController {
    
    func showToast(message: String, withDuration: Double = 1, font: UIFont = .systemFont(ofSize: 12)) {
        let toastContainer = UIView()
        toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastContainer.alpha = 0.0
        toastContainer.layer.cornerRadius = 20
        toastContainer.clipsToBounds = true
        
        let toastLabel = UILabel()
        toastLabel.textColor = .white
        toastLabel.textAlignment = .center
        toastLabel.font = font
        toastLabel.text = message
        toastLabel.numberOfLines = 0
        
        toastContainer.addSubview(toastLabel)
        self.view.addSubview(toastContainer)
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toastLabel.leadingAnchor.constraint(equalTo: toastContainer.leadingAnchor, constant: 10),
            toastLabel.trailingAnchor.constraint(equalTo: toastContainer.trailingAnchor, constant: -10),
            toastLabel.topAnchor.constraint(equalTo: toastContainer.topAnchor, constant: 10),
            toastLabel.bottomAnchor.constraint(equalTo: toastContainer.bottomAnchor, constant: -10),
            
            toastContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            toastContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),
            toastContainer.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            toastContainer.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.3, delay: withDuration, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0.0
            }, completion: { _ in
                toastContainer.removeFromSuperview()
            })
        })
    }
}
