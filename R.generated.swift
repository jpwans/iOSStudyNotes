//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.file` struct is generated, and contains static references to 8 files.
  struct file {
    /// Resource file `home@2x.png`.
    static let home2xPng = Rswift.FileResource(bundle: R.hostingBundle, name: "home@2x", pathExtension: "png")
    /// Resource file `home_selected@2x.png`.
    static let home_selected2xPng = Rswift.FileResource(bundle: R.hostingBundle, name: "home_selected@2x", pathExtension: "png")
    /// Resource file `icon_right_arrow@2x.png`.
    static let icon_right_arrow2xPng = Rswift.FileResource(bundle: R.hostingBundle, name: "icon_right_arrow@2x", pathExtension: "png")
    /// Resource file `logo@2x.png`.
    static let logo2xPng = Rswift.FileResource(bundle: R.hostingBundle, name: "logo@2x", pathExtension: "png")
    /// Resource file `mine@2x.png`.
    static let mine2xPng = Rswift.FileResource(bundle: R.hostingBundle, name: "mine@2x", pathExtension: "png")
    /// Resource file `mine_selected@2x.png`.
    static let mine_selected2xPng = Rswift.FileResource(bundle: R.hostingBundle, name: "mine_selected@2x", pathExtension: "png")
    /// Resource file `password@2x.png`.
    static let password2xPng = Rswift.FileResource(bundle: R.hostingBundle, name: "password@2x", pathExtension: "png")
    /// Resource file `phone@2x.png`.
    static let phone2xPng = Rswift.FileResource(bundle: R.hostingBundle, name: "phone@2x", pathExtension: "png")

    /// `bundle.url(forResource: "home@2x", withExtension: "png")`
    static func home2xPng(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.home2xPng
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "home_selected@2x", withExtension: "png")`
    static func home_selected2xPng(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.home_selected2xPng
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "icon_right_arrow@2x", withExtension: "png")`
    static func icon_right_arrow2xPng(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.icon_right_arrow2xPng
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "logo@2x", withExtension: "png")`
    static func logo2xPng(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.logo2xPng
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "mine@2x", withExtension: "png")`
    static func mine2xPng(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.mine2xPng
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "mine_selected@2x", withExtension: "png")`
    static func mine_selected2xPng(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.mine_selected2xPng
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "password@2x", withExtension: "png")`
    static func password2xPng(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.password2xPng
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "phone@2x", withExtension: "png")`
    static func phone2xPng(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.phone2xPng
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 8 images.
  struct image {
    /// Image `home_selected`.
    static let home_selected = Rswift.ImageResource(bundle: R.hostingBundle, name: "home_selected")
    /// Image `home`.
    static let home = Rswift.ImageResource(bundle: R.hostingBundle, name: "home")
    /// Image `icon_right_arrow`.
    static let icon_right_arrow = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_right_arrow")
    /// Image `logo`.
    static let logo = Rswift.ImageResource(bundle: R.hostingBundle, name: "logo")
    /// Image `mine_selected`.
    static let mine_selected = Rswift.ImageResource(bundle: R.hostingBundle, name: "mine_selected")
    /// Image `mine`.
    static let mine = Rswift.ImageResource(bundle: R.hostingBundle, name: "mine")
    /// Image `password`.
    static let password = Rswift.ImageResource(bundle: R.hostingBundle, name: "password")
    /// Image `phone`.
    static let phone = Rswift.ImageResource(bundle: R.hostingBundle, name: "phone")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "home", bundle: ..., traitCollection: ...)`
    static func home(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.home, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "home_selected", bundle: ..., traitCollection: ...)`
    static func home_selected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.home_selected, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "icon_right_arrow", bundle: ..., traitCollection: ...)`
    static func icon_right_arrow(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_right_arrow, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "logo", bundle: ..., traitCollection: ...)`
    static func logo(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.logo, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "mine", bundle: ..., traitCollection: ...)`
    static func mine(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.mine, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "mine_selected", bundle: ..., traitCollection: ...)`
    static func mine_selected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.mine_selected, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "password", bundle: ..., traitCollection: ...)`
    static func password(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.password, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "phone", bundle: ..., traitCollection: ...)`
    static func phone(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.phone, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    struct uiApplicationSceneManifest {
      static let _key = "UIApplicationSceneManifest"
      static let uiApplicationSupportsMultipleScenes = false

      struct uiSceneConfigurations {
        static let _key = "UISceneConfigurations"

        struct uiWindowSceneSessionRoleApplication {
          struct defaultConfiguration {
            static let _key = "Default Configuration"
            static let uiSceneConfigurationName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneConfigurationName") ?? "Default Configuration"
            static let uiSceneDelegateClassName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate"
            static let uiSceneStoryboardFile = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneStoryboardFile") ?? "Main"

            fileprivate init() {}
          }

          fileprivate init() {}
        }

        fileprivate init() {}
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try main.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = TabBarController

      let bundle = R.hostingBundle
      let name = "Main"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
