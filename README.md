# PRIVACY_GUARDIAN
Windows işletim sisteminizde gizliliğinizi korumak için geliştirilmiş kapsamlı bir araç. Telemetri, izleme, Recall ve diğer gizlilik ayarlarını kolayca yönetin.

📋 Özellikler
Privacy Guardian aşağıdaki gizlilik özelliklerini yönetmenizi sağlar:
🎯 Ana Özellikler

📊 Telemetri Kontrolü: Microsoft'a gönderilen kullanım verilerini durdurma
💬 Geri Bildirim Bildirimleri: Rahatsız edici Windows anketlerini kapatma
🎯 Reklam Kimliği: Kişiselleştirilmiş reklam takibini engelleme
🔍 Diagnostic Takip: DiagTrack servislerini temizleme
📋 Etkinlik Geçmişi: Dosya ve web aktivite kaydını durdurma
📍 Konum Takibi: Konum bazlı izlemeyi engelleme
🤖 Windows Recall: AI tabanlı ekran görüntüsü özelliğini yönetme

🔧 Ek Özellikler

✅ Otomatik Durum Tespiti: Her özelliğin mevcut durumunu gösterir
✅ Akıllı Onay Sistemi: Sadece açık olan özellikler için onay ister
✅ Detaylı Açıklamalar: Her özelliğin ne işe yaradığını anlatır
✅ Güvenli İşlemler: Registry değişiklikleri güvenli şekilde yapılır
✅ Geri Dönüşümlü: İsterseniz özellikleri tekrar açabilirsiniz

🚀 Kurulum
Gereksinimler

Windows 10 veya Windows 11
Yönetici (Administrator) hakları

İndirme

Releases sayfasından en son sürümü indirin
ZIP dosyasını çıkarın
PrivacyGuardian.bat dosyasına sağ tıklayın
"Yönetici olarak çalıştır" seçeneğini tıklayın

📖 Kullanım
Başlangıç
Program başladığında otomatik olarak Windows Recall özelliğini kontrol eder ve kapalı değilse kapatmak isteyip istemediğinizi sorar.
Ana Menü
[1] Tum telemetri ve izleme ayarlarini kapat (Tavsiye edilen)
[2] Sadece temel telemetriyi kapat
[3] Sadece diagnostic veri toplamayi kapat
[4] Sadece reklam kimligini kapat
[5] Windows Recall ozelligini yonet
[6] Mevcut durum kontrolu
[7] Cikis
Önerilen Kullanım

İlk Kullanım: Seçenek [1] ile tüm özellikleri gözden geçirin
Her özellik için detaylı açıklama okuyun
Kapatmak istediğiniz özellikleri onaylayın
İşlem sonunda bilgisayarınızı yeniden başlatın

Özel Yönetim

Recall Yönetimi: Menü [5] ile Windows Recall'u ayrıca yönetebilirsiniz
Durum Kontrolü: Menü [6] ile tüm ayarların durumunu görüntüleyin

⚙️ Yapılan Değişiklikler
Registry Değişiklikleri
Program aşağıdaki registry anahtarlarını değiştirir:
Telemetri
HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection
HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection
Reklam Kimliği
HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo
HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo
Windows Recall
HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI
HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsAI
Etkinlik Geçmişi
HKLM\SOFTWARE\Policies\Microsoft\Windows\System
Konum Servisleri
HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors
⚠️ Önemli Notlar
Dikkat Edilmesi Gerekenler

⚠️ Yönetici Hakları: Program mutlaka yönetici olarak çalıştırılmalıdır
⚠️ Yeniden Başlatma: Değişikliklerin tam etkili olması için sistem yeniden başlatılmalıdır
⚠️ Konum Servisleri: Konum takibini kapatırsanız bazı uygulamalar çalışmayabilir
⚠️ Sistem Güncellemeleri: Bazı Windows güncellemeleri bu ayarları sıfırlayabilir

Geri Alma
Tüm değişiklikler geri alınabilir. İlgili menü seçeneğinden özellikleri tekrar açabilirsiniz.
🔒 Güvenlik

✅ Açık kaynak kodlu - Kodu inceleyebilirsiniz
✅ Sadece Windows registry değişiklikleri yapar
✅ Hiçbir dış sunucuya bağlanmaz
✅ Kişisel veri toplamaz
✅ Reklam veya izleyici içermez
