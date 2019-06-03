# RxMVVMC

**RxMVVMC demonstrate MVVM pattern with RxSwift plus coordinator pattern**

1. MVVM architecture to keeps View Controller light weight
2. VCs are only responsible to hook and update views
3. View Model has all business logics. They talk to Services and notify/bind to view controllers. 
4. Code in ViewModel becomes fully testable. All dependecies are injected so that Mocking can be done with ease
3. RxSwift used here for webservices call and transfer of data from Service -> ViewModel -> ViewController
4. Coordinator takes all the responsibility of navigation and app flow task. 
5. View Controller becomes much lighter and can be used without hassle.
6. MVVMC + RxSwift is more clean and maintainable.
5. Yet to include Unit Test
