//
//  PlaneTrack.swift
//  DevelopAR
//
//  Created by Mac on 2019/6/28.
//  Copyright © 2019 Ht. All rights reserved.
//

import UIKit
import ARKit

class PlaneTrack: ARBasicVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scnView.scene = SCNScene()
        
        let config = ARWorldTrackingConfiguration()
        // 配置追踪平面的类型，默认关闭平面追踪
        config.planeDetection = .horizontal         // 我们先检测水平面，想要检测垂直平面的coder可以修改为vertical
        scnView.session.run(config)
        
        // 下面两个代理均可收到 识别到平面的回调。
        //        scnView.session.delegate = self
        scnView.delegate = self
        
        // Do any additional setup after loading the view.
    }
}

extension PlaneTrack: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let planeAnchor = anchor as? ARPlaneAnchor {
            print("找到平面了")
            // 生成一个面
            let plane = SCNPlane(width: 1, height: 1)
            // 将面的材质修改为绿色
            plane.materials.first?.diffuse.contents = UIColor.green
            // 使用面生成一个节点
            let planeNode = SCNNode(geometry: plane)
            // 将这个面放到ARKit识别的面的中间
            planeNode.position = SCNVector3(planeAnchor.center.x, planeAnchor.center.y, planeAnchor.center.z)
            // 由于SceneKit自带的Plane默认是垂直方向的，所以我们给它旋转90°。如果是追踪的垂直平面就不用旋转
            planeNode.transform = SCNMatrix4MakeRotation(-(Float.pi / 2), 1, 0, 0)
            node.addChildNode(planeNode)
        }
    }
    
}
