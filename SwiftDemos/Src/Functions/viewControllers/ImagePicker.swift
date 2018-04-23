//
//  ImagePicker.swift
//  SwiftDemos
//
//  Created by qianzhao on 2018/4/23.
//  Copyright © 2018年 qianzhao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ImagePicker: UIViewController {

    let disposeBag = DisposeBag()
    let imageView: UIImageView = UIImageView()
    let cameraButton: UIButton = UIButton()
    let galButton: UIButton = UIButton()
    let cropButton: UIButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initUI()
        configEvents()
    }
    
    func initUI() -> Void {
        let supV: UIView = self.view
        supV.addSubview(imageView)
        supV.addSubview(cameraButton)
        supV.addSubview(galButton)
        supV.addSubview(cropButton)
        
        cameraButton.setTitle("Camera", for: .normal)
        galButton.setTitle("Gallory", for: .normal)
        cropButton.setTitle("Crop", for: .normal)
        
        cameraButton.setBackgroundImage(UIImage(color: .gray), for: .highlighted)
        galButton.setBackgroundImage(UIImage(color: .gray), for: .highlighted)
        cropButton.setBackgroundImage(UIImage(color: .gray), for: .highlighted)
        
        cameraButton.backgroundColor = .red
        galButton.backgroundColor = .red
        cropButton.backgroundColor = .red
        
        imageView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(400)
        }
        imageView.backgroundColor = .gray
        
        let buttonW = 200, buttonH = 60
        cameraButton.snp.makeConstraints { (make) in
            make.width.equalTo(buttonW)
            make.height.equalTo(buttonH)
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(30)
        }
        
        galButton.snp.makeConstraints { (make) in
            make.width.height.centerX.equalTo(cameraButton)
            make.top.equalTo(cameraButton.snp.bottom).offset(30)
        }
        
        cropButton.snp.makeConstraints { (make) in
            make.width.height.centerX.equalTo(cameraButton)
            make.top.equalTo(galButton.snp.bottom).offset(30)
        }
    }
    
    func configEvents() -> Void{
        cameraButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] () in
            print("cameraButton fail...")
            self?.enterCamera()
        }).disposed(by: disposeBag)
        
        galButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] () in
            print("galButton fail...")
            self?.enterGallory()
        }).disposed(by: disposeBag)
        
        cropButton.rx.tap
            .flatMapLatest { [weak self] _ in
//                print("flatMapLatest step1:")
                return UIImagePickerController.rx.createWithParent(self) { picker in
                        picker.sourceType = .photoLibrary
                        picker.allowsEditing = true
                    }
                    .flatMap {
//                        print("flatMap =xxx")
                        $0.rx.didFinishPickingMediaWithInfo
                    }
                    .take(1)
            }
            .map { info in
                return info[UIImagePickerControllerOriginalImage] as? UIImage
            }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
    }
}

extension ImagePicker{
    func enterCamera() -> Void {
        print("enterCamera")
    }
    func enterGallory() -> Void {
        print("enterGallory")
//        let picker: UIImagePickerController = UIImagePickerController()
//        picker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
//        picker.delegate = self
//        self.navigationController?.present(picker, animated: true, completion:nil)
    }
//    func cropEvent() -> Void {
//        print("cropEvent")
//    }
}

//extension ImagePicker: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
//        print("info: \(info)")
//        let image: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        imageView.image = image
//        picker.dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
//        print("imagePickerControllerDidCancel)")
//        picker.dismiss(animated: true, completion: nil)
//    }
//}
