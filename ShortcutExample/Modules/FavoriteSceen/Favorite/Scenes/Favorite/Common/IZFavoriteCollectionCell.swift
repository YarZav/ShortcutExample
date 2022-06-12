//
//  YZDogListCollectionCell.swift
//  YZCuteDogs
//
//  Created by 19205313 on 20.03.2022.
//

import UIKit

final class IZFavoriteCollectionCell: UICollectionViewCell {
  // MARK: - Private property

  private lazy var imageView = IZImageView()

  // MARK: - Internal property

  var favorite: IZComicModel? {
    didSet {
      imageView.load(with: favorite?.img)
    }
  }

  // MARK: - Init

  override public init(frame: CGRect) {
    super.init(frame: frame)
    self.createUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Internal

extension IZFavoriteCollectionCell { }

// MARK: - Private

private extension IZFavoriteCollectionCell {
  func createUI() {
    contentView.addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
}
