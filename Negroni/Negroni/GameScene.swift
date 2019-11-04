//
//  GameScene.swift
//  Negroni
//
//  Created by Marco Spina on 04/11/2019.
//  Copyright © 2019 Marco Spina. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player:SKSpriteNode?
    var floor:SKSpriteNode?

    
    let playerCategory:UInt32 = 0x1 << 0
    let groundCategory:UInt32 = 0x1 << 2
    
    //
    
    func ciao()
    {
        
    }
    
    func spawnPlayer() {
        player = SKSpriteNode(imageNamed: "player")
        player?.physicsBody = SKPhysicsBody(circleOfRadius: player!.size.width / 2)
        player?.physicsBody?.categoryBitMask = playerCategory
        player?.physicsBody?.collisionBitMask = groundCategory
        player?.size = CGSize(width: 81, height: 106)
        player?.anchorPoint = CGPoint(x: 0, y: 0)
        player?.position = CGPoint(x: size.width * 0.1, y: size.height * 0.2)
        addChild(player!)
    }
    
    func spawnFloor() {
        floor = self.childNode(withName: "floor") as? SKSpriteNode
        floor?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 736, height: 414))
        floor?.physicsBody?.categoryBitMask = groundCategory
        floor?.physicsBody?.collisionBitMask = playerCategory
        floor?.physicsBody?.affectedByGravity = false

    }
    
    func move(direction: Bool) {
        if direction == true {
        let moveAction = SKAction.moveBy(x: 3, y: 0, duration: 0.01)
        let repeatAction = SKAction.repeatForever(moveAction)
        player?.run(repeatAction)
        } //End IF
        
        else {
            let moveAction = SKAction.moveBy(x: -3, y: 0, duration: 0.01)
            let repeatAction = SKAction.repeatForever(moveAction)
            player?.run(repeatAction)
        } // End ELSE
    }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        spawnFloor()
        spawnPlayer()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.previousLocation(in: self)
            let node = self.nodes(at: location).first
            if node?.name == "right" {
                move(direction: true)
            } // End IF
          else if node?.name == "left" {
                move(direction: false)
            } // End ELSE
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
               player?.removeAllActions()
       
       }
       
       override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
           player?.removeAllActions()
       }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
