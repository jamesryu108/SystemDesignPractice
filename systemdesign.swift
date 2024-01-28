// MARK: - Protocols

protocol CoreDataManagerProtocol {
    func save(bucketList: BucketList) async
    func fetchBucketList() async -> [BucketList]
}

protocol NetworkCallerProtocol {
    func fetchData<T: Decodable>(from url: URL) async throws -> T
}

protocol ChatGPTAPIProtocol {
    func fetchActivityIdeas(for location: String) async throws -> [Activity]
}

protocol UnsplashAPIProtocol {
    func fetchLocationImage(for location: String) async throws -> UIImage
}

// MARK: - Implementations

class CoreDataManager: CoreDataManagerProtocol {
    func save(bucketList: BucketList) async {
        // Implement saving logic
    }

    func fetchBucketList() async -> [BucketList] {
        // Implement fetching logic
        return []
    }
}

class NetworkCaller: NetworkCallerProtocol {
    func fetchData<T>(from url: URL) async throws -> T where T : Decodable {
        // Implement network fetching logic using async/await
        return T
    }
}

class ChatGPTAPI: ChatGPTAPIProtocol {
    private let networkCaller: NetworkCallerProtocol

    init(networkCaller: NetworkCallerProtocol) {
        self.networkCaller = networkCaller
    }

    func fetchActivityIdeas(for location: String) async throws -> [Activity] {
        // Implement fetching activity ideas from ChatGPT using async/await
    }
}

class UnsplashAPI: UnsplashAPIProtocol {
    private let networkCaller: NetworkCallerProtocol

    init(networkCaller: NetworkCallerProtocol) {
        self.networkCaller = networkCaller
    }

    func fetchLocationImage(for location: String) async throws -> UIImage {
        // Implement fetching location image from Unsplash using async/await
    }
}

// MARK: - DIContainer

class DIContainer {
    lazy var coreDataManager: CoreDataManagerProtocol = CoreDataManager()
    lazy var networkCaller: NetworkCallerProtocol = NetworkCaller()
    lazy var chatGPTAPI: ChatGPTAPIProtocol = ChatGPTAPI(networkCaller: networkCaller)
    lazy var unsplashAPI: UnsplashAPIProtocol = UnsplashAPI(networkCaller: networkCaller)

    func makeBucketListViewController() -> BucketListViewController {
        let viewController = BucketListViewController()
        viewController.coreDataManager = coreDataManager
        viewController.chatGPTAPI = chatGPTAPI
        viewController.unsplashAPI = unsplashAPI
        return viewController
    }
}

// MARK: - BucketListViewController

final class BucketListViewController: UIViewController {
    var coreDataManager: CoreDataManagerProtocol?
    var chatGPTAPI: ChatGPTAPIProtocol?
    var unsplashAPI: UnsplashAPIProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup UI and functionality
    }

    @objc func generateBucketList() async {
        // Implement the logic to generate a bucket list using async/await
        let activity = try? await chatGPTAPI?.fetchActivityIdeas(for: "")
    }
}

// MARK: - Supporting Models

struct BucketList {
    let locationName: String
    let image: UIImage?
    let description: String
    let coordinate: CLLocationCoordinate2D
    
}

struct Activity {
    let activityName: String
    let locationName: String
    let image: UIImage?
    let coordinate: CLLocationCoordinate2D
    let description: String
    let status: activityStatus
}

enum activityStatus {
    case planned
    case notPlanned
}
