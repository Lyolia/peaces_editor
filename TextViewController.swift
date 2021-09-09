//
//  TextViewController.swift
//  face-app
//
//  Created by Aliona Kostenko on 09.07.2021.
//

import UIKit

class TextViewController: UIViewController {
    @IBOutlet weak var headerV: MainHeader!
    var photo: UIImage!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var addPhotoBtn: UIButton!
    @IBOutlet weak var text: UITextField!
    
    var coordinator: TextMoveable?
    
    private var _inputTextView: TextView?

    var selectedTextView: TextView? {
        get { return _inputTextView }
        set {
            // if other sticker choosed then resign the handler
            if _inputTextView != newValue {
                if let inputTextView = _inputTextView {
                    inputTextView.showEditingHandlers = false
                }
                _inputTextView = newValue
            }
            // assign handler to new sticker added
            if let inputTextView = _inputTextView {
                inputTextView.showEditingHandlers = true
                inputTextView.superview?.bringSubviewToFront(inputTextView)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerV.textHeader.text = EditorHeader.text.title
        headerV.doneHeader.setTitle(EditorHeader.text.done, for: .normal)
        headerV.cancelHeader.setTitle(EditorHeader.text.cancel, for: .normal)
//        imgView.image = photo
        imgView.image = ImgVersionControl.sharedVC.imgEditVersions.last
        addPhotoBtn.layer.cornerRadius = 10
        NotificationCenter.default.addObserver(self, selector: #selector(dismissText), name: Notification.Name("dismissText"), object: nil)
        text.isHidden = true

        // Do any additional setup after loading the view.
    }
    @IBAction func addText(_ sender: Any) {
//        guard let cell = sampleTextField as? TextAdd else {return}
//       let sampleTextField =  UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
//            sampleTextField.placeholder = "Enter text here"
//            sampleTextField.font = UIFont.systemFont(ofSize: 15)
//            sampleTextField.borderStyle = UITextField.BorderStyle.roundedRect
//            sampleTextField.autocorrectionType = UITextAutocorrectionType.no
//            sampleTextField.keyboardType = UIKeyboardType.default
//            sampleTextField.returnKeyType = UIReturnKeyType.done
//            sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
//            sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
////            sampleTextField.delegate = self
//            self.view.addSubview(sampleTextField)
//        sampleTextField.inputAccessoryView = Bundle.main.loadNibNamed("KeyboardBTN", owner: self, options: nil)?.first as! UIView?
//        text.isHidden = false
        toControlTextView()
//        toControlTextView(cell: (sampleTextField as? TextAdd)!)
//        selectedStickerView?.showEditingHandlers = false
//
//        if self.imgView.subviews.filter({$0.tag == 999}).count > 0 {
//
//            let image = imgView.asImage()
//            self.imgView.image = image
//            }
//        imgView.image = defaultPhotoEditView.image
    }
    @IBAction func dis(_ sender: Any) {
        let photoEditView = TextViewController(nibName: "TextViewController", bundle: nil)
                photoEditView.modalPresentationStyle = .fullScreen
        ////        photoEditView.photo = i
                self.dismiss(animated: true, completion: nil)
    }
    @objc func dismissText(notification: NSNotification) {
        selectedTextView?.showEditingHandlers = false
        if self.imgView.subviews.filter({$0.tag == 999}).count > 0 {
            print("Ki")

            let image = imgView.asImage()
            self.imgView.image = image

            ImgVersionControl.sharedVC.toSaveImgLastChanges(img: image)
            }
        else{
            print("Bye")
        }
//        let photoEditView = TextViewController(nibName: "TextViewController", bundle: nil)
//        photoEditView.modalPresentationStyle = .fullScreen
////        photoEditView.photo = i
//        self.dismiss(animated: true, completion: nil)
       }
}

extension TextViewController: TextViewDelegate {

    func TextViewDidTap(_ stickerView: TextView) {
        self.selectedTextView = stickerView
    }

    func TextViewDidBeginMoving(_ stickerView: TextView) {
        self.selectedTextView = stickerView
    }

    func TextViewDidChangeMoving(_ stickerView: TextView) {
        
    }

    func TextViewDidEndMoving(_ stickerView: TextView) {
        
    }

    func TextViewDidBeginRotating(_ stickerView: TextView) {
        
    }

    func TextViewDidChangeRotating(_ stickerView: TextView) {
        
    }

    func TextViewDidEndRotating(_ stickerView: TextView) {
        
    }
    
    func TextViewDidClose(_ stickerView: TextView) {
        
    }
}

extension TextViewController {
    
    func toControlTextView() {
        
        
        let testImage = UITextField(frame: CGRect.init(x: 0, y: 0, width: 100, height: 40))
        testImage.placeholder = "HIII"
//        testImage.font = UIFont.systemFont(ofSize: 15)
//        testImage.borderStyle = UITextField.BorderStyle.roundedRect
//        testImage.autocorrectionType = UITextAutocorrectionType.no
//        testImage.keyboardType = UIKeyboardType.default
//        testImage.returnKeyType = UIReturnKeyType.done
//        testImage.clearButtonMode = UITextField.ViewMode.whileEditing
//        testImage.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        testImage.inputAccessoryView = Bundle.main.loadNibNamed("KeyboardBTN", owner: self, options: nil)?.first as! UIView?
            testImage.contentMode = .scaleAspectFill
            let textView3 = TextView.init(contentView: testImage)
            textView3.center = CGPoint.init(x: 150, y: 150)
            textView3.delegate = self
            textView3.setImage(UIImage.init(named: "Close")!, forHandler: TextViewHandler.close)
            textView3.setImage(UIImage.init(named: "Rotate")!, forHandler: TextViewHandler.rotate)
            textView3.setImage(UIImage.init(named: "Move")!, forHandler: TextViewHandler.flip)
            textView3.showEditingHandlers = false
            textView3.tag = 999

            self.imgView.addSubview(textView3)
            self.selectedTextView = textView3
        
    }
}
