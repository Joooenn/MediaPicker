//
//  PickerManager.swift
//  UIImagePickerControllerDemo
//
//  Created by liangzc on 2017/6/27.
//  Copyright © 2017年 xlb. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation

class PickerManager: NSObject {
    
    /**
     *  设备是否有摄像头
     */
    func isCameraAvailable() -> Bool {
        return UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    /**
     *  前置摄像头是否有效
     */
    func isFrontCameraAvailable() -> Bool {
        return UIImagePickerController.isCameraDeviceAvailable(.front)
    }
    
    /**
     *  后置摄像头是否有效
     */
    func isRearCameraAvailable() -> Bool {
        return UIImagePickerController.isCameraDeviceAvailable(.rear)
    }
    
    func cameraSupportsMedia(mediaType :String, sourceType :UIImagePickerControllerSourceType) -> Bool {
        
        let availableMediaTypes = UIImagePickerController.availableMediaTypes(for: sourceType)
        return availableMediaTypes!.contains(mediaType)
    }
    
    /**
     *  摄像头是否支持拍照
     */
    func doseCameraSupportTakingPhotos() -> Bool {
        return self.cameraSupportsMedia(mediaType: kUTTypeImage as String, sourceType: .camera)
    }
    
    /**
     *  摄像头是否支持录像
     */
    func doseCameraSupportShootingVideos() -> Bool {
        return self.cameraSupportsMedia(mediaType: kUTTypeMovie as String, sourceType: .camera)
    }
    
    /**
     *  相册是否可用
     */
    func isPhotoLibraryAvailable() -> Bool {
        return UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
    }
    
    /**
     *  是否可以在相册中选择图片
     */
    func canUserPickPhotosFromLibrary() -> Bool {
        return self.cameraSupportsMedia(mediaType: kUTTypeImage as String, sourceType: .photoLibrary)
    }
    
    /**
     *  是否可以在相册中选择视频
     */
    func canUserPickMovieFromLibrary() -> Bool {
        return self.cameraSupportsMedia(mediaType: kUTTypeMovie as String, sourceType: .photoLibrary)
    }
    
    /**
     *  获取视频第1帧
     */
    func videoPreviewImage(videoPath: URL) -> UIImage {
        
        let asset = AVURLAsset.init(url: videoPath)
        let generator = AVAssetImageGenerator.init(asset: asset)
        generator.appliesPreferredTrackTransform = true
        generator.requestedTimeToleranceAfter = kCMTimeZero
        generator.requestedTimeToleranceBefore = kCMTimeZero
        let time = CMTime.init(value: 0, timescale: 600)
        var actualTime: CMTime = CMTimeMake(0, 0)
        var result : UIImage = UIImage()
        do {
            let image : CGImage = try generator.copyCGImage(at: time, actualTime: &actualTime)
            result = UIImage.init(cgImage: image)
        } catch {
            print("获取失败！")
        }
        return result
    }
    
}

