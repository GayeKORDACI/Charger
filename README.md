# Charger

-Uygulamanın geliştirme aşamasında rahat test edilmesi için aşağıdaki kullanıcı bilgileri preset edilmiştir.

    "email": "kullanici@gmail.com",
    "userID": 243

-Design Pattern olarak MVVM uygulanmıştır.

-3rd Party olarak Cocoapods üzerinden Moya-Alamofire ve IQKeyboardManagerSwift kullanılmıştır.

-Tasarımsal olarak ayrı Storyboard, CustomView.xib ve TableViewCell.xib'ler oluşturulup, ortak tek bir Storyboard kullanılmamıştır.

-Kullanılacak servisler için ServiceConnector (Servislerin tanımları) ve APIManager (Servis fonksiyonları) içeren bir network katmanı oluşturulmuştur.
Arçelik tarafından verilen bütün servislerin tanımları ve fonksiyonları hazırlanmıştır.

-Kodları olabildiğince birbirinden ayrı parçalara bölmek adına aşağıdaki gibi yapılar kullanılmıştır.
Enums --> Bütün enum değerlerinin bulunduğu dosya,
Globals --> BaseServiceURL ve Kullanıcı verilerinin bulunduğu dosya,
GetLocation --> Kullanıcı lokasyonun izni ve verilerinin toplandığı dosya,
Base --> BaseViewController ve BaseTableViewCell'in toplandığı klasör,
AppBootsrap --> Uygulamadaki ViewController'ların yaratıldığı ve gösterildiği dosya,
AppAppearance --> Uygulamanın görünüşleriyle ilgili ayarların bulunduğu dosya,
Localizable --> Türkçe ve İngilizce key-value'ların bulunduğu dosya

-Uygulamada oluşturulan ekranlar Splash, Login, Profile ve Reservation şeklindedir.

-Türkçe ve İngilizce dil desteği mevcuttur.

Not: Yapılan rezervasyon bilgileri gösterilirken "Kullanıcının Randevuları" servisinden gelen socket bilgileri çoğul olduğu için
array'in ilk elemanına göre işlem yapılmıştır.  

 
