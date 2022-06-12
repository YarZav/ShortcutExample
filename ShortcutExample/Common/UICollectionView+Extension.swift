import UIKit

extension UICollectionView {
  /// Plain init for UICollectionView
  ///
  /// - Parameters:
  ///   - cells: Cells in collecion view will be used
  ///   - dataSource: DataSource delegate for collection view
  ///   - delegate: Action delegate for collection view
  ///   - layout: FlowLayout for collection view
  convenience init(
    cells: [AnyClass],
    dataSource: UICollectionViewDataSource? = nil,
    delegate: UICollectionViewDelegate? = nil,
    layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
  ) {
    self.init(frame: .zero, collectionViewLayout: layout)
    self.dataSource = dataSource
    self.delegate = delegate

    cells.forEach { cellClass in
      guard let casted = cellClass.self as? UICollectionViewCell.Type else { return }
      let reuseIdentifier = String(describing: casted.self)
      self.register(cellClass, forCellWithReuseIdentifier: reuseIdentifier)
    }
  }

  /// Get cell for UICollectionView by IndexPath
  ///
  /// - Parameters:
  ///     - indexPath: Pndex path for cell in collection view
  func dequeueCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T {
    let reuseIdentifier = String(describing: T.self)
    if let cell = self.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? T {
      return cell
    } else {
      fatalError("Cell is not declarated in UICOllectionView")
    }
  }
}

