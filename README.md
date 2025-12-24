<<<<<<< HEAD
# TUGAS-BESAR-MOBILE-STUNTFREE
=======
# stuntfree_mobile

Aplikasi mobile berbasis Flutter untuk mendukung pencegahan stunting.
Aplikasi ini terintegrasi dengan backend berbasis Python untuk fitur chat
Aplikasi ini juga terintegrasi dengan supabase untuk rest api artikel

## Environment

- Flutter SDK 3.x
- Dart SDK ^3.9.0
- Android SDK

## Dependency

- provider: ^6.0.5
- dio: ^5.4.0
- shared_preferences: ^2.2.2

## Install Dependency

bash
flutter pub get

## Run Aplikasi

flutter run

## Build APK

flutter build apk

## Build App Bundle

flutter build appbundle

## Backend

Backend aplikasi menggunakan REST API berbasis Python.
Komunikasi antara aplikasi Flutter dan backend dilakukan menggunakan package dio

## Permissions

Aplikasi ini menggunakan permission berikut:

- INTERNET
  Digunakan untuk komunikasi dengan backend Python dan layanan Firebase.
- READ_MEDIA_IMAGES / READ_EXTERNAL_STORAGE
  Digunakan untuk mengambil gambar dari galeri perangkat (foto profil) menggunakan package image_picker.

## Firebase

Aplikasi ini menggunakan Firebase Authentication untuk proses:

- Login pengguna
- Registrasi pengguna
  Firebase diintegrasikan menggunakan package firebase_core dan firebase_auth.


## CHAT AI
Fitur Chat AI menggunakan REST API berbasis Python yang saat ini dijalankan secara lokal (localhost).

Langkah menjalankan backend Chat AI:
1. Masuk ke direktori backend
2. Jalankan perintah:
   python app.py
3. Pastikan alamat localhost sesuai dengan yang digunakan pada aplikasi Flutter
   
## APK Download

Link APK Android (app-release.apk):
https://drive.google.com/drive/folders/1gLmNcX4XJcTRSontQ1u_0TDlV3z04yU2?usp=drive_link

## Contact Person

Ketua Tim:
Nama: Dewi Septi Yunida
No: 087875965325
Email: dewiseptiyunida@gmail.com  


