import CoreData

@objc(Product)
public final class IZComicDBModel: NSManagedObject {

  // MARK: - CoreData

  public convenience init() {
    let manager = IZCoreDataManager.shared
    self.init(entity: manager.entityForName(entityName: IZComicDBModel.entityName), insertInto: manager.managedObjectContext)
  }

  @nonobjc public class func fetchRequest() -> NSFetchRequest<IZComicDBModel> {
    return NSFetchRequest<IZComicDBModel>(entityName: IZComicDBModel.entityName)
  }
}

// MARK: - Property

extension IZComicDBModel: IZCoreDataModelIdentifiable {
  static var entityName: String = "Comic"

  /// Unique identifier for model
  @NSManaged public var id: String

  /// Added date
  @NSManaged public var date: Date?

  /// Number of comic
  @NSManaged public var num: String

  /// Title of product
  @NSManaged public var title: String?

  /// Transcript of product
  @NSManaged public var transcript: String?

  /// URl image
  @NSManaged public var img: String?
}
