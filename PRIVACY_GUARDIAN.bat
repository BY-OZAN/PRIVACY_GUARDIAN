@echo off
setlocal enabledelayedexpansion
:: Bu batch dosyasi Windows izleme ayarlarini ve Recall ozelligini yonetir.
:: Yonetici haklari gerektirir.
:: Hazirlayan: AI Assistant
title Privacy Guardian - Windows Gizlilik Koruma Araci

:: Ekran rengini degistir (Mor arka plan + Beyaz yazi)
color 0b

:: Yonetici kontrolu
fltmc >nul 2>&1 || (
    echo Bu script yonetici haklari gerektiriyor.
    powershell -command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

cls

:: ASCII Sanat - PRIVACY GUARDIAN
echo.
echo  PRIVACY GUARDIAN v2.0
echo.
echo.



echo.
echo ========================================================================
echo.
timeout /t 2 >nul

:menu
cls
echo.
echo ===================== ANA MENU =====================
echo.
echo [1] Tum telemetri ve izleme ayarlarini kapat (Tavsiye edilen)
echo [2] Sadece temel telemetriyi kapat
echo [3] Sadece diagnostic veri toplamayi kapat
echo [4] Sadece reklam kimligini kapat
echo [5] Windows Recall ozelligini yonet
echo [6] Mevcut durum kontrolu
echo [7] Cikis
echo.
echo ====================================================
echo.
set /p secim=Lutfen bir secim yapin (1-7): 

if "%secim%"=="1" goto all
if "%secim%"=="2" goto basic
if "%secim%"=="3" goto diagnostic
if "%secim%"=="4" goto adid
if "%secim%"=="5" goto recall_menu
if "%secim%"=="6" goto status_check
if "%secim%"=="7" goto exit_app

echo.
echo [!] Gecersiz secim. Lutfen 1-7 arasinda bir sayi girin.
timeout /t 2 >nul
goto menu

:exit_app
cls
echo.
echo  PRIVACY GUARDIAN v2.0
echo.
echo                  Gizliliginizi korumak icin tesekkur ederiz!
echo.
timeout /t 3 >nul
exit

:all
cls
echo.
echo ========================================================================
echo              GELISMIS GIZLILIK AYARLARI YAPILANDIR
echo ========================================================================
echo.
echo Asagidaki ozellikleri tek tek kapatabilirsiniz.
echo Her ozellik icin size aciklama yapilacak ve onay alinacak.
echo.
pause

:: 1. Telemetri
cls
echo.
echo ========================================================================
echo [1/6] TELEMETRI VERILERI
echo ========================================================================
echo.
echo Bu ozellik ne yapar?
echo - Microsoft'a sistem kullanim verileri gonderir
echo - Hata raporlari ve performans bilgileri toplar
echo - Windows deneyimi iyilestirme programina katilmanizi saglar
echo.
echo Kapatildiginda:
echo - Microsoft'a otomatik veri gonderimi durdurulur
echo - Gizliliginiz artar
echo - Sistem performansi hafif duzeyde artabilir
echo.

:: Telemetri durumunu kontrol et
set "telemetry_status=ACIK"
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry ^| findstr "AllowTelemetry"') do (
        if "%%a"=="0x0" set "telemetry_status=KAPALI"
    )
)

echo [DURUM] Telemetri simdi: %telemetry_status%
echo.

if "%telemetry_status%"=="KAPALI" (
    echo [OK] Bu ozellik zaten kapali durumda.
    echo.
    pause
) else (
    set /p telemetry_choice="Bu ozelligi kapatmak istiyor musunuz? (E/H): "
    if /i "!telemetry_choice!"=="E" (
        echo.
        echo [*] Telemetri verileri kapatiliyor...
        reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
        reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v MaxTelemetryAllowed /t REG_DWORD /d 0 /f >nul
        echo [OK] Telemetri kapatildi.
    ) else (
        echo [!] Telemetri acik birakildi.
    )
    echo.
    pause
)

