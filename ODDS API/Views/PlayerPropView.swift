import SwiftUI

struct PlayerPropView: View {
    let prop: PlayerProp
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Player Name and Team
            HStack {
                Text(prop.playerName)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                
                Text("(\(prop.team))")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            // Prop Details
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(prop.propType.rawValue.replacingOccurrences(of: "_", with: " ").capitalized)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    Text(String(format: "%.1f", prop.line))
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                // Over/Under prices
                HStack(spacing: 24) {
                    VStack(alignment: .center, spacing: 4) {
                        Text("OVER")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Text("\(prop.overPrice)")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(prop.overPrice > 0 ? .green : .red)
                    }
                    
                    VStack(alignment: .center, spacing: 4) {
                        Text("UNDER")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Text("\(prop.underPrice)")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(prop.underPrice > 0 ? .green : .red)
                    }
                }
            }
            
            // Bookmaker and Last Update
            HStack {
                Image(getSportsBookLogoName(prop.bookmaker))
                    .resizable()
                    .scaledToFit()
                    .frame(height: 16)
                
                Spacer()
                
                Text(prop.lastUpdate.timeAgoDisplay())
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color(white: 0.1))
        .cornerRadius(12)
    }
    
    private func getSportsBookLogoName(_ key: String) -> String {
        switch key {
        case "fanduel": return "fanduel"
        case "draftkings": return "draftkings"
        case "betmgm": return "betmgm"
        case "caesars": return "caesars"
        default: return ""
        }
    }
}

extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: self, relativeTo: Date())
    }
} 