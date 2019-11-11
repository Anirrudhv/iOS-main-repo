//
//  ViewController.swift
//  AR Ruler
//
//  Created by Anirudh V on 7/30/19.
//  Copyright © 2019 Anirrudh. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var dotnodes = [SCNNode]()
    var textnode = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if dotnodes.count >= 2{
            for dot in dotnodes{
                dot.removeFromParentNode()
            }
            dotnodes = [SCNNode]()
        }
        if let touchlocation = touches.first?.location(in: sceneView){
            let hitTestResults = sceneView.hitTest(touchlocation, types: .featurePoint)
            if let hitTestResult = hitTestResults.first{
                adddot(at: hitTestResult)
            }
        }
    }
    func adddot(at hitTestResult: ARHitTestResult){
        let dotGeo = SCNSphere(radius: 0.005)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red
        
        dotGeo.materials = [material]
        let dotnode = SCNNode(geometry: dotGeo)
        
        dotnode.position = SCNVector3(hitTestResult.worldTransform.columns.3.x, hitTestResult.worldTransform.columns.3.y, hitTestResult.worldTransform.columns.3.z)
        
        sceneView.scene.rootNode.addChildNode(dotnode)
        
        dotnodes.append(dotnode)
        
        if dotnodes.count >= 2 {
            calc()
        }
    }
    
    
    func calc(){
        let start = dotnodes[0]
        let end = dotnodes[1]
        let a = end.position.x - start.position.x
        let b = end.position.y - start.position.y
        let c = end.position.z - start.position.z
        
        let dist = sqrt(pow(a,2)+pow(b,2) + pow(c,2))
        
        updatetext(text: "\(abs(dist))",atposition: end.position)
    }
    
    func updatetext(text : String, atposition:SCNVector3){
        
        textnode.removeFromParentNode()
        
        let textGeo = SCNText(string: text, extrusionDepth: 1.0)
        
        textGeo.firstMaterial?.diffuse.contents = UIColor.red
        
        textnode = SCNNode(geometry: textGeo)
        
        textnode.position = SCNVector3(atposition.x, atposition.y+0.01, atposition.z)
        
        textnode.scale = SCNVector3(0.01, 0.01, 0.01)
        
        sceneView.scene.rootNode.addChildNode(textnode)
    }
}
