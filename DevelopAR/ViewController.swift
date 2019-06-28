//
//  ViewController.swift
//  DevelopAR
//
//  Created by Mac on 2019/6/28.
//  Copyright © 2019 Ht. All rights reserved.
//

import UIKit

fileprivate let tableData = ["初始ARKit", "加载自定义的dae模型文件", "平面识别", "图片识别", "物体识别", "动作捕捉", "遮挡", "控制模型中绑定的动画", "模型动画"]

class ViewController: UIViewController {
    
    var table = UITableView(frame: CGRect(x: 0, y: 0, width: screen_W, height: screen_H), style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(table)
        
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:         // 初识AR
            navigationController?.pushViewController(ARBasic(), animated: true)
        case 1:         // 加载dae
            navigationController?.pushViewController(LoadDae(), animated: true)
        case 2:         // 平面识别
            navigationController?.pushViewController(PlaneTrack(), animated: true)
        case 3:         // 图片识别
            navigationController?.pushViewController(ImageTrack(), animated: true)
        case 4:
            break
        case 5:
            break
        case 6:
            break
        case 7:
            break
        case 8:
            break
        case 9:
            break
        default:
            break
        }
    }
    
}
