

import UIKit

class PostsVC: UIViewController {

  
  
  var posts = [Post]() {
    didSet {
      postsCV.reloadData()
    }
  }
  
  
  var users = [AppUser]()

  
  
  lazy var postsCV: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
      layout.scrollDirection = .horizontal
      cv.backgroundColor = .darkGray
      cv.backgroundColor = .lightGray
//      cv.dataSource = self
//      cv.delegate = self
      cv.register(PicCVCell.self, forCellWithReuseIdentifier: "cellPic")
      return cv
  }()
  
  override func viewDidLoad() {
        super.viewDidLoad()
        postsCVSetup()

    }
    

    private func postsCVSetup() {
            view.addSubview(postsCV)
            postsCV.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                postsCV.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                postsCV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                postsCV.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                postsCV.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)])
        }
        
    }

