import UIKit

class TabBarVC: UITabBarController {

    lazy var postsVC = UINavigationController(rootViewController: PostsVC())
    
//    lazy var usersVC = UINavigationController(rootViewController: UsersListViewController())
    
    lazy var profileVC: UINavigationController = {
        let profileVC = ProfileVC()
//        profileVC.user = AppUser(from: FirebaseAuthService.manager.currentUser!)
//        profileVC.isCurrentUser = true
        return UINavigationController(rootViewController: profileVC)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postsVC.tabBarItem = UITabBarItem(title: "Posts", image: UIImage(systemName: "list.dash"), tag: 0)
//        usersVC.tabBarItem = UITabBarItem(title: "Users", image: UIImage(systemName: "person.3"), tag: 1)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.square"), tag: 2)
        self.viewControllers = [postsVC, profileVC]
    }
}
