import SpriteKit
import UIKit

enum GameState {
    case menu, playing
}

class GameScene: SKScene {

    let gridSize = 14
    let cellSize: CGFloat = 24

    var path: [(Int, Int)] = []
    var index = 0

    var snake: [SKShapeNode] = []
    var food: SKShapeNode!

    var gameState: GameState = .menu

    override func didMove(to view: SKView) {
        showMenu()
    }

    func generatePath() {
        path.removeAll()
        for y in 0..<gridSize {
            if y % 2 == 0 {
                for x in 0..<gridSize { path.append((x,y)) }
            } else {
                for x in (0..<gridSize).reversed() { path.append((x,y)) }
            }
        }
    }

    func showMenu() {
        removeAllChildren()
        backgroundColor = .black

        let title = SKLabelNode(text: "SNAKE AI")
        title.fontSize = 40
        title.fontColor = .white
        title.position = CGPoint(x: 0, y: 100)
        addChild(title)

        let play = SKLabelNode(text: "TAP TO PLAY")
        play.name = "play"
        play.fontSize = 24
        play.position = CGPoint(x: 0, y: 0)
        addChild(play)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameState == .menu {
            startGame()
        }
    }

    func startGame() {
        gameState = .playing
        removeAllChildren()

        backgroundColor = .black
        generatePath()

        createSnake()
        spawnFood()

        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.wait(forDuration: 0.12),
                SKAction.run { self.step() }
            ])
        ))
    }

    func createSnake() {
        let head = makeCell(.green)
        snake = [head]
        addChild(head)
        move(node: head, to: path[0])
    }

    func spawnFood() {
        food = makeCell(.red)
        addChild(food)
        move(node: food, to: path[10])
    }

    func step() {
        index = (index + 1) % path.count
        let next = path[index]

        let head = makeCell(.green)
        addChild(head)
        move(node: head, to: next)

        snake.insert(head, at: 0)

        if snake.count > 5 {
            let tail = snake.removeLast()
            tail.removeFromParent()
        }
    }

    func makeCell(_ color: UIColor) -> SKShapeNode {
        let node = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize), cornerRadius: 5)
        node.fillColor = color
        node.strokeColor = .clear
        return node
    }

    func move(node: SKNode, to pos: (Int, Int)) {
        node.position = CGPoint(
            x: CGFloat(pos.0) * cellSize,
            y: CGFloat(pos.1) * cellSize
        )
    }
}
