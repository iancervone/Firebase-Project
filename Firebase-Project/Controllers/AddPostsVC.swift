//
//  PostsVC.swift
//  Firebase-Project
//
//  Created by Ian Cervone on 11/24/19.
//  Copyright © 2019 Ian Cervone. All rights reserved.
//

import UIKit
import Photos

class AddPostsVC: UIViewController {

  
  let imagePickerViewController = UIImagePickerController()
  var imageURL: URL? = nil
  var user: AppUser!
  var image = UIImage() {
      didSet {
          self.postImage.image = image
      }
  }
  
  
  
  //MARK: Views
  lazy var postImage: UIImageView = {
      let image = UIImageView()
      image.image = UIImage(systemName: "camera")
      image.backgroundColor = #colorLiteral(red: 0.2481059134, green: 0.430631876, blue: 0.7893758416, alpha: 1)
      image.tintColor = .black
      image.contentMode = .scaleToFill
      return image
  }()
  
  
  
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }
    

  //MARK: Obj-C methods
  @objc private func addImagePressed(){
      switch PHPhotoLibrary.authorizationStatus(){
      case .notDetermined, .denied , .restricted:
          PHPhotoLibrary.requestAuthorization({[weak self] status in
              switch status {
              case .authorized:
                  self?.presentPhotoPickerController()
              case .denied:
                  print("Denied photo library permissions")
              default:
                  print("No usable status")
              }
          })
      default:
          presentPhotoPickerController()
      }
  }
  
      //MARK: Private methods

  private func setupSubViews(){
      view.backgroundColor = .black
      setupImageView()
  }
  
  
  
  
  private func showAlert(title: String, message: String) {
      let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      present(alertVC, animated: true)
  }
  
  
  private func presentPhotoPickerController() {
      self.imagePickerViewController.delegate = self
      self.imagePickerViewController.sourceType = .photoLibrary
      self.imagePickerViewController.allowsEditing = true
      self.imagePickerViewController.mediaTypes = ["public.image"]
      self.present(self.imagePickerViewController, animated: true, completion: nil)
  }
  
  
  
  
  
  
  //MARK: UI Setup

  private func setupImageView() {
      view.addSubview(postImage)
      postImage.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
          postImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
          postImage.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
          postImage.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
          postImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.40)])
      
  }

  
  
  
}


extension AddPostsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        self.image = image
        dismiss(animated: true, completion: nil)
    }
}
