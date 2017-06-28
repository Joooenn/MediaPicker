//
//  VideoPlayViewController.swift
//  UIImagePickerControllerDemo
//
//  Created by liangzc on 2017/6/28.
//  Copyright © 2017年 xlb. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayViewController: UIViewController {
    
    var videoUrl : URL?
    
    lazy var player : AVPlayer = {
        
        let playerItem = AVPlayerItem(url: self.videoUrl!)
        let player = AVPlayer(playerItem: playerItem)
        
        return player
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.setupViews()
        self.player.play()
    }
    
    func setupViews() {
        
        let playView = UIView.init(frame: CGRect.init(x: 0, y: 100, width: self.view.frame.size.width, height: 300))
        playView.backgroundColor = UIColor.lightGray
        self.view.addSubview(playView)
        
        let playerLayer = AVPlayerLayer.init(player: self.player)
        playView.layer.addSublayer(playerLayer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
