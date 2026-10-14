# NOVA STORE — Mini Katalog

Flutter ve Dart ile hazırlanmış eğitim amaçlı katalog uygulaması. Ana sayfa, aranabilir ve filtrelenebilir ürün kataloğu, ürün detayı ve adet yönetimli sepet içerir. Sekiz ürünün görselleri ve JSON verileri uygulamaya dahil edilmiştir; kullanım sırasında internet gerekmez. Gerçek sipariş veya ödeme oluşturulmaz.

## Kullanılan sürüm

Yerel SDK sorgusuyla doğrulanan sürümler:

- Flutter **3.38.5**, stable
- Dart **3.10.4**

Sürüm doğrulandı; bu çalışma ortamındaki SDK/bağımlılık erişim kısıtları nedeniyle analiz, test, cihazda çalıştırma ve APK derleme henüz doğrulanmadı. Kaynakların biçimlendirmesi başarıyla çalıştırıldı.

## Gereksinimler ve çalıştırma

Flutter SDK, VS Code ve Android için Android Studio / Android SDK ile bir emulator veya fiziksel cihaz gereklidir. Platform klasörleri projede mevcuttur.

Proje kökünde PowerShell terminalinde:

```powershell
flutter --version
flutter doctor
flutter pub get
flutter analyze
flutter test
flutter devices
flutter run
```

Android emulatorünü başlatın veya USB hata ayıklaması açık bir cihaz bağlayın. Birden fazla cihaz varsa `flutter run -d <cihaz-id>` kullanın. Web için `flutter run -d chrome`. iOS çalıştırma ve derleme için macOS ve Xcode gerekir. Flutter bulunamıyorsa SDK'nın bin klasörünü PATH'e ekleyip terminali yeniden açın.

Analiz, test ve ekran görüntüsü üretimini sırayla çalıştırmak için:

```powershell
.\scripts\verify.ps1 -CaptureScreenshots
```

## Özellikler ve yapı

- `lib/main.dart`: JSON yükleme, hata/tekrar deneme ekranı, Material teması ve named route.
- `lib/models/product.dart`: Product modeli, fromJson/toJson ve kuruş tabanlı fiyat formatı.
- `lib/data/cart.dart`: ChangeNotifier ile ortak sepet, adet ve toplam yönetimi.
- `lib/screens/store.dart`: Ana sayfa, katalog, detay, sepet ve ürün kartları.
- `assets/products.json`: Sekiz yerel demo ürün.
- `assets/images/`: Sekiz ürün illüstrasyonu; ana sayfa bannerı da bu görselleri kullanır.
- `assets/fonts/`: Roboto yazı tipi ve lisansı.
- `test/cart_test.dart`: Adet, toplam, model ve fiyat dönüşümü.
- `test/widget_test.dart`: Ana sayfa açılışı.
- `test/store_flow_test.dart`: Görsel yükleme, katalog, birlikte çalışan arama/kategori filtresi, boş sonuç, detay, sepet, adet ve temizleme akışı.
- `scripts/verify.ps1`: Analiz/test çalıştırma ve isteğe bağlı ekran görüntüsü üretimi.

Navigator.push/pop ile sayfa geçişleri; Navigator.pushNamed(arguments: product) ile detay sayfasına ürün aktarımı yapılır. GridView ekran genişliğine göre 2/3/4 sütun gösterir. Sepet ListView.builder ile listelenir; uygulama yeniden başladığında sıfırlanır. Ek çalışma zamanı paketi kullanılmaz.

## Yönergedeki veri kaynakları

Yönerge banner ve ürün verileri için wantapi.com adreslerini örnekler. Bu çalışma ortamında bu adreslere erişim sağlanamadı. JSON simülasyonu ve Image.asset öğrenme hedeflerini karşılamak için yerel veriler ve yerel ürün görselleri kullanılır. Çevrimiçi API bağlantısı eklenmemiştir. Değerlendirici özellikle yönergedeki uzaktaki kaynakları şart koşuyorsa bu tercih ayrıca onaylatılmalıdır.

## Ekran görüntüleri

[Üretim adımları ve dosya listesi](docs/screenshots/README.md). Görüntüler henüz üretilmedi. Yukarıdaki doğrulama betiği başarılı çalışınca ana sayfa, katalog, detay ve dolu sepet için dört gerçek Flutter widget renderı üretir. Bunlar cihaz ekran görüntüsü değildir; Android cihazda çalıştırma ayrıca kontrol edilmelidir.

## Teslim durumu

[Yönerge karşılaştırması](docs/YONERGE_UYUM.md) ve [kabul kontrol listesi](docs/KONTROL_LISTESI.md).

**Public GitHub repository URL'i henüz yok.** Yönergeye göre public repository bağlantısı ve uygulama ekran görüntüleri olmadan teslim tamamlanmış sayılmaz. Analiz/test ve cihaz kontrolünü tamamlayın, gerçek ekran görüntülerini ekleyin, projeyi public repository olarak paylaşın ve bu bölüme repository bağlantısını yazın. Geçici tmp/ klasörü ve build çıktıları Git'e dahil edilmez.

İsteğe bağlı Android APK:

```powershell
flutter build apk --release
```

Çıktı: `build/app/outputs/flutter-apk/app-release.apk`. APK derlemesi bu ortamda çalıştırılmadı.
