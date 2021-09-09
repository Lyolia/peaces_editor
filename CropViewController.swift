//
//  CropViewController.swift
//  face-app
//
//  Created by Aliona Kostenko on 08.07.2021.
//

import UIKit

class CropViewController: UIViewController {
    @IBOutlet weak var headerV: MainHeader!
    @IBOutlet weak var imgView: UIImageView!
    var photo: UIImage!
    var customCrop = CropCustomView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerV.textHeader.text = EditorHeader.crop.title
        headerV.doneHeader.setTitle(EditorHeader.crop.done, for: .normal)
        headerV.cancelHeader.setTitle(EditorHeader.crop.cancel, for: .normal)
        NotificationCenter.default.addObserver(self, selector: #selector(dismissCrop), name: Notification.Name("dismissCrop"), object: nil)
//        imgView.image = photo
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let editView = CropCustomView(frame: self.view.frame)
        let image = photo
        editView.initWithImage(image: image!)
        
//        _ = editView.getCroppedImage()
        
        
        self.view.addSubview(editView)
        self.view.backgroundColor = UIColor.clear
    }
    
    @objc func dismissCrop(notification: NSNotification) {
        let photoEditView = CropViewController(nibName: "CropViewController", bundle: nil)
        photoEditView.modalPresentationStyle = .fullScreen
//        photoEditView.photo = i
        self.dismiss(animated: true, completion: nil)
       }
    
    func initButton() {
        headerV.doneHeader.addTarget(self, action: #selector(customCrop.acceptButtonAction), for: .touchUpInside)
    }
}
