import Foundation
import SwiftUI

@MainActor
class PropsViewModel: ObservableObject {
    @Published var playerProps: [PlayerProps] = []
    @Published private(set) var isLoading = false
    @Published var error: Error?
    
    private let service = OddsAPIService.shared
    private var refreshTimer: Timer?
    private var currentLeague: String?
    private var currentGameId: String?
    
    init() {
        // Start auto-refresh timer (every 30 seconds)
        refreshTimer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { [weak self] _ in
            Task { @MainActor [weak self] in
                guard let self = self,
                      let league = self.currentLeague,
                      let gameId = self.currentGameId else { return }
                await self.fetchProps(sport: league, gameId: gameId)
            }
        }
    }
    
    deinit {
        refreshTimer?.invalidate()
    }
    
    func sportKey(for league: String) -> String {
        switch league {
        case "NBA": return "basketball_nba"
        case "NFL": return "americanfootball_nfl"
        case "NHL": return "icehockey_nhl"
        case "NCAAF": return "americanfootball_ncaaf"
        case "NCAAB": return "basketball_ncaab"
        case "MLB": return "baseball_mlb"
        default: return ""
        }
    }
    
    func fetchProps(sport: String, gameId: String) async {
        guard !isLoading else { return }
        
        isLoading = true
        currentLeague = sport
        currentGameId = gameId
        
        do {
            let apiProps = try await service.fetchPlayerProps(sport: sport, gameId: gameId)
            await MainActor.run {
                // Convert API props to view model props
                self.playerProps = apiProps.map { apiProp in
                    PlayerProps(
                        playerName: apiProp.playerName,
                        propType: apiProp.propType,
                        line: apiProp.line,
                        overPrice: apiProp.overPrice,
                        underPrice: apiProp.underPrice,
                        bookmaker: apiProp.bookmaker
                    )
                }
                self.isLoading = false
                self.error = nil
            }
        } catch {
            await MainActor.run {
                self.error = error
                self.isLoading = false
            }
        }
    }
    
    private func backgroundRefresh(sport: String, gameId: String) async {
        do {
            let sportKey = sportKey(for: sport)
            let apiProps = try await service.fetchPlayerProps(sport: sportKey, gameId: gameId)
            // Convert API props to view model props
            self.playerProps = apiProps.map { apiProp in
                PlayerProps(
                    playerName: apiProp.playerName,
                    propType: apiProp.propType,
                    line: apiProp.line,
                    overPrice: apiProp.overPrice,
                    underPrice: apiProp.underPrice,
                    bookmaker: apiProp.bookmaker
                )
            }
        } catch {
            self.error = error
        }
    }
} 