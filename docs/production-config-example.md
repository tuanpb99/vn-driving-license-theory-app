# Android/iOS production configuration examples

## Android (example)
- Enable minify for release build in `android/app/build.gradle`:
```gradle
buildTypes {
  release {
    minifyEnabled true
    shrinkResources true
    proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
  }
}
```
- Add AdMob App ID in `AndroidManifest.xml` via `<meta-data android:name="com.google.android.gms.ads.APPLICATION_ID" .../>`.

## iOS (example)
- Add AdMob App ID in `ios/Runner/Info.plist` (`GADApplicationIdentifier`).
- Set release signing in Xcode (Team, Bundle ID, provisioning profile).
- Enable background modes if scheduling notification refresh jobs.
