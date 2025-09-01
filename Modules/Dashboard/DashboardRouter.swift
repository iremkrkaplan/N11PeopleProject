//
//  DashboardRouter.swift
//  N11PeopleProject
//
//  Created by irem.karakaplan on 27.08.2025.
//
import UIKit

final class DashboardRouter: DashboardRouterInput {
    
    weak var viewController: UIViewController?
    
    // SİLİNDİ: Artık `AppRouter`'ı tanımasına gerek yok.
    // private let appRouter = AppRouter()

    // Bu `createModule` metodu, senin çalışan ve sevdiğin versiyon.
    // Hiçbir değişiklik yok.
    static func createModule() -> UIViewController {
        let view = DashboardViewController()
        let interactor: DashboardInteractorInput = DashboardAPIInteractor(apiClient: .live)
        let router: DashboardRouterInput = DashboardRouter()
        
        let presenter: DashboardPresenterInput & DashboardInteractorOutput = DashboardPresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    // --- BU FONKSİYON DEĞİŞTİ ---
    // Artık `navigateToSearch` diye bir görevi yok.
    // `settingsButton`'a basıldığında ne olacağını bu fonksiyon belirler.
    func navigateToSettings() {
        // Belki ileride `Dashboard`'a özel bir ayarlar sayfası olur.
        // O zaman bu fonksiyonun içi doldurulur.
        // let settingsVC = DashboardSettingsRouter.createModule()
        // viewController?.navigationController?.pushViewController(settingsVC, animated: true)
        
        // Şimdilik, sadece bir print ile görevini yaptığını belirtiyoruz.
        print("DASHBOARD ROUTER: Ayarlar'a gitme komutu alındı (modül içi navigasyon).")
    }
}

/*
import UIKit
final class DashboardRouter: DashboardRouterInput{
    weak var viewController: UIViewController?
    private let appRouter = AppRouter()

    
    static func createModule() -> UIViewController {
        let view = DashboardViewController()
        let interactor: DashboardInteractorInput = DashboardAPIInteractor(apiClient: .live)
        let router: DashboardRouterInput = DashboardRouter()
        
        let presenter: DashboardPresenterInput & DashboardInteractorOutput = DashboardPresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        
        view.presenter = presenter
        if let interactor = interactor as? DashboardAPIInteractor {
            interactor.presenter = presenter
        }
        
        router.viewController = view

        return view
    }
    
    func navigateToSearch() {
        print("ROUTER: Kullanıcı Arama ekranına gitme komutu alındı.")
        appRouter.navigateToUserList(from: viewController)
    }
}
*/
