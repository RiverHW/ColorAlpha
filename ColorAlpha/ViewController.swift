

import UIKit
import SCLAlertView


private let reuseIdentifier = "Cell"

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        view.addSubview(mainCollectionView)
        W = (mainCollectionView.bounds.size.width - Double((number + 1))*space)/Double(number)
        mainCollectionView.center = view.center
        self.loadData()
        
        self.title = "현재 레벨 : 1"
        self.navigationController?.navigationBar.backgroundColor = .gray
        
        
    }
    
    func refresh() {
        
        W = (mainCollectionView.bounds.size.width - Double((number + 1))*space)/Double(number)
        random = Int(arc4random()) % (number*number)
        self.mainCollectionView.reloadData()
        
        self.title = String.init(format: "현재 레벨 :%ld", number - 1)
        
    }
    
    
    var space = 5.0
    var number = 2
    var W = 100.00
    var random = 0
    
    
    
    // MARK: - Netdata
    
    func loadData() {
        
    }
    
    
    // MARK: - collectionview
    
    lazy var mainCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout.init()
        let collview = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.width), collectionViewLayout: layout)
        collview.delegate = self
        collview.dataSource = self
        collview.backgroundColor = UIColor.systemGray3
        collview.layer.cornerRadius = 5
        collview.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return collview
        
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return number*number
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .darkGray
        cell.layer.cornerRadius = 5
        
        if indexPath.row == random {
            cell.backgroundColor = .systemGray
        }else{
            cell.alpha = 1
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
            cell.transform3D = CATransform3DMakeRotation(.pi , 0, 1, 0)
            UIView .animate(withDuration: 0.5, delay: 0.0, options: .curveLinear) {
                cell.transform = .identity
            } completion: { (make) in

            }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == random {
            number = number + 1
            self.refresh()
        }else{
            
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            
            alertView.addButton("다시 시작하다") {
                self.finish()
            }
            alertView.showError("선택이 틀리다", subTitle: "")
            
        }
    }
    
    func finish()  {
        
        number = 2
        self.refresh()
        
    }
    
    
    // MARK: - UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: W, height: W)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return space
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return space
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: space, left: space, bottom: space, right: space)
    }
    
}

