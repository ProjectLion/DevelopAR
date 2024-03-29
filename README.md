# DevelopAR
使用Swift开发一些ARKit的demo。

ARKit 简单的介绍:
---------------
* 苹果提供的渲染引擎： SceneKit、Metal、OpenGL、U3D、UE4
* SceneKit所使用的坐标系是右手坐标系
* 在SceneKit中我们用SCNVector3创建一个三维坐标点
* SceneKit中的SCNScene和SCNNode: 在SceneKit中，SCNCamera摄像头，SCNScene表示场景，每个场景中可以包含多个SCNNode，在指定的坐标系下每个node都有唯一的坐标。
* 本地坐标和世界坐标的区别:
* 以根节点为原点创建的三维坐标系称为世界坐标
* 以非根节点为原点创建的三维坐标系称为本地坐标

虚拟世界涉及到的三个核心类: SCNScene(场景类)、SCNNode(节点类)、SCNCamera(相机类)
------------------------------------------------------------------------

* SCNScene：场景。通俗的讲就是包含(也可不包含)有模型的虚拟环境，每个场景在初始化时默认生成一个根节点rootNode。

* SCNNode：节点。一个节点可以包含多个子节点，子节点的坐标系参照的父节点的坐标系，所以是本地坐标。打个比方：剧组在拍电影时，每个出现在相机画面中的演员都称作一个节点，而演员身体的每个肢体部分又是身体的子节点。一个模型可以通俗的看做一个节点，而一个模型有可能是由多个模型组成的。

* SCNCamera：相机。它是我们的设备(手机、iPad)捕捉到的画面。

现实世界涉及到的三个核心类: ARSession、ARFrame、ARCamera。
----------------------------------------------------

* ARSession: 用于管理和配置整个AR体验，从设备的运动传感器读取数据，控制摄设备内置摄像头，利用AVCaptureSession捕获实时的图像，对捕获到的图像进行分析，并对外输出ARFrame实例，综合运动数据和图像分析结果，建立起真实世界和虚拟世界的对应关系
* ARFrame: 是带有位置追踪信息的视频图像，正在运行的AR session会不断捕捉设备摄像头的视频帧，对于每一帧，ARKit都会结合来自设备运动传感硬件的数据进行分析，以估算设备的实际位置，ARKit通过ARFrame向外传递当前帧的位置信息和图像参数
* ARCamera: 用于捕捉现实世界的画面，利用算法分析设备的运动状态和周围环境的变化

* ARPlaneAnchor: 在世界追踪的AR session 中，一个ARPlaneAnchor对象表示在真实世界中，一个平面的位置和方向信息
* ARAnchor: 锚点表示真实世界的位置和方向，为AR场景中放置虚拟物体提供位置信息