:: 2. Geri Bildirim
cls
echo.
echo ========================================================================
echo [2/6] GERI BILDIRIM BILDIRIMLERI
echo ========================================================================
echo.
echo Bu ozellik ne yapar?
echo - Windows'un size geri bildirim sorusu sormasini saglar
echo - "Windows'u nasil buluyorsunuz?" turu bildirimler gosterir
echo - Anketler ve degerlendirme popup'lari acar
echo.
echo Kapatildiginda:
echo - Rahatsiz edici popup'lar duracak
echo - Daha temiz bir masaustu deneyimi yasarsiniz
echo - Bildirim merkezi daha sakin olur
echo.

:: Geri bildirim durumunu kontrol et
set "feedback_status=ACIK"
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications ^| findstr "DoNotShowFeedbackNotifications"') do (
        if "%%a"=="0x1" set "feedback_status=KAPALI"
    )
)

echo [DURUM] Geri bildirim bildirimleri simdi: %feedback_status%
echo.

if "%feedback_status%"=="KAPALI" (
    echo [OK] Bu ozellik zaten kapali durumda.
    echo.
    pause
) else (
    set /p feedback_choice="Bu ozelligi kapatmak istiyor musunuz? (E/H): "
    if /i "!feedback_choice!"=="E" (
        echo.
        echo [*] Geri bildirim bildirimleri kapatiliyor...
        reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f >nul
        echo [OK] Geri bildirim bildirimleri kapatildi.
    ) else (
        echo [!] Geri bildirim bildirimleri acik birakildi.
    )
    echo.
    pause
)

:: 3. Reklam Kimligi
cls
echo.
echo ========================================================================
echo [3/6] REKLAM KIMLIGI
echo ========================================================================
echo.
echo Bu ozellik ne yapar?
echo - Size ozel bir reklam kimlik numarasi atar
echo - Uygulamalar bu kimlikle sizin ilginizi takip eder
echo - Kisisellestirilmis reklamlar gosterilmesini saglar
echo.
echo Kapatildiginda:
echo - Uygulamalar sizi reklam amacli takip edemez
echo - Kisisellestirilmis reklamlar duracak
echo - Gizliliginiz onemli olcude artar
echo.

:: Reklam kimligi durumunu kontrol et
set "adid_status=ACIK"
reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=3" %%a in ('reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled ^| findstr "Enabled"') do (
        if "%%a"=="0x0" set "adid_status=KAPALI"
    )
)

echo [DURUM] Reklam kimligi simdi: %adid_status%
echo.

if "%adid_status%"=="KAPALI" (
    echo [OK] Bu ozellik zaten kapali durumda.
    echo.
    pause
) else (
    set /p adid_choice="Bu ozelligi kapatmak istiyor musunuz? (E/H): "
    if /i "!adid_choice!"=="E" (
        echo.
        echo [*] Reklam kimligi kapatiliyor...
        reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f >nul
        reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul
        echo [OK] Reklam kimligi kapatildi.
    ) else (
        echo [!] Reklam kimligi acik birakildi.
    )
    echo.
    pause
)

:: 4. Diagnostic Takip
cls
echo.
echo ========================================================================
echo [4/6] DIAGNOSTIC TAKIP (DiagTrack)
echo ========================================================================
echo.
echo Bu ozellik ne yapar?
echo - Sistem hatalarini ve performans verilerini toplar
echo - Windows'un sizi nasil kullandiginizi kaydeder
echo - Teknik tani verileri Microsoft'a iletir
echo.
echo Kapatildiginda:
echo - Arka planda calisan takip servisleri temizlenir
echo - Gizlilik seviyeniz yukselir
echo - Sistem kaynaklari birakilir
echo.

:: Diagnostic takip durumunu kontrol et
set "diag_status=ACIK"
reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" >nul 2>&1
if %errorlevel% neq 0 (
    set "diag_status=KAPALI"
)

