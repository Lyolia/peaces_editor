//
//  MainHeader.swift
//  face-app
//
//  Created by Aliona Kostenko on 02.07.2021.
//

import UIKit

enum EditorHeader: CaseIterable {
    case photoEditor
    case text
    case crop
    
    var title: String {
        switch self {
        case .photoEditor: return "Photo Editor"
        case .text: return "Add Text"
        case .crop: return "Crop"
        }
    }
    var cancel: String {
        switch self {
        case .photoEditor: return "Cancel"
        case .text: return "Cancel"
        case .crop: return "Cancel"
        }
    }
    var done: String {
        switch self {
        case .photoEditor: return "Done"
        case .text: return "Apply"
        case .crop: return "Apply"
        }
    }
}

class MainHeader: UIView {
    @IBOutlet weak var textHeader: UILabel!
    @IBOutlet weak var cancelHeader: UIButton!
    @IBOutlet weak var doneHeader: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        self.layer.shadowColor = #colorLiteral(red: 0.1180943921, green: 0.7880262733, blue: 0.8836199045, alpha: 0.3014279801)
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    @IBAction func dismissProtoEditor(_ sender: Any) {
        if textHeader.text == EditorHeader.photoEditor.title {
            NotificationCenter.default.post(name: Notification.Name("dismissProtoEditor"), object: nil)
        }
        if textHeader.text == EditorHeader.crop.title {
            NotificationCenter.default.post(name: Notification.Name("dismissCrop"), object: nil)
        }
        if textHeader.text == EditorHeader.text.title {
            NotificationCenter.default.post(name: Notification.Name("dismissText"), object: nil)
        }
    }
    func commonInit() {
        let viewFromXib = Bundle.main.loadNibNamed("MainHeader", owner: self, options: nil)! [0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
}
