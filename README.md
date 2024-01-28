# SystemDesignPractice

## Summary

This application allows users to create personalized bucket lists based on their location preferences. It fetches activity ideas and location images from private external APIs and manages the fetched activity ideas in internal storage. (Core Data)

![Screenshot 2024-01-27 at 20 29 16](https://github.com/jamesryu108/SystemDesignPractice/assets/33236626/9bc53a79-8924-47f4-a867-10232c98e7d5)

## Client Public API

```
DIContainer:
+ init()
+ coreDataManager: CoreDataManagerProtocol
+ networkCaller: NetworkCallerProtocol
+ chatGPTAPI: ChatGPTAPIProtocol
+ unsplashAPI: UnsplashAPIProtocol
+ makeBucketListViewController() -> BucketListViewController

CoreDataManager (Conforming to CoreDataManagerProtocol):
+ init()
+ save(bucketList: BucketList) async
+ fetchBucketList() async -> [BucketList]

NetworkCaller (Conforming to NetworkCallerProtocol):
+ init()
+ fetchData<T: Decodable>(from url: URL) async throws -> T

ChatGPTAPI (Conforming to ChatGPTAPIProtocol):
+ init(networkCaller: NetworkCallerProtocol)
+ fetchActivityIdeas(for location: String) async throws -> [Activity]

UnsplashAPI (Conforming to UnsplashAPIProtocol):
+ init(networkCaller: NetworkCallerProtocol)
+ fetchLocationImage(for location: String) async throws -> UIImage

BucketListViewController:
+ init(diContainer: DIContainer)
+ viewDidLoad()
+ generateBucketList()

// Supporting Models

BucketList:
+ init(/* properties of a bucket list */)

Activity:
+ init(/* properties of an activity */)

CoreDataManagerProtocol:
+ init()
+ save(bucketList: BucketList) async
+ fetchBucketList() async -> [BucketList]

NetworkCallerProtocol:
+ init()
+ fetchData<T: Decodable>(from url: URL) async throws -> T

ChatGPTAPIProtocol:
+ init(networkCaller: NetworkCallerProtocol)
+ fetchActivityIdeas(for location: String) async throws -> [Activity]

UnsplashAPIProtocol:
+ init(networkCaller: NetworkCallerProtocol)
+ fetchLocationImage(for location: String) async throws -> UIImage

```
## Client-side Components

* NetworkCaller
  - Manages network requests using Swift Concurrency.
  - Provides a generic implementation of fetch data of any `Decodable` type.
 
* ChatGPTAPI:
  - Fetches activity ideas based on the location selected by users.
  - Utilizes `NetworkCaller` to make API requests.
 
* UnsplashAPI:
  - Fetches landmark photos of the location selected by users.
  - Utilizes `NetworkCaller` to make API requests.
 
* BucketListViewController:
  - This is the main user interface component where users can interact with the application.
  - Allows users to input location, select activitity type and generate their activity list.
  - Interacts with dependencies such as `CoreDataManager`, `ChatGPTAPI`, and `UnsplashAPI` for functionality.

* DIContainer
  - A container that manages all dependencies.
  - `DIContainer` acts as a central point where all dependencies are managed. This centralization makes it easier to see what is needed in the application.
  - With `DIContainer`, adding or modifying dependencies becomes much simpler and does not require significant changes in multiple places in the codebase. 
  - Provides instances of `CoreDataManager`, `NetworkCaller`, `ChatGPTAPI` and `UnsplashAPI`.
  - These dependencies are injected via the initializer of BucketListViewController. (It passes the protocols that these dependencies conform to, in order to decouple these dependencies from the view controller.)

## Functionality
- Users can enter a location and choose types of activities.
- The application fetches activity ideas from ChatGPTAPI and location images from UnsplashAPI.
- NetworkCaller facilitates these API calls using a generic, reusable function.
- Fetched data is persisted locally using CoreDataManager.
- DIContainer ensures loosely coupled architecture by injecting dependencies where needed.

## Concurrency and Data Flow
- The system adopts Swift's modern concurrency model (async/await) for network calls and data fetching.
- This approach simplifies asynchronous code and improves readability and maintainability.

## User Interface
- BucketListViewController provides an interactive interface for users to create and view their bucket lists.
- The UI is designed to be intuitive and user-friendly, enhancing the overall user experience.
- This design emphasizes modularity, maintainability, and scalability, ensuring a robust foundation for the application. It leverages Swift's advanced features to create an efficient and responsive user experience.
