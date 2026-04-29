import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    // ADDED FIX: This tells the app to load an SKView from the very beginning
    override func loadView() {
        self.view = SKView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .resizeFill

        let skView = self.view as! SKView
        skView.presentScene(scene)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
