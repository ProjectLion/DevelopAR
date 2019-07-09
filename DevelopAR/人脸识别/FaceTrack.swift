//
//  FaceTrack.swift
//  DevelopAR
//
//  Created by Mac on 2019/6/28.
//  Copyright © 2019 Ht. All rights reserved.
//

import UIKit
import ARKit

class FaceTrack: ARBasicVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scnView.scene = SCNScene()
        
        let config = ARFaceTrackingConfiguration()
        // 最大识别脸的数量
        config.maximumNumberOfTrackedFaces = 5
        
        scnView.session.run(config)
        
        scnView.scene = SCNScene()
        
        scnView.delegate = self
        // 光照类型
        scnView.scene.rootNode.geometry?.materials.first?.lightingModel = .blinn
        
        // Do any additional setup after loading the view.
    }
}

extension FaceTrack: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let faceAnchor = anchor as? ARFaceAnchor {
//            print("识别到脸了\(faceAnchor.lookAtPoint)")
            // 左眼
            let leftEyes = faceAnchor.leftEyeTransform
            
            // 右眼
            let rightEyes = faceAnchor.rightEyeTransform
            // blendShapes 属性查看更多人脸各个部位的值
//            faceAnchor.blendShapes[.browInnerUp]
        } else {
            print("不是物体")
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let faceAnchor = anchor as? ARFaceAnchor {
            // 根据blendShapes属性获取面部各个器官变动的数据 0到1
            //
            print("舌头伸出: \(faceAnchor.blendShapes[.tongueOut])")
        } else {
            print("不是物体")
        }
    }
    
}
