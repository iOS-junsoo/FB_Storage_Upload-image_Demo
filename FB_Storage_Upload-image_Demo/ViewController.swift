//
//  ViewController.swift
//  FB_Storage_Upload-image_Demo
//
//  Created by 준수김 on 2021/10/25.
//

import UIKit
import FirebaseStorage //import하기

class ViewController: UIViewController {

    let storage = Storage.storage() //인스턴스 생성
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "password")
        upLoadImage(img: image!) //원하는 이미 업로드
    }

    //MARK: - 파일 업로드
    func upLoadImage(img: UIImage){
        var data = Data()
        data = img.jpegData(compressionQuality: 0.8)! //지정한 이미지를 포함하는 데이터 개체를 JPEG 형식으로 반환, 0.8은 데이터의 품질을 나타낸것 1에 가까울수록 품질이 높은 것
        let filePath = "password"
        let metaData = StorageMetadata() //Firebase 저장소에 있는 개체의 메타데이터를 나타내는 클래스, URL, 콘텐츠 유형 및 문제의 개체에 대한 FIRStorage 참조를 검색하는 데 사용
        metaData.contentType = "image/png" //데이터 타입을 image or png 팡이
        storage.reference().child(filePath).putData(data, metadata: metaData){
            (metaData,error) in if let error = error { //실패
                print(error)
                return
            }else{ //성공
                print("성공")
            }
        }
    }

    //MARK: - 파일 다운로드
    func downloadimage(imgview: UIImageView){
        storage.reference(forURL: "gs://teststorage-71c0f.appspot.com/password").downloadURL(completion: { (url, error) in
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            self.imageView.image = image
            
        })
    }
    
    @IBAction func tappedBtn(_ sender: Any) {
        downloadimage(imgview: imageView)
    }
    
    
}

   
