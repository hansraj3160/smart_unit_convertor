import java.util.Properties
plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}
val keystoreProperties = Properties().apply {
    val keystorePropertiesFile = rootProject.file("key.properties")
    if (keystorePropertiesFile.exists()) {
        keystorePropertiesFile.inputStream().use { load(it) }
    }
}
android {
    namespace = "com.example.smart_converter"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.ruhsolution.smart_converter"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            storeFile = if (keystoreProperties["storeFile"] != null) {
                file(keystoreProperties["storeFile"] as String)
            } else {
                file("upload-keystore.jks")
            }   
            storePassword = (keystoreProperties["storePassword"] as String?) ?: System.getenv("KEYSTORE_PASSWORD")
            keyAlias = (keystoreProperties["keyAlias"] as String?) ?: System.getenv("KEY_ALIAS")
            keyPassword = (keystoreProperties["keyPassword"] as String?) ?: System.getenv("KEY_PASSWORD")
        }
         buildTypes {
        release {
          
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true          // ✅ must be true
            isShrinkResources = true  
       
        }
    }
    }
}

flutter {
    source = "../.."
}