echo [DURUM] Diagnostic takip simdi: %diag_status%
echo.

if "%diag_status%"=="KAPALI" (
    echo [OK] Bu ozellik zaten kapali/temizlenmis durumda.
    echo.
    pause
) else (
    set /p diag_choice="Bu ozelligi kapatmak istiyor musunuz? (E/H): "
    if /i "!diag_choice!"=="E" (
        echo.
        echo [*] Diagnostic takip temizleniyor...
        reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /f >nul 2>&1
        echo [OK] Diagnostic takip temizlendi.
    ) else (
        echo [!] Diagnostic takip acik birakildi.
    )
    echo.
    pause
)

:: 5. Etkinlik Gecmisi
cls
echo.
echo ========================================================================
echo [5/6] ETKINLIK GECMISI
echo ========================================================================
echo.
echo Bu ozellik ne yapar?
echo - Hangi dosyalari actiginizi kaydeder
echo - Hangi web sitelerini ziyaret ettiginizi takip eder
echo - Bu verileri Microsoft hesabinizla senkronize eder
echo - Zaman cizelgesi ozelligini besler
echo.
echo Kapatildiginda:
echo - Etkinlik gecmisiniz toplanmaz
echo - Microsoft sunucularina gonderilmez
echo - Daha gizli bir kullanim deneyimi yasarsiniz
echo.

:: Etkinlik gecmisi durumunu kontrol et
set "activity_status=ACIK"
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities ^| findstr "PublishUserActivities"') do (
        if "%%a"=="0x0" set "activity_status=KAPALI"
    )
)

echo [DURUM] Etkinlik gecmisi simdi: %activity_status%
echo.

if "%activity_status%"=="KAPALI" (
    echo [OK] Bu ozellik zaten kapali durumda.
    echo.
    pause
) else (
    set /p activity_choice="Bu ozelligi kapatmak istiyor musunuz? (E/H): "
    if /i "!activity_choice!"=="E" (
        echo.
        echo [*] Etkinlik gecmisi kapatiliyor...
        reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /t REG_DWORD /d 0 /f >nul
        reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v UploadUserActivities /t REG_DWORD /d 0 /f >nul
        echo [OK] Etkinlik gecmisi kapatildi.
    ) else (
        echo [!] Etkinlik gecmisi acik birakildi.
    )
    echo.
    pause
)

:: 6. Konum Takibi
cls
echo.
echo ========================================================================
echo [6/6] KONUM TAKIBI
echo ========================================================================
echo.
echo Bu ozellik ne yapar?
echo - Bilgisayarinizin fiziksel konumunu belirler
echo - Uygulamalarin konum bilgileriniz erismesine izin verir
echo - Hava durumu, haritalar gibi servislere konum saglar
echo.
echo Kapatildiginda:
echo - Konum tabanli izleme durdurulur
echo - Uygulamalar nerede oldugunuzu bilemez
echo - Daha gizli bir kullanim deneyimi yasarsiniz
echo.
echo DIKKAT: Bazi konum tabanli uygulamalar calismayabilir!
echo.
set /p location_choice="Bu ozelligi kapatmak istiyor musunuz? (E/H): "
if /i "%location_choice%"=="E" (
    echo.
    echo [*] Konum takibi kapatiliyor...
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v DisableLocation /t REG_DWORD /d 1 /f >nul
    echo [OK] Konum takibi kapatildi.
) else (
    echo [!] Konum takibi acik birakildi.
)
echo.

:: Ozet
cls
echo.
echo ========================================================================
echo                    ISLEM TAMAMLANDI!
echo ========================================================================
echo.
echo Secimleriniz basariyla uygulandi.
echo.
echo Degisikliklerin tamamen etkili olmasi icin bilgisayarinizi 
echo yeniden baslatmaniz oneriliyor.
echo.
pause
goto menu

