//
//  TakePhotoViewController.swift
//  UIImagePickerControllerDemo
//
//  Created by liangzc on 2017/6/27.
//  Copyright © 2017年 xlb. All rights reserved.
//

import UIKit
import MobileCoreServices

class TakePhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
    }
    
    func setupViews() {
        
//        imageView.image = UIImage(named: "JPG")
        imageView.image = UIImage(named: "PNG")
        
        self.title = "photoPicker"
        self.view.backgroundColor = UIColor.white
        
        DispatchQueue.global().async {
            print(Thread.current)
            self.imagePicker.accessibilityFrame = CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: self.view.frame.size.height)
            self.imagePicker.delegate = self
            self.imagePicker.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            self.imagePicker.allowsEditing = true
            if PickerManager().isCameraAvailable(){
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                self.imagePicker.mediaTypes = [kUTTypeImage as String]
                self.imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.photo
                DispatchQueue.main.async {
                    print("camera初始化成功！")
                }
            } else {
                DispatchQueue.main.async {
                    print("设备不支持拍照！")
                }
            }
            
        }
    }
    
    @IBAction func takePhotoWithCamera(_ sender: UIButton) {
        
        if PickerManager().isCameraAvailable() {
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UIImagePickerViewControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let resultImage = info["UIImagePickerControllerEditedImage"] as? UIImage
        imageView.image = resultImage!
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

