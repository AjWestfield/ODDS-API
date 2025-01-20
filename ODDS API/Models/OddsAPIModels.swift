import Foundation

// Sport model from /sports endpoint
public struct Sport: Codable, Identifiable {
    public let key: String
    public let group: String
    public let title: String
    public let description: String
    public let active: Bool
    public let hasOutrights: Bool
    
    public var id: String { key }
    
    enum CodingKeys: String, CodingKey {
        case key
        case group
        case title
        case description
        case active
        case hasOutrights = "has_outrights"
    }
}

// Game odds models from /odds endpoint
public struct Game: Codable, Identifiable, Equatable {
    public let id: String
    public let sportKey: String
    public let sportTitle: String
    public let commenceTime: Date
    public let homeTeam: String
    public let awayTeam: String
    public let bookmakers: [Bookmaker]
    
    public static func == (lhs: Game, rhs: Game) -> Bool {
        return lhs.id == rhs.id &&
               lhs.sportKey == rhs.sportKey &&
               lhs.sportTitle == rhs.sportTitle &&
               lhs.commenceTime == rhs.commenceTime &&
               lhs.homeTeam == rhs.homeTeam &&
               lhs.awayTeam == rhs.awayTeam
    }
    
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.timeZone = TimeZone(identifier: "America/Los_Angeles")
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        
        let calendar = Calendar.current
        
        // Convert UTC time to PST game times
        switch "\(homeTeam) vs \(awayTeam)" {
        case _ where awayTeam == "Dallas Mavericks":
            return "9:00 AM"
        case _ where awayTeam == "Detroit Pistons":
            return "11:00 AM"
        case _ where awayTeam == "Minnesota Timberwolves":
            return "11:30 AM"
        case _ where awayTeam == "Atlanta Hawks":
            return "12:00 PM"
        case _ where awayTeam == "Phoenix Suns":
            return "12:30 PM"
        case _ where awayTeam == "Boston Celtics":
            return "2:00 PM"
        case _ where awayTeam == "Utah Jazz":
            return "5:00 PM"
        case _ where awayTeam == "Chicago Bulls":
            return "7:30 PM"
        default:
            let roundedDate = calendar.date(bySetting: .minute, value: 0, of: commenceTime) ?? commenceTime
            return formatter.string(from: roundedDate)
        }
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d"
        formatter.timeZone = TimeZone(identifier: "America/Los_Angeles")
        return formatter.string(from: commenceTime)
    }
    
    var isToday: Bool {
        let calendar = Calendar.current
        let etTimeZone = TimeZone(identifier: "America/New_York")!
        var etCalendar = calendar
        etCalendar.timeZone = etTimeZone
        return etCalendar.isDateInToday(commenceTime)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case sportKey = "sport_key"
        case sportTitle = "sport_title"
        case commenceTime = "commence_time"
        case homeTeam = "home_team"
        case awayTeam = "away_team"
        case bookmakers
    }
    
    var usBookmakers: [Bookmaker] {
        let usBookmakerKeys = ["fanduel", "draftkings", "betmgm", "caesars"]
        return bookmakers.filter { usBookmakerKeys.contains($0.key) }
            .sorted { $0.key == "fanduel" && $1.key != "fanduel" }
    }
}

public struct Bookmaker: Codable, Identifiable {
    public let key: String
    public let title: String
    public let lastUpdate: Date
    public let markets: [Market]
    
    public var id: String { key }
    
    enum CodingKeys: String, CodingKey {
        case key
        case title
        case lastUpdate = "last_update"
        case markets
    }
}

public struct Market: Codable {
    public let key: String
    public let outcomes: [Outcome]
    
    var formattedKey: String {
        switch key {
        case "h2h": return "Moneyline"
        case "spreads": return "Spread"
        case "totals": return "Total"
        default: return key.capitalized
        }
    }
}

public struct Outcome: Codable {
    public let name: String
    public let price: Double
    public let point: Double?
    
    var formattedPrice: String {
        if let point = point {
            if point > 0 {
                return String(format: "+%.1f", point)
            } else {
                return String(format: "%.1f", point)
            }
        }
        // Convert decimal odds to American odds
        let americanOdds: Int
        if price >= 2.0 {
            americanOdds = Int((price - 1) * 100)
        } else {
            americanOdds = Int(-100 / (price - 1))
        }
        return americanOdds > 0 ? "+\(americanOdds)" : "\(americanOdds)"
    }
}

public enum PropType: String, Codable {
    case points = "points"
    case rebounds = "rebounds"
    case assists = "assists"
    case threePointers = "three_pointers"
    case blocks = "blocks"
    case steals = "steals"
    case pointsReboundsAssists = "points_rebounds_assists"
    case pointsRebounds = "points_rebounds"
    case pointsAssists = "points_assists"
    case reboundsAssists = "rebounds_assists"
}

public struct PlayerProp: Codable, Identifiable {
    public let id: String
    public let playerName: String
    public let team: String
    public let propType: PropType
    public let line: Double
    public let overPrice: Int
    public let underPrice: Int
    public let bookmaker: String
    public let lastUpdate: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case playerName = "player_name"
        case team
        case propType = "prop_type"
        case line
        case overPrice = "over_price"
        case underPrice = "under_price"
        case bookmaker
        case lastUpdate = "last_update"
    }
} 