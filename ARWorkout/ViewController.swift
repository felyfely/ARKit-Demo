//
//  ViewController.swift
//  ARWorkout
//
//  Created by 付 旦 on 7/23/17.
//  Copyright © 2017 付 旦. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit

class ViewController: UIViewController, ARSKViewDelegate {
    
    @IBOutlet var sceneView: ARSKView!
    var bear : SKSpriteNode!
    var bearWalkingFrames : [SKTexture]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        
        // Load the SKScene from 'Scene.sks'
        if let scene = SKScene(fileNamed: "Scene") {
            sceneView.presentScene(scene)
        }
        
        let bearAnimatedAtlas = SKTextureAtlas(named: "ReverseLunge")
        var walkFrames = [SKTexture]()
        
        let numImages = bearAnimatedAtlas.textureNames.count
        let base = 2706
        let end = 3317
        for i in base ... end {
            let bearTextureName = "AR Test 2_0\(i)"
            let texture = SKTexture(imageNamed: bearTextureName)
            walkFrames.append(texture)
        }
        
        bearWalkingFrames = walkFrames
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    // MARK: - ARSKViewDelegate
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        // Create and configure a node for the anchor added to the view's session.
        
        let firstFrame = bearWalkingFrames[0]
        bear = SKSpriteNode(texture: firstFrame)
        let action = SKAction.repeatForever(SKAction.animate(with: bearWalkingFrames, timePerFrame: 0.0333333333))
        bear.run(action)
        return bear
        
        
        let labelNode = SKLabelNode(text: "👾")
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        return labelNode;
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
