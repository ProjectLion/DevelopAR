//
//  LoadDae.swift
//  DevelopAR
//
//  Created by Mac on 2019/6/28.
//  Copyright © 2019 Ht. All rights reserved.
//

import UIKit
import ARKit

class LoadDae: ARBasicVC {

    var myNode: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scnView.scene = SCNScene()
        
        guard let url = Bundle.main.url(forResource: "baozi", withExtension: ".dae") else {
            assert(false, "模型文件不存在")
        }
        
        do {
            // 可实现从服务器下载到指定文件夹，通过url来初始化模型
            let baoziScn = try SCNScene(url: url, options: nil)
            myNode = baoziScn.rootNode
            scnView.scene = SCNScene()
            
            let config = ARWorldTrackingConfiguration()
            scnView.session.run(config)
            // 将小花豹添加到识别到的平面上
            myNode.scale = SCNVector3(0.01, 0.01, 0.01)
            
            myNode.position = SCNVector3(0, 0, -1)      // 正前方1米处
            
            scnView.scene.rootNode.addChildNode(myNode)
        } catch {
            assert(false, "模型加载失败: \(error)")
        }
        
        // Do any additional setup after loading the view.
    }
}

