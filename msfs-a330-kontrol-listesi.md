# MSFS 2024 – A330 (RR / Trent 700) Uçuş Kontrol Listesi

> Bu liste genel Airbus A330 prosedürlerine ve MSFS'te sık görülen sorunlara dayanır.
> YouTube videosu henüz analiz **edilmedi** (ağ erişimi kapalı). Video eklenince her adıma
> videonun ilgili dakikası ve ekran görüntüsü eklenecek.
>
> **Konum kısaltmaları:**
> - **OVHD** = tepe paneli (başınızın üstü)
> - **FCU** = ön camın altındaki uzun oto pilot paneli
> - **MCDU** = orta konsoldaki (pedestal) klavyeli ekranlar
> - **PED** = pedestal (iki koltuk arasındaki konsol)
> - **EFB** = yan taraftaki tablet

---

## 0. Uçmadan önce bir kez yapılacak ayarlar (bunların hepsi "AP'den çıkma" sorunlarıyla ilgili)

- [ ] **Joystick/yoke ölü bölgesi (deadzone):** MSFS → Kontroller → yunuslama (pitch) ve yatış (roll) eksenleri için %5–10.
      Airbus'ta sidestick'e küçük bir kuvvet bile gelirse oto pilot **kendiliğinden ayrılır**. Joystick tam ortada durmuyorsa AP'yi atar.
- [ ] **Çift atamaları temizleyin:** aynı eksen hem joystick'e hem gamepad'e ya da klavyeye atanmış olmasın. MSFS'te çakışan atamalar kırmızı görünür.
- [ ] **Yardımları kapatın:** Asistanlar → Pilotaj (Piloting) bölümünde *Auto-rudder*, *AI Auto-trim*, *Assisted Yoke* ve benzeri ayarlar **KAPALI** olsun. Bunlar Airbus'ın fly-by-wire sistemiyle kavga eder ve burnun kalkmasına yol açabilir.
- [ ] **Gaz ekseni:** gaz kolu detentlerinin (IDLE – CL – FLX/MCT – TOGA) yerleri uçağın kendi EFB'sinde ya da ayarlarında kalibre edilmiş olsun. Kalibre değilse uçak CLB detentini doğru algılamaz.
- [ ] **SimBrief:** EFB'ye SimBrief kullanıcı **ID**'nizi (Pilot ID) girin. Bu Navigraph/SimBrief hesap sayfasında yazar.

## 1. SimBrief'te plan

- [ ] Uçak tipi: **A333** (RR motorlu A330-300), kalkış ve varış meydanları girilir.
- [ ] **Cruise altitude'u elle zorlamayın:** "Auto" bırakın. Ağır uçağı çok yükseğe göndermek, irtifaya çıkınca hız kaybına ve burnun kalkmasına sebep olur (aşağıdaki sorun giderme kısmına bakın).
- [ ] **Generate Flight** butonuna basın. Not edin: rota, kalkış pisti, SID, CI (Cost Index), ZFW, yakıt (block fuel), cruise FL.
- [ ] IVAO'da uçacaksanız: SimBrief'ten **"File on IVAO"** ile planı gönderin.

## 2. Soğuk ve karanlık kokpitte elektrik ve APU

| # | Ne yapılacak | Nerede |
|---|---|---|
| 1 | BAT 1, BAT 2 (ve APU BAT) → **AUTO** | OVHD, ELEC paneli (sol orta) |
| 2 | EXT PWR varsa → **ON** (yeşil AVAIL yanıyorsa) | OVHD, ELEC |
| 3 | ADIRS 1-2-3 → **NAV** (hizalanması ~7–10 dk sürer, beklemeyin, devam edin) | OVHD, en sol üst |
| 4 | APU MASTER SW → **ON**, ~3 sn sonra APU START → **ON** | OVHD, alt orta |
| 5 | APU "AVAIL" yanınca APU BLEED → **ON** | OVHD, AIR COND paneli |
| 6 | Yakıt pompaları (tüm FUEL PUMP butonları) → ışıkları **sönük** (= açık) | OVHD, FUEL paneli |
| 7 | Işıklar: NAV/LOGO açık, BEACON motor çalıştırmadan önce açık | OVHD, en alt sıra |
| 8 | Transponder → STBY (kalkışta TA/RA), squawk kodu ATC'den | PED, ATC paneli |

> OVHD'de **sönük buton = normal/açık** demektir (Airbus "karanlık kokpit" mantığı). Beyaz "OFF" yanıyorsa sistem kapalıdır.

## 3. MCDU (FMS) programlama: sıra önemli

MCDU'da sol ve sağdaki tuşlara **LSK** denir (L1–L6 ve R1–R6).

