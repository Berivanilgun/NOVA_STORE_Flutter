# Proje yönergesine uyum

Kaynak: Kullanıcının Downloads klasöründeki “Mobil Uygulama Geliştirme; Android _ iOS Proje Yönergesi.pdf”, 5 sayfa. Aşağıdaki değerlendirme PDF'nin metin katmanı ve proje dosyaları üzerinden yapılmıştır. PDF görsel düzeni ve örnek ekran resmi ayrıca render edilerek doğrulanamamıştır.

| Yönerge gereksinimi | Projedeki karşılığı | Durum |
| --- | --- | --- |
| Flutter ve Dart; ekstra paket kullanılmaması | pubspec.yaml yalnızca Flutter ve Flutter test SDK'larını içerir | Kaynakta mevcut |
| Ana sayfa, ürün listesi, ürün detayı | HomePage, CatalogPage, DetailPage | Kaynakta mevcut; çalışma kontrolü bekliyor |
| Stateless/Stateful widget ve temel UI | NovaApp, HomePage, CatalogPage, Card, ListTile, Row, Column vb. | Kaynakta mevcut |
| Navigator ve route arguments | push/pop, MaterialPageRoute, '/detail' ve Product argument | Kaynakta mevcut; akış testi eklendi |
| Model, fromJson/toJson ve JSON simülasyonu | Product ve assets/products.json | Kaynakta mevcut |
| Dinamik liste ve GridView | GridView.builder ve sepette ListView.builder | Kaynakta mevcut |
| Görseller ve asset yönetimi | Sekiz ürün PNG'si, Image.asset, pubspec asset kayıtları | Dosyaların varlığı kontrol edildi |
| Banner görseli | Ana sayfa bannerına üç ürün illüstrasyonu eklendi | Yerel alternatif; uzaktaki banner kullanılmadı |
| Arama ve filtreleme | Türkçe harf normalizasyonu ve kategori filtresi | Akış testi eklendi; çalıştırma bekliyor |
| Basit sepet state güncellemesi | ChangeNotifier, adet artır/azalt, toplam, temizleme | Birim ve akış testleri mevcut; çalıştırma bekliyor |
| Doğru proje klasörleme | lib/models, lib/data, lib/screens, assets, test, docs | Mevcut |
| README: ad, açıklama, Flutter sürümü, çalıştırma | README yeniden düzenlendi; Flutter 3.38.5 / Dart 3.10.4 sorguyla doğrulandı | Tamamlandı |
| Çalışan uygulama | Analiz, test ve Android cihaz/emulator doğrulaması | Ortam erişim kısıtları nedeniyle bekliyor |
| Uygulama ekran görüntüleri | Dört gerçek widget renderını üreten test ve betik | Hazır; PNG'ler henüz üretilmedi |
| Public GitHub repository URL'i | README teslim bölümü | Eksik; yayımlama yapılmadı |

## Veri kaynağı tercihi

PDF çevrimiçi banner ve ürün adreslerini örnekler, ayrıca JSON simülasyonu ve Image.asset kullanımını öğretir. Çevrimiçi adreslere bu ortamda erişilemedi. Uygulama yerel JSON ve özgün ürün illüstrasyonlarıyla çalışacak şekilde korunmuştur. Bu tercih uzaktaki API kullanımına eşdeğer olarak sunulmaz; değerlendirme özellikle verilen kaynakları istiyorsa uzaktaki entegrasyon ayrıca gerekir.

## Bu çalışmada tamamlananlar

- Bannerda mevcut ürün görselleri gösterildi.
- Android uygulama adı NOVA STORE olarak düzenlendi.
- Roboto fontu lisansıyla dahil edildi; uygulama ve ekran render testleri aynı fontu kullanır.
- Ürün görselleri, navigasyon, filtreler, detay ve sepet davranışlarını doğrulayan test eklendi.
- Başarısız analiz veya testte duran PowerShell doğrulama betiği eklendi.
- Ekran görüntülerinin gerçek Flutter ekranlarından üretilmesi hazırlandı.
- README ve teslim kontrol belgeleri güncellendi.
- Dart format lib test başarıyla çalıştırıldı.

## Doğrulama sınırları

Flutter sürümü doğrulandı. Flutter analiz/cihaz sorgusu SDK önbelleğine yazma kısıtında durdu; bağımlılık dosyaları da erişime kapalı. Dart analiz sunucusu kendi durum klasörüne erişemedi. Tarayıcı bağlantısı mevcut değil. Bu nedenle testlerin başarılı olduğu, uygulamanın cihazda çalıştığı veya ekran görüntülerinin üretildiği iddia edilmez.

Yerel bilgisayarda proje kökünden scripts/verify.ps1 -CaptureScreenshots çalıştırın. Çıktıları kontrol edin; Android çalıştırma kontrolünü ve public repository yayımlamasını tamamlayın. PDF'nin son maddesine göre repository URL'i ve ekran görüntüleri zorunludur.
