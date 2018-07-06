//
//  ViewController.swift
//  Movies
//
//  Created by Sayed Abdo on 3/30/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import SwiftyJSON
import SDWebImage
import CoreData
class ViewController:UIViewController ,UICollectionViewDelegate , UICollectionViewDataSource{
    
    let dropDown = DropDown()
    var alm = AlmophireDataRetrieved()

    @IBAction func clickOnMore(_ sender: Any) {
        dropDown.show()
    
    }
    @IBOutlet weak var myMenu: UIBarButtonItem!
    @IBOutlet weak var MyCollection: UICollectionView!
    

    var imgs:[movie] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
         navigationController?.navigationBar.barTintColor = UIColor.darkGray;
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        var nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        self.MyCollection.delegate = self
        self.MyCollection.dataSource = self

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        MyCollection!.collectionViewLayout = layout
        MyCollection.layer.borderColor = UIColor.darkGray.cgColor
        MyCollection.layer.borderWidth = 3.0
        MyCollection.layer.cornerRadius = 3.0
        
        dropDown.anchorView = myMenu
        dropDown.dataSource = ["Popular", "Now Playing"]
        dropDown.width = 300
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            switch index {
            case 0:
                if self.checkInternenConnection(){

                self.alm.getDataOfJson(url: urlValue.popular) { (error:String?, result:Any?) in
                    
                    if error != nil {
                        print("error")
                    }
                    else {
                        
                        self.imgs = result as! [movie]
                        print(self.imgs.count)
                        

                        self.MyCollection.reloadData()
                        self.navigationItem.title="Popular Movies"
                }
                    }
                }
            case 1:
                if self.checkInternenConnection(){

               self.alm.getDataOfJson(url: urlValue.nowPlaying) { (error:String?, result:Any?) in
                    
                    if error != nil {
                        print("error")
                    }
                    else {
                        
                        self.imgs = result as! [movie]
                        print(self.imgs.count)
                        
                        self.MyCollection.reloadData()
                       
                        self.title = "Now Playing Movies"
                        let frame = CGRect(x: 0, y: 0, width: 400, height: 70)
                        let tlabel = UILabel(frame: frame)
                        tlabel.text = self.title
                       
                        
                }
                    }
                }
            default:
                
                print("f")
                
            }
            print("Selected item: \(item) at index: \(index)")
            
        }
        
        if self.checkInternenConnection(){

        alm.getDataOfJson(url: urlValue.nowPlaying) { (error:String?, result:Any?) in
            
            if error != nil {
                print("error")
            }
            else {
                
                self.imgs = result as! [movie]
                print(self.imgs.count)
                
                self.MyCollection.reloadData()
                self.navigationController?.title="Now Playing Movies"

            }
        }
        }
}
  
    
    
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return imgs.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)as! MyCell
     
           cell.img.sd_setImage(with: URL(string: imgs[indexPath.row].poster_path!), placeholderImage: UIImage(named: "recent.png"))
           print(imgs[indexPath.row].poster_path)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let minSpace: CGFloat = 0
        
        return CGSize(width : (MyCollection.frame.size.width - minSpace)/4, height: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var v : Details = self.storyboard!.instantiateViewController(withIdentifier: "details") as! Details
        v.obj = imgs[indexPath.row]
        self.navigationController!.pushViewController(v, animated: true)
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "details") as! Details
//        self.present(vc, animated: true, completion: nil)

    }
    
    func checkInternenConnection()->Bool{
        
        if NetworkReachabilityManager()!.isReachable{
            
            return true;
        }else{
            
            let alert = UIAlertController(title: "Warnning", message: "Please check your intenet connectivity", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil);
            
            return false;
        }
    }
   
}


