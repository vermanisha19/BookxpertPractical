//
//  PDFViewController.swift
//  BookxpertPractical
//
//  Created by MACM13 on 14/04/25.
//


import UIKit
import PDFKit

class PDFDocumentViewController: UIViewController {
    
    @IBOutlet private weak var pdfSubView: UIView!
    
    var pdfURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pdfView = PDFView(frame: self.pdfSubView.bounds)
        pdfView.autoScales = true
        self.pdfSubView.addSubview(pdfView)
        
        if let pdfURL, let document = PDFDocument(url: pdfURL) {
            pdfView.document = document
        }
    }
    
    @IBAction func tappedOnCloseBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
