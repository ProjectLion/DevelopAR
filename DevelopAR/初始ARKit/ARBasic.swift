//
//  ARBasic.swift
//  DevelopAR
//
//  Created by Mac on 2019/6/28.
//  Copyright © 2019 Ht. All rights reserved.
//

import UIKit
import ARKit

class ARBasic: ARBasicVC {
    
    // 人物模型节点
    var bodyNode: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 给scnView一个空的场景，然后后续我们就能在场景里添加节点(模型)了
        scnView.scene = SCNScene()
        
        // 从资源文件中加载一个场景，去该场景的根节点，就是我们要的模型了，我们并不适用下面的场景作为scnView的基础场景，不方便控制，我们只取它的模型
        guard let scn = SCNScene(named: "art.scnassets/idleFixed.scn") else {
            print("未找到模型文件")
            return
        }
        bodyNode = scn.rootNode     // 取到模型
        
        // 右手坐标系。
        // +x: 在用户的右边，-x: 在用户的左边
        // +y: 在用户的上方，-y: 在用户的下方
        // +z: 在用户的后方，-z: 在用户的前方
        // 在ARKit里单位是米
        // 如果模型的定位点不在模型的中心点则会出现偏移。一般人物模型的定位点都在人体中心正下方双脚中间。
        bodyNode.position = SCNVector3(0, 0, -1)            // 用户正前方1米处
        
        bodyNode.scale = SCNVector3(0.2, 0.2, 0.2)          // 模型的缩放系数
        
        // 添加到scnView的场景中
        scnView.scene.rootNode.addChildNode(bodyNode)
        
        // 新建一个相机追踪配置信息。它们分别有:
        // ARWorldTrackingConfiguration，世界追踪。常用于追踪水平面、垂直平面、物体识别。
        // ARFaceTrackingConfiguration，面部识别。
        // ARImageTrackingConfiguration，图片识别。
        // AROrientationTrackingConfiguration，方向追踪。
        let config = ARWorldTrackingConfiguration()
        // 不配置追踪的话相机画面是黑的。因为要通过这个类去采集分析相机画面
        scnView.session.run(config, options: .resetTracking)
        
        // Do any additional setup after loading the view.
    }

}
