import UIKit

class HomeTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        configureTabBar()
        addTabs()
    }

    private func configureTabBar() {
        tabBar.backgroundColor = UIColor(named: "WineColor")
        tabBar.tintColor = UIColor(named: "WineColorAccent")
    }
    
    private func addTabs() {
        let cellar = ViewController()
        let cellarImageSelected = UIImage(systemName: "list.bullet")!
        cellar.tabBarItem = UITabBarItem(
            title: "Library",
            image: UIImage(
                systemName: "list.bullet")!,
                selectedImage: cellarImageSelected.withTintColor(UIColor(named: "WineColorAccent")!, renderingMode: .alwaysOriginal))
        self.setViewControllers([cellar], animated: true)
    }
    
}
