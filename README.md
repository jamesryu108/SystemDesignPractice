# SystemDesignPractice

## Summary

This application allows users to create personalized bucket lists based on their location preferences. It fetches activity ideas and location images from private external APIs and manages the fetched activity ideas in internal storage. (Core Data)

![Screenshot 2024-01-27 at 20 29 16](https://github.com/jamesryu108/SystemDesignPractice/assets/33236626/9bc53a79-8924-47f4-a867-10232c98e7d5)

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
