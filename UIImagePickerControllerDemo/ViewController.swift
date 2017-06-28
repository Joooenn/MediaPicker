//
//  ViewController.swift
//  UIImagePickerControllerDemo
//
//  Created by liangzc on 2017/6/27.
//  Copyright © 2017年 xlb. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let kCellReuseIdentifier = "Cell"
    let titleArray = ["take a photo","take a video"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Picker"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellReuseIdentifier, for: indexPath)
        cell.textLabel!.text = titleArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var vc = UIViewController()
        switch indexPath.row {
        case 0:
            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TakePhotoViewController")
        case 1:
            vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TakeVideoViewController")
        default:
            break 
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

