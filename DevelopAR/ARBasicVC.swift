//
//  ARBasicVC.swift
//  DevelopAR
//
//  Created by Mac on 2019/6/28.
//  Copyright © 2019 Ht. All rights reserved.
//

import UIKit
import ARKit

public let screen_W = UIScreen.main.bounds.width
public let screen_H = UIScreen.main.bounds.height

class ARBasicVC: UIViewController {
    
    var scnView = ARSCNView(frame: UIScreen.main.bounds)
    var backBtn = UIButton(frame: CGRect(x: 22, y: 64, width: 44, height: 30))
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.setTitle("back", for: .normal)
        backBtn.addTarget(self, action: #selector(backAction(_:)), for: .touchUpInside)
        navigationController?.navigationBar.isHidden = true
        view.addSubview(scnView)
        view.addSubview(backBtn)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        scnView.session.pause()
    }
    
    @objc func backAction(_ sender: UIButton) {
        if navigationController != nil {
            navigationController?.popViewController(animated: true)
        }
    }
    
}
