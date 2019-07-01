//
//  ObjectTrack.swift
//  DevelopAR
//
//  Created by Mac on 2019/6/28.
//  Copyright © 2019 Ht. All rights reserved.
//

import UIKit
import ARKit

/// 在测物体识别的时候请替换 or 添加你自己的识别体资源文件。在Assets.xcassets资源组中的ObjectTrakSources中
/// 因为我demo里的物体你没有
class ObjectTrack: ARBasicVC {
    
    var boxNode: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = ARWorldTrackingConfiguration()
        
        // 下面参数中的groupName是Assets.xcassets资源管理中的AR资源文件夹名字
        // 默认是没有的，点击Assets.xcassets文件，new 一个 AR Resource Group
        guard let referenceImgs = ARReferenceObject.referenceObjects(inGroupNamed: "ObjectTrackSources", bundle: nil) else { assert(false, "未找到物体识别资源") }
        
        // 也可以通过下面的方式生成单个 ARReferenceObject，然后设置
//        ARReferenceObject(archiveURL: <#T##URL#>) throw
        
        config.detectionObjects = referenceImgs
        // 可以在识别物体的同时增加平面识别，只需在代理方法里根据回调给的锚点类型判断
        config.planeDetection = .horizontal
        
        scnView.session.run(config)
        
        scnView.scene = SCNScene()
        
        scnView.delegate = self
        
        // Do any additional setup after loading the view.
    }
}

extension ObjectTrack: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let objAnchor = anchor as? ARObjectAnchor {
            print("识别到名为: \(objAnchor.name ?? "空空空") 的物体")
            let objSize = objAnchor.referenceObject.extent
            // 生成一个box
            let box = SCNBox(width: CGFloat(objSize.x), height: CGFloat(objSize.y), length: CGFloat(objSize.z), chamferRadius: 0)
            box.materials.first?.diffuse.contents = UIColor.red
            
            boxNode = SCNNode(geometry: box)
            
            node.addChildNode(boxNode)
        } else {
            print("不是物体")
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willUpdate node: SCNNode, for anchor: ARAnchor) {
        if let obj = anchor as? ARObjectAnchor {
            boxNode.position = SCNVector3(obj.referenceObject.center.x, obj.referenceObject.center.y, obj.referenceObject.center.z)
        }
    }
    
}
