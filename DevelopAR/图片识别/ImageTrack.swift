//
//  ImageTrack.swift
//  DevelopAR
//
//  Created by Mac on 2019/6/28.
//  Copyright © 2019 Ht. All rights reserved.
//

import UIKit
import ARKit

/// 测试时可在Assetes.xcassets资源组中的ImageTrackSources中右键相应的图片show in finder，查看大图后进行扫描识别
class ImageTrack: ARBasicVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        let config = ARImageTrackingConfiguration()
        
        // 下面参数中的groupName是Assets.xcassets资源管理中的AR资源文件夹名字
        // 默认是没有的，点击Assets.xcassets文件，new 一个 AR Resource Group
        guard let referenceImgs = ARReferenceImage.referenceImages(inGroupNamed: "ImageTrackSources", bundle: nil) else { assert(false, "未找到识别图资源") }
        
        /// 从服务器加载识别图资源包可通过自定义Bundle的方式进行，将Bundle包下载解压后加载识别图资源
//        let path = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("ImgTrakingSource.Bundle")
//        let bundle = Bundle(url: path)
//        bundle?.load()
//        print(path)
//        guard let referenceImgs = ARReferenceImage.referenceImages(inGroupNamed: "Imgs", bundle: bundle) else { assert(false, "未找到识别图资源") }
        
        // 也可以通过下面的方式生成单个 ARReferenceImage，然后设置
        //        ARReferenceImage(<#T##image: CGImage##CGImage#>, orientation: <#T##CGImagePropertyOrientation#>, physicalWidth: <#T##CGFloat#>)
        
        config.trackingImages = referenceImgs
        
        scnView.session.run(config)
        
        scnView.scene = SCNScene()
        
        scnView.delegate = self
        // Do any additional setup after loading the view.
    }
    
}

extension ImageTrack: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let imgAnchor = anchor as? ARImageAnchor {
            print("图片大小: \(imgAnchor.referenceImage.physicalSize)")
            let plane = SCNPlane(width: imgAnchor.referenceImage.physicalSize.width, height: imgAnchor.referenceImage.physicalSize.height)
            plane.materials.first?.diffuse.contents = UIColor.red
            let planeNode = SCNNode(geometry: plane)
            planeNode.transform = SCNMatrix4MakeRotation(-(Float.pi / 2), 1, 0, 0)
            node.addChildNode(planeNode)
        } else {
            print("不是图片")
        }
    }
}
