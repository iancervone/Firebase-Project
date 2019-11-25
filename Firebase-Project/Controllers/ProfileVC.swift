import UIKit

class ProfileVC: UIViewController {
    
    var user: AppUser!
    var isCurrentUser = false
    
    var posts = [Post]() {
        didSet {
              picsCV.reloadData()
        }
    }
    
    lazy var picsCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        cv.backgroundColor = .darkGray
        cv.backgroundColor = .lightGray
        cv.dataSource = self
        cv.delegate = self
        cv.register(PicCVCell.self, forCellWithReuseIdentifier: "cellPic")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picsCVSetup()
        setupNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        getPostsForThisUser()
    }
    
    @objc private func editProfile() {
        navigationController?.pushViewController(EditProfileVC(), animated: true)
    }
    
    private func getPostsForThisUser() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            FirestoreService.manager.getPosts(forUserID: self?.user.uid ?? "") { (result) in
                switch result {
                case .success(let posts):
                    self?.posts = posts
                case .failure(let error):
                    print(":( \(error)")
                }
            }
        }
    }
    
    private func setupNavigation() {
        self.title = "Profile"
        if isCurrentUser {
            self.navigationItem.rightBarButtonItem =
                UIBarButtonItem(image: UIImage(systemName: "pencil.circle"), style: .plain, target: self, action: #selector(editProfile))
        }
    }
    
  
    private func picsCVSetup() {
        view.addSubview(picsCV)
        picsCV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            picsCV.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            picsCV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            picsCV.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            picsCV.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)])
    }

}


extension ProfileVC: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return(0)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellPic", for: indexPath) as! PicCVCell
        let post = posts[indexPath.row]
//      cell.picture.image = post.pic
        return cell
    }
  }


extension ProfileVC: UICollectionViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
//            let post = posts[indexPath.row]
//            let postDetailVC = PostDetailViewController()
//            postDetailVC.post = post
//            self.navigationController?.pushViewController(postDetailVC, animated: true)
        }
    }
}
