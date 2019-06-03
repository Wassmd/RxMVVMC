# RxMVVMC

RxMVVMC demonstrate MVVM pattern with RxSwift plus coordinator pattern to navigate to different View controller

1. MVVM architecture to keeps View Controller light weight and responsible to update or hook views
2. View Model has all business logics. This makes code testing way easy.
3. RxSwift used for downloading data and seemlessly pass from Service -> ViewModel -> ViewController
4. Coordinator takes all the responsibility of navigation and app flow task. View Controller becomes more lighter and can be resused without hassle.
5. Coming soon testing....
