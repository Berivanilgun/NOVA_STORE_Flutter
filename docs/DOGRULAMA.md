# Doğrulama raporu

Tarih: 15 Ekim 2026.

## Ortam ve sonuçlar

- Flutter 3.38.5 stable / Dart 3.10.4; Windows üzerinde doğrulandı.
- `flutter pub get`: başarılı.
- `flutter analyze`: `No issues found!`.
- `flutter test`: `+6: All tests passed!`.
- `scripts/verify.ps1 -CaptureScreenshots`: başarılı; dört widget renderı üretildi ve incelendi.
- `flutter build apk --release`: başarılı; 44,7 MB APK üretildi.
- `adb install -r`: başarılı; release APK Pixel 5 emülatörüne kuruldu.
- Android 14 / API 34; ekran 1080 × 2340, yoğunluk 440 dpi.
- Uygulama `com.example.nova_store/.MainActivity` ile başlatıldı.
- Emülatörün grafik çizimindeki aralıklı ikon kaybını kontrol etmek için ekran kayıtları `--ez enable-impeller false` başlatma seçeneğiyle de tekrar alındı. Bazı kayıtlarda uygulama çubuğundaki geri/sepet öğeleri aralıklı olarak görünmemeye devam etti; erişilebilirlik ağacında mevcut oldukları ve dokunuşlarının çalıştığı doğrulandı. Bu seçenek uygulamanın kaynak yapılandırmasını değiştirmez. Bu görsel durum tamamen giderilmiş sayılmaz; fiziksel cihazda grafik çizimi ayrıca kontrol edilmelidir.

APK: `build/app/outputs/flutter-apk/app-release.apk`. Build çıktıları Git'e dahil edilmez. Mevcut release yapılandırması debug anahtarıyla imzalama kullanır.

## Test düzeltmesi

Akış testleri daha önce `openStore` içinde `pumpAndSettle timed out` hatası veriyordu. JSON'u önceden yüklemek uygulamanın açılış future'ının testin sanal zamanında tamamlanmasını sağlamıyordu. Açılış artık `tester.runAsync` içinde çalışır; görseller de gerçek asenkron zamanda `precacheImage` ile hazır edilir. `pumpAndSettle` ardından animasyon karelerini tamamlar.

Görsel doğrulama sırasında widget renderlarında eksik ikonlar ve yüklenmemiş bir ürün görseli görüldü. MaterialIcons fontunun açıkça yüklenmesi ve tüm ürün görsellerinin önbelleğe alınması bu sorunları giderdi. Görüntüler sayfa geçişinin son karesinde alınır.

Ek test %130 metin boyutunda katalog ve detaydan ortak sepete eklemeyi, demo açıklamasını, son ürünün kaldırılmasını ve dolu sepetin uygulama yeniden oluşturulduğunda sıfırlanmasını doğrular. Testler render/layout istisnası bulunmadığını da kontrol eder.

## Android üzerinde kontrol edilen akış

Release APK ile ADB dokunuşları ve UIAutomator erişilebilirlik ağacı kullanıldı; görünen metinler her aşamada kontrol edildi.

1. Ana sayfa açıldı, katalogda `8 ürün` görüldü.
2. Elektronik filtresinde `2 ürün`, `kulak` aramasında `1 ürün` görüldü.
3. Eşleşmeyen aramada boş sonuç mesajı görüldü; arama temizlenince `2 ürün` geri geldi.
4. Studio Kulaklık detayında doğru görsel, açıklama ve `1499,00 TL` görüldü.
5. Sepete ekleme sonrasında toplam `1499,00 TL`; adet artırılınca `2998,00 TL`, azaltılınca `1499,00 TL` oldu.
6. Demo açıklamasında ödeme alınmadığı doğrulandı.
7. Temizleme iptali toplamı korudu; temizleme onayı boş sepet mesajını gösterdi.
8. Geri dönüşle detay, katalog ve ana sayfaya ulaşıldı. Arama alanı odaklıysa Android geri tuşu önce klavyeyi kapatabilir; uygulama çubuğundaki geri düğmesi sayfadan çıkar.
9. Dolu sepetle uygulama zorla durdurulup yeniden açıldı; `Sepet (0)` görüldü.
10. Sistem metin ölçeği 1,3 yapılarak dört ekran açıldı, sepete ekleme ve toplam doğrulandı. Ardından önceki sistem metin ölçeği geri yüklendi.

Normal ve büyük metindeki sekiz Android görüntüsü ile dört widget renderı [ekran görüntüleri klasöründe](screenshots/README.md) bulunur ve görsel olarak incelendi.

## Kapsam

Fiziksel Android cihaz, iOS, mağaza imzalaması ve tüm ekran/metin ölçekleri bu doğrulamaya dahil değildir. Yerel JSON ve görseller kullanılır; uzak API entegrasyonu eklenmemiştir. GitHub deposunun public olduğu GitHub repository API yanıtındaki `private: false` alanıyla kontrol edildi.