1. **INIT A** (INIT tuşu): en kolayı EFB'den SimBrief'i **uplink** etmek. Elle yapacaksanız: FROM/TO (ör. LTFM/EDDF), FLT NBR, CRZ FL, CI.
2. **F-PLN** (F-PLN tuşu) → kalkış meydanına tıklayın → **DEPARTURE** → pist → SID → **TMPY INSERT** (sarı yazı, R6).
3. F-PLN'de **DISCONTINUITY** var mı bakın. Varsa satırı seçip CLR ile silin. *Discontinuity kalırsa oto pilot o noktada rotadan çıkar.*
4. **INIT B** / FUEL PRED: ZFW, ZFWCG, BLOCK fuel (SimBrief'teki değerler). Aynı yakıt ve yükü EFB'den uçağa da yükleyin, yoksa uçağın gerçek ağırlığı farklı olur.
5. **PERF** → TAKE OFF sayfası: V1, VR, V2 (EFB'deki performans hesaplayıcısından), FLEX TO TEMP, FLAPS/THS (ör. `1/UP0.5`), TRANS ALT.
6. **RAD NAV:** genelde otomatik ayarlanır, kontrol edin.
7. Son kontrol: kaptan (CPT) tarafındaki ND'de ARC/NAV modunda rota pembe çizgi halinde ve kesiksiz görünüyor mu?

## 4. Motor çalıştırma (videodaki adamın takıldığı yer)

Motorlar çalışmıyorsa **%90 ihtimalle sebep havadır (bleed):**

- [ ] APU çalışıyor ve **APU BLEED ON** (OVHD, AIR COND)
- [ ] **PACKS → OFF** (çalıştırırken havayı motorlara bırakmak için. Bazı modellerde otomatik)
- [ ] Yakıt pompaları açık, BEACON açık
- [ ] **ENG MODE seçicisi → IGN/START** (PED, gaz kollarının arkası)
- [ ] **ENG 2 MASTER → ON** (önce 2 numara, sağdaki), ECAM'de N2 artışını izleyin, motor rölantiye oturana kadar bekleyin (~1 dk)
- [ ] Sonra **ENG 1 MASTER → ON**
- [ ] İkisi de oturunca: ENG MODE → **NORM**, APU BLEED → **OFF**, PACKS → **ON**
- [ ] İsterseniz APU'yu kapatın (MASTER SW OFF)

Gaz kolları IDLE'da olmalı. Master switch'i açarken gaz IDLE'da değilse uçak çalıştırmaya izin vermeyebilir.

## 5. Kalkış

- [ ] Flaplar (PERF'te ne girdiyseniz), spoiler **ARM**, auto brake **MAX** (sadece kalkış için), TCAS TA/RA
- [ ] FD (Flight Director) **açık**: FCU'nun en solundaki FD butonu
- [ ] FCU: ilk irtifayı girin (SID'deki ya da ATC'nin verdiği), **çekmeyin** (pull yapmayın), hazırda dursun
- [ ] Gaz → **FLX/MCT** detenti (FLEX girdiyseniz) ya da **TOGA**. FMA'da (PFD'nin üst satırı) `MAN FLX 45 | SRS | RWY` yazmalı
- [ ] VR'de burnu yumuşakça ~15°'ye kaldırın, pozitif tırmanmada iniş takımını (GEAR) **UP** yapın
- [ ] **Thrust reduction altitude**'da FMA'da "LVR CLB" yanıp söner → gaz kollarını **CL** detentine çekin. *Bunu unutmak çok yaygın bir hatadır.* A/THR o zaman aktif olur.
- [ ] Uçak trimli ve sabit tırmanıyorken sidestick'i bırakın → **AP1** butonu (FCU ortası)

## 6. Tırmanış, seyir ve oto pilot mantığı (FCU)

- **Butona basmak (push)** = yönetimi FMS'e verir. Ekranda nokta (•) yanar, mod "managed" olur (örn. NAV, CLB).
- **Butonu çekmek (pull)** = siz seçersiniz, mod "selected" olur (örn. HDG, OP CLB).
- Yeni irtifaya tırmanmak için: ALT değerini değiştirin, sonra **push** (FMS'in kısıtlarına uyan CLB) ya da **pull** (direkt OP CLB).
- Rota takibi: HDG/TRK düğmesine **push** yaparsanız mod **NAV** olur.

## 7. İnişe hazırlık (TOD'dan yaklaşık 50 NM önce)

1. ATIS'ten ya da IVAO ATC'den aktif pisti öğrenin.
2. MCDU **F-PLN** → varış meydanı → **ARRIVAL** → pist (örn. ILS 25R) → VIA → STAR → TMPY INSERT. **Discontinuity'leri temizleyin.**
3. **PERF → APPR** sayfası: QNH, TEMP, WIND (MAG), MINIMUMS (BARO/RADIO), LDG CONF (CONF 3 ya da FULL).
4. RAD NAV: ILS frekansı ve kursu (genelde otomatik gelir, kontrol edin).
5. ND'de TOD okunu (beyaz ok) gördüğünüzde: FCU'da ALT'ı düşürün, **push** → DES. (Pull yaparsanız OP DES olur, kısıtlara uymaz.)
6. Auto brake: LO ya da MED.

## 8. Yaklaşma ve iniş

- [ ] ~15 NM: **PERF APPR sayfasını aktive edin** (DECEL noktasından önce, `ACTIVATE APPR PHASE` → CONFIRM) ya da DECEL'de otomatik olsun
- [ ] Hız düşerken flapları kademe kademe açın: PFD'de **S**, **F** işaretleri göründükçe ya da hız "green dot"un altına inerken. Flap 1 → 2 → GEAR DOWN → 3 → FULL
- [ ] **LOC** butonu ya da **APPR** butonu (FCU): ILS için APPR'a basın, ardından **AP2**'yi de açın (CAT3 DUAL için)
- [ ] Glideslope yakalanınca (G/S*) ALT'ı pas geçme (go-around) irtifasına ayarlayın
- [ ] Spoiler ARM, iniş takımı yeşil 3 ışık, flap FULL (ya da CONF 3)
- [ ] Minimumlarda ya da daha önce AP'yi kapatın (sidestick'teki kırmızı buton ya da FCU'daki AP butonu) ve elle indirin, **ya da** oto inişe bırakın
- [ ] "RETARD" uyarısını duyunca gaz kollarını **IDLE**'a çekin. Yere değince reverser verin, 80 kt'da reverser'ı kapatın

---

## SORUN GİDERME: "Uçak rotaya oturmuşken birden AP'den çıkıyor ve burnu dikeliyor"

En olası sebepten başlayarak:

1. **Joystick oto pilotu "eziyor".** Sidestick'te ölü bölge yoksa ya da stick tam ortada değilse, küçük bir sinyal bile AP'yi ayırır. Joystick biraz geride duruyorsa burun da kalkar. → Ölü bölgeyi artırın. Uçarken joystick'e dokunmayın. Kontroller menüsünde eksenin tam 0'da durduğunu görün.
2. **Gaz kolu CL detentinde değil.** LVR CLB'de kolları çekmezseniz ya da gaz ekseni titreşirse, A/THR ayrılır ya da hız kontrolden çıkar. Hız düşerken uçak irtifayı korumak için burnu kaldırır, sonra koruma modlarına (alpha floor, high AoA) girer ve AP ayrılır. → FMA'nın ilk sütununda `THR CLB` / `SPEED` ve en sağda `A/THR` beyaz yazıyor mu kontrol edin.
3. **Uçak çok ağır ya da çok yüksek.** SimBrief'te FL410 gibi bir irtifa seçip uçağa ağır yük koyduysanız, uçak o irtifada tırmanamaz ve hız kaybeder. Ayrıca EFB'den yük ve yakıtı uçağa yüklemediyseniz MCDU'daki ağırlık ile gerçek ağırlık farklı olur. → Cruise'u SimBrief'te "Auto" bırakın, MCDU'da PROG sayfasında **REC MAX** irtifayı kontrol edin.
4. **MSFS asistanları açık.** Auto-trim ya da assisted controls açık kalmışsa fly-by-wire sistemiyle çakışır. → Hepsini kapatın.
5. **Flight planında discontinuity ya da bitmiş rota.** Rota bittiğinde ya da discontinuity'e gelindiğinde NAV modu düşer, uçak HDG'ye geçer. Bu burnu kaldırmaz ama "rotadan çıktı" hissi verir.
6. **Klavye kısayolu ya da çift atama.** Bir tuş yanlışlıkla "AP disconnect" ya da "pitch up" eylemine atanmış olabilir, özellikle gamepad bağlıysa. → Kontrollerde arama yapıp temizleyin.

**Olay anında yapılacaklar:** PFD'nin üstündeki FMA satırının fotoğrafını (ekran görüntüsünü) alın ve ECAM'de (orta alt ekran) ne yazdığına bakın. Bu iki bilgi sebebi neredeyse her zaman gösterir. Bana gönderirseniz birlikte bakarız.

---

## IVAO'ya geçiş için kısa not

- IVAO hesabı → **Altitude** (pilot yazılımı) kurun, MSFS 2024 desteği var.
- Uçuşa başlamadan **IVAO Academy**'deki "Pilot Basics" eğitimlerine bir göz atın. Telsiz konuşmalarının kalıpları orada var.
- İlk birkaç uçuşu az trafikli saatlerde ve ATC'nin az olduğu meydanlarda yapın. Ya da bir "Training" talebi açın.
