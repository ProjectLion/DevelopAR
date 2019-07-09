//
//  ModelAnimate.swift
//  DevelopAR
//
//  Created by Mac on 2019/7/4.
//  Copyright © 2019 Ht. All rights reserved.
//

import UIKit
import ARKit

class ModelAnimate: ARBasicVC {

    var htNode: SCNNode!
    
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
        config.planeDetection = []
        
        scnView.session.run(config)
        
        scnView.scene = SCNScene()
        
        scnView.delegate = self
        
        // 添加一个点击手势，用于节点模型介绍
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(tap:)))
        scnView.addGestureRecognizer(tap)
        
        // 添加一个缩放手势，用于模型展开收缩
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchAction(pinch:)))
        scnView.addGestureRecognizer(pinch)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func tapAction(tap: UITapGestureRecognizer) {
        let point = tap.location(in: scnView)            // 获取到手势在scnview上的位置
        
        let arr = scnView.hitTest(point, options: nil)
        
        if !arr.isEmpty {           // 不为空则表示点在模型上了
            guard let firstNode = arr.first?.node else { print("未找到对应的模型"); return }
            print(firstNode.name ?? "")
            switch firstNode.name ?? "" {
            case "left1":
                break
            case "left2":
                break
            case "left3":
                break
            case "right1":
                break
            case "right2":
                break
            case "right3":
                break
            default:
                break
            }
        } else {        // 否则是点在空白处
            
        }
        
    }
    
    @objc func pinchAction(pinch: UIPinchGestureRecognizer) {
        
        switch pinch.state {
        case .began:
            break
        case .changed:
            break
        case .cancelled, .ended:
            if pinch.velocity > 5 {
                print("放大")
                openAnima()
            } else if pinch.velocity < -2 {
                print("收缩")
                closeAnima()
            }
        default:
            break
        }
        
    }
    
    private func closeAnima() {
        for item in htNode.childNodes.first!.childNodes {
            switch item.name ?? "" {
            case "left1":
                item.addAnimation(creatAnima(from: -6, to: 0), forKey: "\(item.name ?? "")close")
            case "left2":
                item.addAnimation(creatAnima(from: -3.5, to: 0), forKey: "\(item.name ?? "")close")
            case "left3":
                item.addAnimation(creatAnima(from: -1, to: 0), forKey: "\(item.name ?? "")close")
            case "right1":
                item.addAnimation(creatAnima(from: 6, to: 0), forKey: "\(item.name ?? "")close")
            case "right2":
                item.addAnimation(creatAnima(from: 3.5, to: 0), forKey: "\(item.name ?? "")close")
            case "right3":
                item.addAnimation(creatAnima(from: 1, to: 0), forKey: "\(item.name ?? "")close")
            case "X", "centerTop":
                item.addAnimation(creatAnima(path: "position.y", from: 6, to: 0), forKey: "\(item.name ?? "")close")
            case "centerBottom":
                item.addAnimation(creatAnima(path: "position.y", from: -3, to: 0), forKey: "\(item.name ?? "")close")
            default:
                break
            }
        }
    }
    
    private func openAnima() {
        for item in htNode.childNodes.first!.childNodes {
            switch item.name ?? "" {
            case "left1":
                item.addAnimation(creatAnima(from: 0, to: -6), forKey: "\(item.name ?? "")open")
            case "left2":
                item.addAnimation(creatAnima(from: 0, to: -3.5), forKey: "\(item.name ?? "")open")
            case "left3":
                item.addAnimation(creatAnima(from: 0, to: -1), forKey: "\(item.name ?? "")open")
            case "right1":
                item.addAnimation(creatAnima(from: 0, to: 6), forKey: "\(item.name ?? "")open")
            case "right2":
                item.addAnimation(creatAnima(from: 0, to: 3.5), forKey: "\(item.name ?? "")open")
            case "right3":
                item.addAnimation(creatAnima(from: 0, to: 1), forKey: "\(item.name ?? "")open")
            case "X", "centerTop":
                item.addAnimation(creatAnima(path: "position.y", from: 0, to: 6), forKey: "\(item.name ?? "")open")
            case "centerBottom":
                item.addAnimation(creatAnima(path: "position.y", from: 0, to: -3), forKey: "\(item.name ?? "")open")
            default:
                break
            }
        }
    }
    
    private func creatAnima(path: String = "position.x", from: Any, to: Any) -> CABasicAnimation {
        let anima = CABasicAnimation(keyPath: path)
        anima.duration = 1.35
        anima.fillMode = .forwards
        anima.repeatCount = 1
        anima.isRemovedOnCompletion = false
        anima.fromValue = from
        anima.toValue = to
        anima.delegate = self
        return anima
    }
    
    private func scaleAnimate() {
        let anima = CABasicAnimation(keyPath: "scale")
        anima.toValue = SCNVector3(0.05, 0.05, 0.05)
        anima.fromValue = SCNVector3(0, 0, 0)
        anima.duration = 1.35
        anima.fillMode = .forwards
        anima.repeatCount = 1
        anima.isRemovedOnCompletion = false
        htNode.childNodes.first?.addAnimation(anima, forKey: "model scale")
    }
    
}

extension ModelAnimate: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let objAnchor = anchor as? ARObjectAnchor {
            print("识别到名为: \(objAnchor.name ?? "空空空") 的物体")
            
            let size = objAnchor.referenceObject.extent
            
            let box = SCNBox(width: CGFloat(size.x), height: CGFloat(size.y), length: CGFloat(size.z), chamferRadius: 0)
            let boxNode = SCNNode(geometry: box)
            boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.clear
            boxNode.geometry?.firstMaterial?.transparency = 0
//            node.addChildNode(boxNode)
            
            guard let ht = SCNScene(named: "art.scnassets/HT.scn") else { print("未找到模型文件"); return }
            
            htNode = ht.rootNode
//            htNode.position = node.convertPosition(SCNVector3(0, size.y + 0.2, 0), to: scnView.scene.rootNode)
            htNode.position = SCNVector3(0, size.y + 0.2, 0)
            
//            scnView.scene.rootNode.addChildNode(htNode)
            node.addChildNode(htNode)
        } else {
            print("不是物体")
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willUpdate node: SCNNode, for anchor: ARAnchor) {
        if let obj = anchor as? ARObjectAnchor {
            htNode.position = SCNVector3(CGFloat(obj.referenceObject.center.x), CGFloat(obj.referenceObject.center.y + 0.2), CGFloat(obj.referenceObject.center.z))
        }
    }
    
}

extension ModelAnimate: CAAnimationDelegate {
    
    func animationDidStart(_ anim: CAAnimation) {
        print(anim)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print(anim)
    }
    
}
