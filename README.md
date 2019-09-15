# RxMVVMC

**RxMVVMC demonstrates MVVM + coordinator pattern with RxSwift programming**

* MVVM architecture to keeps View Controller light weight, which enables to decouple business logic from the view for better separation of concerns and much improved testability. Along with it, RxSwift and RxCocoa is used for data binding, handle asynchronous tasks.
* Code in ViewModel becomes fully testable. All dependecies are injected so that Mocking can be done with ease
* RxSwift used here for webservices call and transfer of data from Service -> ViewModel -> ViewController
* Coordinator takes all the responsibility of navigation and app flow task. 
* Unit Test shows mocking and asynchronous test coverage

Project uses Carthage. Make sure you do

```swift
carthage update --platform iOS
```

* Swiftlint is used to maintain clean code and code formatting.
* For Networking `EndpointLoader` framework is used.

 * open the project
 * Run on iPad simulator/Device :]
 
 
 Demo
 
 ![alt-text](https://github.com/Wassmd/RxMVVMC/blob/master/imageFinder_1.gif)
