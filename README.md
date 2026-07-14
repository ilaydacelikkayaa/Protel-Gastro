# Protel-Gastro 🍽️

Protel-Gastro; restoran masa yönetimi, dinamik menü ve adisyon/hesap takibi işlemlerini kolaylaştırmak amacıyla geliştirilmiş, yüksek performanslı ve tamamen programatik (programmatic) UIKit tabanlı bir iOS mobil uygulamasıdır. Storyboard veya XIB dosyaları kullanılmadan sıfırdan inşa edilen proje; modern yazılım mimarisi şablonlarını, temiz kod prensiplerini ve akıcı bir kullanıcı deneyimini bir arada sunar.

---

## 📸 Önizleme (Preview)

<p align="center">
<img src="https://github.com/user-attachments/assets/95584f4e-e1bd-4a35-b57c-754a4b151704" alt="Protel-Gastro Uygulama Akışı" width="320"/>
</p>

<p align="center">
  <em>Uygulama İçi Menü, Sepet ve Sipariş Akışı</em>
</p>

---

## 📝 Proje Hakkında

**Protel-Gastro**, bir restoranın günlük operasyonlarını (salon yönetimi, masa doluluk kontrolü, dinamik menü listeleme, masaya özel sepet yönetimi ve anlık hesap/adisyon takibi) tek bir noktadan ve maksimum akıcılıkla yönetmek üzere tasarlanmış profesyonel bir iOS mobil uygulamasıdır.

### Temel Proje Akışları:

*   **Salon ve Masa Yönetimi:** Restorandaki masaların doluluk ve boşluk durumları dinamik bir arayüz üzerinden anlık olarak takip edilir. Kullanıcı, dilediği masayı seçerek o masaya özel servis akışını başlatır.
*   **Dinamik Menü ve Arama:** Kategorize edilmiş zengin yemek menüsü, pürüzsüz kaydırma (scroll) performansı ve entegre arama (`UISearchController`) desteğiyle listelenir. Kullanıcılar diledikleri yemeği hızlıca aratıp inceleyebilir.
*   **Masaya Özel Sepet:** Her masanın sepeti birbirinden tamamen bağımsızdır. Örneğin; Masa 3'e eklenen bir ürün, sadece o masanın oturumunda kalır; böylece masalar arası sipariş karışıklığı tamamen önlenir.
*   **Programatik Adisyon ve Hesap Kapatma:** Sepette biriken ürünler, kullanıcı dostu bir arayüzle listelenir. Her bir kalemin adeti, birim fiyatı ve toplam tutarı şık bir fatura tasarımı (`BillViewController`) üzerinde gösterilerek sipariş tamamlama ve ödeme adımları simüle edilir.

---

## 🛠️ Teknolojiler ve Kullanılan Kütüphaneler

*   **Dil:** Swift 5.10
*   **Arayüz Çatısı (UI Framework):** UIKit (%100 Programatik UI - Storyboard kullanılmamıştır)
*   **Arayüz Yerleşimi (Layout Engine):** [SnapKit](https://github.com/SnapKit/SnapKit) (Auto Layout kısıtlamaları için temiz ve okunabilir DSL yapısı)
*   **Mimari:** MVVM (Model-View-ViewModel) + Coordinator/Router Şablonu
*   **Eşzamanlılık (Concurrency):** Grand Central Dispatch (GCD) ve Thread-Safe Kuyruk Yönetimi

---

## 👩🏻‍💻 Geliştirici

**İlayda Çelikkaya**  
*Bilgisayar Mühendisliği Öğrencisi & iOS Geliştirici*  
Yüksek performanslı programatik iOS arayüzleri, temiz durum yönetimi (state management) mimarileri ve performans odaklı mobil çözümler geliştirmeye odaklanmaktadır.

---
