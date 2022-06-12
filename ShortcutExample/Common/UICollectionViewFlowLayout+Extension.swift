//
//  UICollectionViewFlowLayout+Extension.swift
//  YZCuteDogs
//
//  Created by 19205313 on 20.03.2022.
//

import UIKit

extension UICollectionViewFlowLayout {
  /// Plain init for UICollactionFlowLayout
  ///
  /// - Parameters:
  ///   - itemSize: Size of cell
  ///   - scrollDirection: Scroll for collection view
  ///   - edgeInsets: Items insets
  convenience init(
    itemSize: CGSize,
    scrollDirection: UICollectionView.ScrollDirection = .vertical,
    edgeInsets: UIEdgeInsets = .zero
  ) {
    self.init()
    self.scrollDirection = scrollDirection
    self.sectionInset = edgeInsets
    self.itemSize = itemSize
  }
}
