# RxMVVMC

# RxMVVMC demonstrate MVVM pattern with RxSwift plus coordinator pattern to navigate to different View controller

1. MVVM architecture to keeps View Controller light weight and VCs are responsible only hook and update views
2. View Model has all business logics. They talk to Services and notify view controllers. Also code in ViewModel makes code testing way easy. All dependecies are injected so that Mocking is easly done
3. RxSwift used for webservices data and seemlessly passing data from Service -> ViewModel -> ViewController
4. Coordinator takes all the responsibility of navigation and app flow task. View Controller becomes more lighter and can be resused without hassle.
5. Yet to include Unit Test
