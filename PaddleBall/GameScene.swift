//
//  GameScene.swift
//  PaddleBall
//
//  Created by Bryan Mansell on 07/07/2018.
//  Copyright © 2018 Bryan Mansell. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var player = SKSpriteNode()
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        startGame()
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        player = self.childNode(withName: "player") as! SKSpriteNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 200, dy: 200))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        border.linearDamping = 0
        border.angularDamping = 0
        self.physicsBody = border

    }

    func startGame() {
        score = [0,0]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            player.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
        
    }
    
    func addScore(playerWhoWon: SKSpriteNode) {
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        if playerWhoWon == player {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 200, dy: 200))
        }
        else if playerWhoWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -200, dy: -200))
        }
        print(score)
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            player.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.6))
        
        if ball.position.y <= player.position.y - 70 {
            addScore(playerWhoWon: enemy)
        }
        else if ball.position.y >= enemy.position.y + 70 {
            addScore(playerWhoWon: player)
        }
        
    }
}
