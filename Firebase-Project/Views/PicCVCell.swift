

import UIKit

class PicCVCell: UICollectionViewCell {
    
  
  lazy var cellPicture: UIImageView = {
    let picture = UIImageView()
    return picture
  }()
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    addSubview(cellPicture)
    cellPictureConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func cellPictureConstraints() {
    cellPicture.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      cellPicture.centerYAnchor.constraint(equalTo: self.centerYAnchor) ,
      cellPicture.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      cellPicture.heightAnchor.constraint(equalToConstant: 120),
      cellPicture.widthAnchor.constraint(equalToConstant: 120)
    ])
  }
  
  
  
  
  
}
