//
//  ViewController.swift
//  SkeletonViewTest
//
//  Created by 김정민 on 2022/05/19.
//

import UIKit
import SkeletonView

class CodeBasedViewController: UIViewController {
    private let bannerImageView = UIImageView()
    private let bannerLabelView = BannerLabelView()
    private let skeletonCollectionViewLayout = UICollectionViewFlowLayout()
    private lazy var skeletonCollectionView = UICollectionView(frame: .zero, collectionViewLayout: skeletonCollectionViewLayout)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.showSkeleton()
        // 개별 적용
        skeletonCollectionView.showAnimatedGradientSkeleton()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.view.hideSkeleton()
        }
        
        if bannerLabelView.isLaidOut {
            print("aa")
            
            view.showSkeleton()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                self?.view.hideSkeleton()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func attribute() {
        view.backgroundColor = .white
        view.isSkeletonable = true
        
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        bannerLabelView.isSkeletonable = true
        bannerLabelView.translatesAutoresizingMaskIntoConstraints = false
        
        skeletonCollectionView.isSkeletonable = true
        skeletonCollectionView.translatesAutoresizingMaskIntoConstraints = false
        skeletonCollectionView.backgroundColor = .white
        skeletonCollectionView.delegate = self
        skeletonCollectionView.dataSource = self
        skeletonCollectionView.register(SkeletonCollectionViewCell.self, forCellWithReuseIdentifier: SkeletonCollectionViewCell.description())
        
        
        skeletonCollectionViewLayout.scrollDirection = .horizontal
    }
    
    private func layout() {
        view.addSubview(bannerImageView)
        view.addSubview(bannerLabelView)
        view.addSubview(skeletonCollectionView)
        
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: view.topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerImageView.heightAnchor.constraint(equalToConstant: 300),
            
            bannerLabelView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            bannerLabelView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerLabelView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            skeletonCollectionView.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor),
            skeletonCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            skeletonCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            skeletonCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CodeBasedViewController: SkeletonCollectionViewDelegate { }


extension CodeBasedViewController: SkeletonCollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: SkeletonCollectionViewCell.description(), for: indexPath)
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return SkeletonCollectionViewCell.description()
    }
}

extension CodeBasedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 180)
    }
}