:basic
cls
echo.
echo [*] Temel telemetri kapatiliyor...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
echo.
echo [OK] Temel telemetri kapatildi.
echo.
pause
goto menu

:diagnostic
cls
echo.
echo [*] Diagnostic veri toplama kapatiliyor...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v MaxTelemetryAllowed /t REG_DWORD /d 0 /f >nul
echo.
echo [OK] Diagnostic veri toplama kapatildi.
echo.
pause
goto menu

:adid
cls
echo.
echo [*] Reklam kimligi kapatiliyor...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul
echo.
echo [OK] Reklam kimligi kapatildi.
echo.
pause
goto menu

:recall_menu
cls
echo.
echo ================== RECALL YONETIMI ==================
echo.
echo [1] Recall ozelligini kapat
echo [2] Recall ozelligini ac
echo [3] Recall durumunu kontrol et
echo [4] Ana menuye don
echo.
echo ====================================================
echo.
set /p recall_sec=Lutfen bir secim yapin (1-7): 

if "%recall_sec%"=="1" goto recall_disable
if "%recall_sec%"=="2" goto recall_enable
if "%recall_sec%"=="3" goto recall_status
if "%recall_sec%"=="4" goto menu

echo.
echo [!] Gecersiz secim.
timeout /t 2 >nul
goto recall_menu

:recall_disable
cls
echo.
echo [*] Recall ozelligi kapatiliyor...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v DisableAIDataAnalysis /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v DisableAIDataAnalysis /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v TurnOffSavingSnapshots /t REG_DWORD /d 1 /f >nul
echo.
echo [OK] Recall ozelligi kapatildi.
echo.
echo Not: Degisikliklerin etkili olmasi icin bilgisayarinizi yeniden baslatmaniz gerekebilir.
echo.
pause
goto recall_menu

:recall_enable
cls
echo.
echo [*] Recall ozelligi aciliyor...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v DisableAIDataAnalysis /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v DisableAIDataAnalysis /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v TurnOffSavingSnapshots /f >nul 2>&1
echo.
echo [OK] Recall ozelligi acildi.
echo.
pause
goto recall_menu

:recall_status
cls
echo.
echo [*] Recall durumu kontrol ediliyor...
echo.

set "recall_status_flag=0"
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v DisableAIDataAnalysis >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v DisableAIDataAnalysis ^| findstr "DisableAIDataAnalysis"') do (
        if "%%a"=="0x1" set "recall_status_flag=1"
    )
)

if "%recall_status_flag%"=="1" (
    echo [OK] Recall ozelligi: KAPALI
) else (
    echo [!] Recall ozelligi: ACIK veya yapilandirilmamis
)
echo.
pause
goto recall_menu

:status_check
cls
echo.
echo ==================== DURUM KONTROLU ====================
echo.

echo [*] Telemetri Durumu:
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry >nul 2>&1
if %errorlevel% equ 0 (
    echo     [OK] Telemetri ayarlari yapilmis
) else (
    echo     [!] Telemetri ayarlari yapilmamis
)

echo.
echo [*] Reklam Kimligi Durumu:
reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=3" %%a in ('reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled ^| findstr "Enabled"') do (
        if "%%a"=="0x0" (
            echo     [OK] Reklam kimligi kapali
        ) else (
            echo     [!] Reklam kimligi acik
        )
    )
) else (
    echo     [!] Reklam kimligi ayari bulunamadi
)

echo.
echo [*] Recall Durumu:
set "recall_check=0"
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v DisableAIDataAnalysis >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v DisableAIDataAnalysis ^| findstr "DisableAIDataAnalysis"') do (
        if "%%a"=="0x1" set "recall_check=1"
    )
)

if "%recall_check%"=="1" (
    echo     [OK] Recall ozelligi kapali
) else (
    echo     [!] Recall ozelligi acik veya yapilandirilmamis
)

echo.
echo ========================================================
echo.
pause
goto menu
