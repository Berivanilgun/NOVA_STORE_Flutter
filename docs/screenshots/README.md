# Ekran görüntüleri

15 Ekim 2026 tarihinde görüntüler üretildi ve görsel olarak kontrol edildi.

## Android emülatöründen alınan görüntüler

Pixel 5 emülatörü, Android 14, 1080 × 2340 piksel. Release APK kurularak gerçek Android ekranlarından `adb shell screencap` ile kaydedildi.

| Ekran | Normal metin | %130 metin |
| --- | --- | --- |
| Ana sayfa | [home.png](android/home.png) | [home-large-text.png](android/home-large-text.png) |
| Katalog | [catalog.png](android/catalog.png) | [catalog-large-text.png](android/catalog-large-text.png) |
| Ürün detayı | [detail.png](android/detail.png) | [detail-large-text.png](android/detail-large-text.png) |
| Dolu sepet | [cart.png](android/cart.png) | [cart-large-text.png](android/cart-large-text.png) |

Emülatör kayıtlarında bazı uygulama çubuğu öğelerinin aralıklı çizim kaybı gözlendi; ayrıntılar [doğrulama raporunda](../DOGRULAMA.md). Görüntüler ham cihaz kayıtlarıdır.

Katalog kaydırılabilir; ekran görüntüsü sekiz ürünün tamamını aynı anda göstermez. Büyük metin boyutunda detay içeriğine kaydırarak erişilir.

Yeni bir cihaz görüntüsü almak için uygulamayı ilgili ekranda açın. ADB cihaz kimliğini `adb devices` ile bulun, ardından:

```powershell
adb -s <cihaz-id> shell screencap -p /sdcard/nova-screen.png
adb -s <cihaz-id> pull /sdcard/nova-screen.png docs/screenshots/android/home.png
```

## Flutter widget renderları

390 × 844 boyutundaki [home.png](home.png), [catalog.png](catalog.png), [detail.png](detail.png) ve [cart.png](cart.png) Flutter widget testinden üretilmiştir. Bunlar Android cihaz görüntülerinden ayrı tutulur.

Yeniden üretmek için proje kökünde:

```powershell
.\scripts\verify.ps1 -CaptureScreenshots
```

Betik önce bağımlılıkları, analizi ve tüm testleri çalıştırır. Başarılı olursa ikon fontunu ve ürün görsellerini yükleyen akış testi dört PNG'yi günceller. Güncellenen görselleri tekrar kontrol edin.
