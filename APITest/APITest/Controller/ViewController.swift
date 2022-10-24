//
//  ViewController.swift
//  APITest
//
//  Created by 오예진 on 2022/10/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    var list: [Comment] = Comment.list
//
//    init(collectionView: UICollectionView!, dataSource: UICollectionViewDiffableDataSource<Section, Item>!) {
//        super.init()
//        self.collectionView = collectionView
//        self.dataSource = dataSource
//        list = []
//        getData { json in
//            self.list = json.comments
//        }
//        print(list)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
    typealias Item = Comment
    
    enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getData(){ json in
//            self.list = json.comments
//        }
        setUI()
        collectionView.delegate = self
    }
    
    private func setUI() {
        // (1) Presentation : Diffable Datasource
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DataCell", for: indexPath) as? DataCell else {
                return nil
            }
            cell.configure(item)
            return cell
        })
        
        // (2) Data : snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        print("self list: ",self.list)
        getData { json in
            self.list = json.comments
                    print(self.list)
                    snapshot.appendItems(self.list, toSection: .main)
                    self.dataSource.apply(snapshot)
                    
                    
                    // (3) Layout : compositional layout
                    self.collectionView.collectionViewLayout = self.layout()
                }
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
       // item, group, section, layout 만들기
       let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))    // item의 width는 group너비의 1/3, height는 group높이과 같음
       let item = NSCollectionLayoutItem(layoutSize: itemSize)
       
       let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.33))    // group의 width는 section너비, height는 section너비의 1/3
       let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])  // item을 3등분으로 균일하게 쓰겠다!
       
       let section = NSCollectionLayoutSection(group: group)
       // section 좌우에 안쪽패딩주기
       section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
       
       let layout = UICollectionViewCompositionalLayout(section: section)
       return layout
   }


}

