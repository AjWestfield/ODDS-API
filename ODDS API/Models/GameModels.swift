import Foundation

struct PlayerProps: Identifiable {
    let id = UUID()
    let playerName: String
    let propType: PropType
    let line: Double
    let overPrice: Int
    let underPrice: Int
    let bookmaker: String
}

// Extension to add player props functionality to the Game model from OddsAPIModels
extension Game {
    var playerProps: [PlayerProps] {
        get {
            // Convert bookmaker odds to player props
            var props: [PlayerProps] = []
            for bookmaker in bookmakers {
                for market in bookmaker.markets {
                    if let propType = PropType(rawValue: market.key),
                       let outcome = market.outcomes.first {
                        props.append(PlayerProps(
                            playerName: outcome.name,
                            propType: propType,
                            line: outcome.point ?? 0,
                            overPrice: Int(outcome.price),
                            underPrice: -Int(outcome.price),
                            bookmaker: bookmaker.title
                        ))
                    }
                }
            }
            return props
        }
    }
} 