//
//  SwiftUIDeepLinkApp.swift
//  SwiftUIDeepLink
//
//  Created by JeongminKim on 2022/01/07.
//

import SwiftUI

@main
struct SwiftUIDeepLinkApp: App {
    
    @State var selectedTab = TabIdentifier.todos
    var body: some Scene {
        WindowGroup {
            TabView(
                selection: $selectedTab,
                content: {
                    TodosView().tabItem {
                        VStack {
                            Image(systemName: "list.bullet")
                            Text("Todo")
                        }
                        
                    }.tag(TabIdentifier.todos)
                    
                    ProfileView().tabItem {
                        VStack {
                            Image(systemName: "person.circle.fill")
                            Text("Profile")
                        }
                    }.tag(TabIdentifier.profile)
                }
            )
            .onOpenURL(perform: { url in
                // Handle url
                guard let tabId = url.tabIdentifier else { return }
                selectedTab = tabId
            })
        }
    }
}


enum TabIdentifier: Hashable {
    case todos
    case profile
}

// Showing page identifier
enum PageIdentifier: Hashable {
    case todoItem(id: UUID)
}

extension URL {
    // check scheme is same with URL scheme set in info section.
    var isDeepLink: Bool {
        return scheme == "hi-hello"
    }
    
    // case "todos" -> hi-hello://todos
    // case "profile" -> hi-hello://profile
    var tabIdentifier: TabIdentifier? {
        guard isDeepLink else { return nil }

        switch host {
        case "todos":
            return .todos
        case "profile":
            return .profile
        default:
            return nil
        }
    }
    
    // Move to detail page with activeUUID(52th line of TodosView.swift)
    // hi-hello://profile/activeUUID
    var detailPage: PageIdentifier? {
        guard let tabId = tabIdentifier,
              pathComponents.count > 1,
              let uuid = UUID(uuidString: pathComponents[1])
              else { return nil }
        
        switch tabId {
        case .todos:
            return .todoItem(id: uuid)
        default:
            return nil
        }
    }
}
