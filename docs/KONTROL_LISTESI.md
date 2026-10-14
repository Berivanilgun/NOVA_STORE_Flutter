# Yerel kabul ve teslim kontrolü

Son doğrulama: 15 Ekim 2026. Ayrıntılar: [doğrulama raporu](DOGRULAMA.md).

## Kaynak ve otomatik kontroller

- [x] Sekiz ürün görseli mevcut; JSON'daki yollar ve pubspec varlık kayıtları eşleşiyor.
- [x] Ana sayfa bannerında yerel ürün görselleri kullanılıyor.
- [x] README: proje adı, açıklama, sürüm, GitHub bağlantısı ve çalıştırma adımları mevcut.
- [x] Flutter 3.38.5 / Dart 3.10.4 sürümleri sorguyla doğrulandı.
- [x] `flutter pub get` ve `flutter analyze` başarılı.
- [x] `flutter test`: 6 testin tamamı başarılı.
- [x] Testlerdeki açılış zaman aşımı giderildi; kaynaklar biçimlendirildi.
- [x] Widget ekran görüntülerinde ikon fontu ve tüm ürün görselleri yükleniyor.
- [x] Katalog ve detaydan eklenen ürünler aynı sepette toplanıyor.
- [x] Son adet kaldırıldığında ürün siliniyor; dolu sepet uygulama yeniden başlatıldığında sıfırlanıyor.
- [x] %130 metin ölçeğindeki ortak sepet ve demo akışı widget testinde geçiyor.

## Android emülatör kontrolü

Pixel 5, Android 14; release APK kullanıldı.

- [x] Ana sayfadan katalog açılıyor; geri tuşuyla detay → katalog → ana sayfa dönüşü çalışıyor.
- [x] Sekiz ürün kayıtlı; kategori filtresi ve arama birlikte çalışıyor.
- [x] Boş arama sonucu ve arama temizleme doğru çalışıyor.
- [x] Detayda ürün görseli, açıklama ve fiyat görünüyor.
- [x] Ürün sepete ekleniyor; artır/azalt toplamı değiştiriyor.
- [x] Temizleme iptali sepeti koruyor; onay sepeti boşaltıyor.
- [x] Demo sepet gerçek ödeme oluşturulmadığını açıklıyor.
- [x] Uygulama yeniden başlatıldığında sepet sıfırlanıyor.
- [x] Normal ve %130 metin ölçeğindeki dört ekran görsel olarak kontrol edildi.
- [x] `flutter build apk --release` başarılı; APK emülatöre kuruldu ve açıldı.

## Teslim çıktıları

- [x] Dört widget renderı `docs/screenshots/` klasörüne eklendi.
- [x] Normal ve büyük metin için sekiz gerçek Android görüntüsü `docs/screenshots/android/` klasörüne eklendi.
- [x] [GitHub deposu](https://github.com/Berivanilgun/NOVA_STORE_Flutter) public olarak erişilebilir.
- [x] Repository URL'i ve ekran görüntüleri README'de yer alıyor.

Fiziksel Android cihaz ve iOS bu ortamda test edilmedi. Emülatör kontrolü tüm cihazlarda doğrulama anlamına gelmez. Release APK mevcut Gradle ayarına göre debug anahtarıyla imzalanır; mağaza dağıtımı için ayrı imzalama gerekir.
