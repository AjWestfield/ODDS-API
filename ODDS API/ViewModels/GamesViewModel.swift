import Foundation
import SwiftUI

@MainActor
class GamesViewModel: ObservableObject {
    @Published var games: [Game] = []
    @Published private(set) var isLoading = false
    @Published var error: Error?
    
    private let service = OddsAPIService.shared
    private var refreshTimer: Timer?
    private var currentLeague: String?
    
    init() {
        // Start auto-refresh timer (every 30 seconds)
        refreshTimer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { [weak self] _ in
            Task { @MainActor [weak self] in
                guard let self = self,
                      let league = self.currentLeague else { return }
                await self.fetchGames(for: league)
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
    
    func fetchGames(for league: String) async {
        guard !isLoading else { return }
        
        isLoading = true
        currentLeague = league
        
        do {
            let sportKey = sportKey(for: league)
            let newGames = try await service.fetchGames(sport: sportKey)
            await MainActor.run {
                self.games = newGames
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
    
    func getProps(for game: Game, type: PropType) -> [PlayerProps] {
        return game.playerProps.filter { $0.propType == type }
    }
    
    func getGames(forTeam team: String?) -> [Game] {
        guard let team = team else { return games }
        return games.filter { $0.homeTeam == team || $0.awayTeam == team }
    }
} 