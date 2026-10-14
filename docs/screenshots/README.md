# Ekran görüntüleri

Bu klasörde henüz uygulamadan alınmış PNG bulunmuyor. Görseller oluşturulduktan sonra teslim edilebilir.

Proje kökünde çalıştırın:

```powershell
.\scripts\verify.ps1 -CaptureScreenshots
```

Komut analiz ve testler başarılı olursa Flutter'ın gerçek widget ağacını 390 × 844 boyutunda render ederek dört PNG üretir:

- home.png: Ana sayfa ve ürün görselleri bulunan banner.
- catalog.png: Sekiz ürünün bulunduğu katalog.
- detail.png: Studio Kulaklık detayı.
- cart.png: Bir ürün içeren sepet ve toplam.

Bunlar widget testinden alınan gerçek uygulama renderlarıdır; Android cihaz ekran görüntüsü değildir. Teslimde cihaz görüntüsü isteniyorsa uygulamayı Android cihaz/emulatörde açıp aynı ekranları ayrıca kaydedin. PNG dosyalarını görsel olarak kontrol edin ve GitHub'a yükleyin.
