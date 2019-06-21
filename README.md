# RxMVVMC

**RxMVVMC demonstrates MVVM + coordinator pattern with RxSwift programming**

* MVVM architecture to keeps View Controller light weight
* VCs are only responsible to hook and update views
* View Model has all business logics. They talk to Services and notify/bind to view controllers. 
* Code in ViewModel becomes fully testable. All dependecies are injected so that Mocking can be done with ease
* RxSwift used here for webservices call and transfer of data from Service -> ViewModel -> ViewController
* Coordinator takes all the responsibility of navigation and app flow task. 
* View Controller becomes much lighter and can be used other places without any hassle.
* MVVMC + RxSwift is more clean and maintainable.
* Yet to include Unit Test

Project uses cocopod. Make sure you do

```swift

pod init
pod install

```

 * open workspace
 * Run on iPad simulator/Device :]
