import Foundation

enum OddsAPIError: Error {
    case invalidURL
    case invalidResponse
    case networkError(Error)
    case decodingError(Error)
}

class OddsAPIService {
    private let apiKey = "820dae5cf147aafac38869c1dd4615be"
    private let baseURL = "https://api.the-odds-api.com/v4"
    
    static let shared = OddsAPIService()
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func fetchGames(sport: String, region: String = "us", markets: String = "h2h,spreads,totals") async throws -> [Game] {
        guard var urlComponents = URLComponents(string: "\(baseURL)/sports/\(sport)/odds") else {
            throw OddsAPIError.invalidURL
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey),
            URLQueryItem(name: "regions", value: region),
            URLQueryItem(name: "markets", value: markets),
            URLQueryItem(name: "oddsFormat", value: "decimal")
        ]
        
        guard let url = urlComponents.url else {
            throw OddsAPIError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw OddsAPIError.invalidResponse
            }
            
            return try jsonDecoder.decode([Game].self, from: data)
        } catch let error as DecodingError {
            throw OddsAPIError.decodingError(error)
        } catch {
            throw OddsAPIError.networkError(error)
        }
    }
    
    func fetchSports() async throws -> [Sport] {
        guard var urlComponents = URLComponents(string: "\(baseURL)/sports") else {
            throw OddsAPIError.invalidURL
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        
        guard let url = urlComponents.url else {
            throw OddsAPIError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw OddsAPIError.invalidResponse
            }
            
            return try jsonDecoder.decode([Sport].self, from: data)
        } catch let error as DecodingError {
            throw OddsAPIError.decodingError(error)
        } catch {
            throw OddsAPIError.networkError(error)
        }
    }
    
    func fetchPlayerProps(sport: String, gameId: String) async throws -> [PlayerProp] {
        guard var urlComponents = URLComponents(string: "\(baseURL)/sports/\(sport)/events/\(gameId)/odds") else {
            throw OddsAPIError.invalidURL
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey),
            URLQueryItem(name: "regions", value: "us"),
            URLQueryItem(name: "markets", value: "player_points,player_rebounds,player_assists,player_threes,player_blocks,player_steals")
        ]
        
        guard let url = urlComponents.url else {
            throw OddsAPIError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw OddsAPIError.invalidResponse
            }
            
            // First decode the event response
            let eventResponse = try jsonDecoder.decode(EventResponse.self, from: data)
            
            // Convert the event response to our PlayerProp model
            var playerProps: [PlayerProp] = []
            
            for bookmaker in eventResponse.bookmakers {
                for market in bookmaker.markets {
                    for outcome in market.outcomes {
                        let propType = PropType(from: market.key)
                        let prop = PlayerProp(
                            id: UUID().uuidString,
                            playerName: outcome.description ?? "",
                            team: determineTeam(playerName: outcome.description ?? "", homeTeam: eventResponse.homeTeam, awayTeam: eventResponse.awayTeam),
                            propType: propType,
                            line: outcome.point ?? 0,
                            overPrice: outcome.name.lowercased() == "over" ? Int(outcome.price * 100) : 0,
                            underPrice: outcome.name.lowercased() == "under" ? Int(outcome.price * 100) : 0,
                            bookmaker: bookmaker.title,
                            lastUpdate: market.lastUpdate
                        )
                        playerProps.append(prop)
                    }
                }
            }
            
            return playerProps
        } catch let error as DecodingError {
            throw OddsAPIError.decodingError(error)
        } catch {
            throw OddsAPIError.networkError(error)
        }
    }
    
    private func determineTeam(playerName: String, homeTeam: String, awayTeam: String) -> String {
        // For now, we'll return an empty string since we don't have player-team mappings
        // In a production app, we would maintain a database or use an additional API
        // to map players to their teams
        return ""
    }
}

// Add models for the new API response format
struct EventResponse: Codable {
    let id: String
    let sportKey: String
    let sportTitle: String
    let homeTeam: String
    let awayTeam: String
    let bookmakers: [BookmakerResponse]
    
    enum CodingKeys: String, CodingKey {
        case id
        case sportKey = "sport_key"
        case sportTitle = "sport_title"
        case homeTeam = "home_team"
        case awayTeam = "away_team"
        case bookmakers
    }
}

struct BookmakerResponse: Codable {
    let key: String
    let title: String
    let markets: [MarketResponse]
}

struct MarketResponse: Codable {
    let key: String
    let lastUpdate: Date
    let outcomes: [OutcomeResponse]
    
    enum CodingKeys: String, CodingKey {
        case key
        case lastUpdate = "last_update"
        case outcomes
    }
}

struct OutcomeResponse: Codable {
    let name: String
    let description: String?
    let price: Double
    let point: Double?
}

extension PropType {
    init(from marketKey: String) {
        switch marketKey {
        case "player_points":
            self = .points
        case "player_rebounds":
            self = .rebounds
        case "player_assists":
            self = .assists
        case "player_threes":
            self = .threePointers
        case "player_blocks":
            self = .blocks
        case "player_steals":
            self = .steals
        case "player_pra":
            self = .pointsReboundsAssists
        case "player_pr":
            self = .pointsRebounds
        case "player_pa":
            self = .pointsAssists
        case "player_ra":
            self = .reboundsAssists
        default:
            self = .points // Default to points as fallback
        }
    }
} 