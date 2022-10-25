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
    
    typealias Item = Comment
    
    enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        getData { json in
            self.list = json.comments
            snapshot.appendItems(self.list, toSection: .main)
            self.dataSource.apply(snapshot)
        }
        
        // (3) Layout : compositional layout
        self.collectionView.collectionViewLayout = self.layout()
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
       let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
       let item = NSCollectionLayoutItem(layoutSize: itemSize)
       
       let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.33))
       let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
       
       let section = NSCollectionLayoutSection(group: group)
       section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
       
       let layout = UICollectionViewCompositionalLayout(section: section)
       return layout
   }


}

