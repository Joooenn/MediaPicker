//
//  TakeVideoViewController.swift
//  UIImagePickerControllerDemo
//
//  Created by liangzc on 2017/6/27.
//  Copyright © 2017年 xlb. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation

class TakeVideoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    var resultUrl : URL! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupViews()
    }
    
    func setupViews() {
        
        self.title = "videoPicker"
        self.view.backgroundColor = UIColor.white
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(playVideo(videoUrl:)))
        self.imageView.addGestureRecognizer(tap)
        
        self.setupImagePicker()
    }
    
    func setupImagePicker() {
        
        DispatchQueue.global().async {
            
            if PickerManager().isCameraAvailable() && PickerManager().doseCameraSupportShootingVideos() {
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                self.imagePicker.mediaTypes = [kUTTypeMovie as String]
                self.imagePicker.delegate = self
                if PickerManager().isFrontCameraAvailable() {
                    self.imagePicker.cameraDevice = UIImagePickerControllerCameraDevice.front
                }
                self.imagePicker.videoQuality = UIImagePickerControllerQualityType.typeMedium
                self.imagePicker.videoMaximumDuration = 20
                self.imagePicker.allowsEditing = true
            }
            
            DispatchQueue.main.async {
                print("camera 初始化成功！")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takeVideo(_ sender: UIButton) {
        
        if PickerManager().isCameraAvailable() && PickerManager().doseCameraSupportShootingVideos() {
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func playVideo(videoUrl :URL) {
        
//        let playVC = VideoPlayViewController()
//        playVC.videoUrl = videoUrl
//        self.navigationController?.pushViewController(playVC, animated: true)
    }
    
    // MARK: - UIImagePickerViewControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print(info)
        self.resultUrl = info["UIImagePickerControllerMediaURL"] as! URL
        self.imageView.image = PickerManager().videoPreviewImage(videoPath: self.resultUrl)
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
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
