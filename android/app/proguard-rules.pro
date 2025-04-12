 ## Flutter wrapper
 -keep class io.flutter.app.** { *; }
 -keep class io.flutter.plugin.** { *; }
 -keep class io.flutter.util.** { *; }
 -keep class io.flutter.view.** { *; }
 -keep class io.flutter.** { *; }
 -keep class io.flutter.plugins.** { *; }
 -keep class com.google.firebase.** { *; }
 -dontwarn io.flutter.embedding.**

 -dontwarn org.bouncycastle.jsse.BCSSLParameters
 -dontwarn org.bouncycastle.jsse.BCSSLSocket
 -dontwarn org.bouncycastle.jsse.provider.BouncyCastleJsseProvider
 -dontwarn org.conscrypt.Conscrypt$Version
 -dontwarn org.conscrypt.Conscrypt
 -dontwarn org.conscrypt.ConscryptHostnameVerifier
 -dontwarn org.openjsse.javax.net.ssl.SSLParameters
 -dontwarn org.openjsse.javax.net.ssl.SSLSocket
 -dontwarn org.openjsse.net.ssl.OpenJSSE