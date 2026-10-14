# Proje yönergesine uyum

Kaynak: Kullanıcının Downloads klasöründeki “Mobil Uygulama Geliştirme; Android _ iOS Proje Yönergesi.pdf”, 5 sayfa. Önceki değerlendirme PDF'nin metin katmanı ve proje dosyaları üzerinden yapılmıştır; PDF'nin görsel düzeni ayrıca render edilerek doğrulanmamıştır.

Son proje doğrulaması: 15 Ekim 2026. [Ayrıntılı rapor](DOGRULAMA.md).

| Yönerge gereksinimi | Projedeki karşılığı | Durum |
| --- | --- | --- |
| Flutter ve Dart; ekstra paket kullanılmaması | pubspec.yaml yalnızca Flutter ve Flutter test SDK'larını içerir | Doğrulandı |
| Ana sayfa, ürün listesi, ürün detayı | HomePage, CatalogPage, DetailPage | Widget testleri ve Android emülatöründe doğrulandı |
| Stateless/Stateful widget ve temel UI | NovaApp, HomePage, CatalogPage, Card, ListTile, Row, Column vb. | Kaynakta mevcut |
| Navigator ve route arguments | push/pop, MaterialPageRoute, '/detail' ve Product argument | Akış testleri ve Android geri dönüşü doğrulandı |
| Model, fromJson/toJson ve JSON simülasyonu | Product ve assets/products.json | Model testi ve varlık yükleme başarılı |
| Dinamik liste ve GridView | GridView.builder ve sepette ListView.builder | Kaynakta mevcut; akışlar doğrulandı |
| Görseller ve asset yönetimi | Sekiz ürün PNG'si, Image.asset, pubspec asset kayıtları | Yükleme testi ve render kontrolü başarılı |
| Banner görseli | Ana sayfada üç ürün illüstrasyonu | Yerel alternatif; uzaktaki banner kullanılmadı |
| Arama ve filtreleme | Türkçe harf normalizasyonu ve kategori filtresi | Widget testleri ve Android emülatöründe doğrulandı |
| Basit sepet state güncellemesi | ChangeNotifier, adet artır/azalt, toplam, temizleme | Birim/akış testleri ve Android kontrolü başarılı |
| Doğru proje klasörleme | lib/models, lib/data, lib/screens, assets, test, docs | Mevcut |
| README: ad, açıklama, Flutter sürümü, çalıştırma | README ve doğrulama raporu | Güncellendi |
| Çalışan uygulama | Analiz, 6 test, release APK ve Android 14 Pixel 5 emülatörü | Başarılı |
| Uygulama ekran görüntüleri | Dört widget renderı ve sekiz Android emülatör görüntüsü | Üretildi ve görsel olarak kontrol edildi |
| Public GitHub repository URL'i | [NOVA_STORE_Flutter](https://github.com/Berivanilgun/NOVA_STORE_Flutter) | Public erişim doğrulandı; README'ye eklendi |

## Veri kaynağı tercihi

PDF çevrimiçi banner ve ürün adreslerini örnekler, ayrıca JSON simülasyonu ve Image.asset kullanımını öğretir. Proje yerel JSON ve ürün illüstrasyonlarıyla çalışır. Bu tercih uzaktaki API kullanımına eşdeğer değildir; değerlendirme özellikle verilen çevrimiçi kaynakları şart koşuyorsa ayrı entegrasyon gerekir.

## Doğrulama kapsamı

Analiz ve 6 test başarılıdır. Android release APK emülatöre kurulup ana sayfa, filtre/arama, detay, sepet ve geri dönüş akışları kontrol edildi. Normal ve %130 metin boyutundaki ekranlar incelendi. Fiziksel Android cihaz ve iOS doğrulaması yapılmadı; release APK mevcut Gradle ayarına göre debug anahtarıyla imzalanır.

Yerel doğrulamayı yeniden çalıştırmak için proje kökünden `scripts/verify.ps1 -CaptureScreenshots` kullanın. Android APK'yı `flutter build apk --release` ile yeniden üretebilirsiniz.
