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
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = UIColor(named: "WineColor")
        barAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(named: "WineColorAccent")!]
        
        
        
        let cellarVC = CellarViewController()
        cellarVC.navigationItem.standardAppearance = barAppearance
        cellarVC.navigationItem.scrollEdgeAppearance = barAppearance
        let cellarNav = UINavigationController(rootViewController: cellarVC)
        var cellarImage = UIImage(named: "CellarImage")
        cellarImage = cellarImage?.resizeImageTo(size: CGSize(width: 48, height: 32))
        var cellarSelectedImage = UIImage(named: "CellarSelectedImage")
        cellarSelectedImage = cellarSelectedImage?.resizeImageTo(size: CGSize(width: 48, height: 32))
        
        cellarNav.tabBarItem = UITabBarItem(
            title: "Cellar",
            image: cellarImage,
            selectedImage: cellarSelectedImage?.withTintColor(UIColor(named: "WineColorAccent")!, renderingMode: .alwaysOriginal))
        
        let flightAttendantVC = FlightAttendantViewController()
        flightAttendantVC.navigationItem.standardAppearance = barAppearance
        flightAttendantVC.navigationItem.scrollEdgeAppearance = barAppearance
        var flightAttendantImage = UIImage(named: "FlightAttendantImage")
        flightAttendantImage = flightAttendantImage?.resizeImageTo(size: CGSize(width: 48, height: 32))
        var flightAttendantSelectedImage = UIImage(named: "FlightAttendantSelectedImage")
        flightAttendantSelectedImage = flightAttendantSelectedImage?.resizeImageTo(size: CGSize(width: 42, height: 32))
        
        flightAttendantVC.tabBarItem = UITabBarItem(
            title: "Flight Attendant",
            image: flightAttendantImage,
            selectedImage: flightAttendantSelectedImage?.withTintColor(UIColor(named: "WineColorAccent")!, renderingMode: .alwaysTemplate))
        
        let pastFlightsVC = PastTastingsViewController()
        pastFlightsVC.navigationItem.standardAppearance = barAppearance
        pastFlightsVC.navigationItem.scrollEdgeAppearance = barAppearance
        let pastFlightsImage = UIImage(systemName: "book")
        let pastFlightsSelectedImage = UIImage(systemName: "book.fill")
        
        pastFlightsVC.tabBarItem = UITabBarItem(
            title: "Past Flights",
            image: pastFlightsImage,
            selectedImage: pastFlightsSelectedImage?.withTintColor(UIColor(named: "WineColorAccent")!, renderingMode: .alwaysOriginal))
        
        let settingsVC = SettingsViewController()
        settingsVC.navigationItem.standardAppearance = barAppearance
        settingsVC.navigationItem.scrollEdgeAppearance = barAppearance
        let settingsImage = UIImage(systemName: "gearshape")
        let settingsSelectedImage = UIImage(systemName: "gearshape.fill")
        
        settingsVC.tabBarItem = UITabBarItem(
            title: "Settings",
            image: settingsImage,
            selectedImage: settingsSelectedImage?.withTintColor(UIColor(named: "WineColorAccent")!, renderingMode: .alwaysOriginal))
        
        self.setViewControllers([cellarNav, flightAttendantVC, pastFlightsVC, settingsVC], animated: true)
    }
    
}
