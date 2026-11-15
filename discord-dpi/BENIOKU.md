# Discord'a VPN'siz giriş (Windows)

Bu klasör [GoodbyeDPI](https://github.com/ValdikSS/GoodbyeDPI) kullanır. GoodbyeDPI bir VPN değildir:
trafiğin kendi internetinden gider, sadece operatörün engelleme filtresini (DPI + DNS) atlatır.
Hız düşmez, Discord uygulamasında da tarayıcıda da çalışır.

## Kullanım

1. Bu `discord-dpi` klasörünü bilgisayarına indir (GitHub'da **Code → Download ZIP**, sonra ZIP'i çıkart).
2. **`discord-baslat.cmd`** dosyasına çift tıkla → "Evet" de (yönetici izni ister).
   - İlk seferde GoodbyeDPI'ı kendisi indirir.
3. Siyah pencere açık kaldığı sürece Discord'u aç, girebilirsin.

### Her açılışta otomatik çalışsın istersen
- **`otomatik-kur.cmd`** → bir kere çalıştır, artık pencereye gerek yok.
- Geri almak için **`otomatik-kaldir.cmd`**.

## Sorun olursa
- Discord hâlâ açılmıyorsa: Discord'u tamamen kapat (sağ alttaki simgeden **Çık**), sonra tekrar aç.
- Tarayıcıda "Güvenli DNS" (DoH) kapalıysa ve yine olmuyorsa, `ortak.cmd` içindeki
  `--set-ttl 5` değerini `3` veya `4` yapıp deneyebilirsin.
- Antivirüs `WinDivert` dosyası için uyarı verebilir; bu GoodbyeDPI'ın kullandığı açık kaynak sürücüdür.
