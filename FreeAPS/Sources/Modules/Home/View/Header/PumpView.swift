import SwiftUI

struct PumpView: View {
    @Binding var reservoir: Decimal?
    @Binding var battery: Battery?
    @Binding var name: String
    @Binding var expiresAtDate: Date?
    @Binding var timerDate: Date

    private var reservoirFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        return formatter
    }

    private var batteryFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(name).font(.caption)
                .minimumScaleFactor(0.01)
            if let reservoir = reservoir {
                HStack {
                    Image(systemName: "drop.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 8)
                        .foregroundColor(reservoirColor)
                    Text(reservoirFormatter.string(from: reservoir as NSNumber)! + " U").font(.caption2)
                }
            }

            if let battery = battery, battery.display ?? false, expiresAtDate == nil {
                HStack {
                    Image(systemName: "battery.100")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 8)
                        .foregroundColor(batteryColor)
                    Text("\(Int(battery.percent ?? 100)) %").font(.caption2)
                }
            }

            if let date = expiresAtDate {
                HStack {
                    Image(systemName: "stopwatch.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 8)
                        .foregroundColor(timerColor)
                    Text(remainingTimeString(time: date.timeIntervalSince(timerDate))).font(.caption2)
                }
            }

        }.padding(.leading)
    }

    private func remainingTimeString(time: TimeInterval) -> String {
        var time = time
        let days = Int(time / 1.days.timeInterval)
        time -= days.days.timeInterval
        let hours = Int(time / 1.hours.timeInterval)
        time -= hours.hours.timeInterval
        let minutes = Int(time / 1.minutes.timeInterval)

        if days > 1 {
            return "\(days)d \(hours)h"
        }

        if hours > 1 {
            return "\(hours)h"
        }

        return "\(minutes)m"
    }

    private var batteryColor: Color {
        guard let battery = battery, let percent = battery.percent else {
            return .gray
        }

        switch percent {
        case ...10:
            return .red
        case ...20:
            return .orange
        default:
            return .green
        }
    }

    private var reservoirColor: Color {
        guard let reservoir = reservoir else {
            return .gray
        }

        switch reservoir {
        case ...10:
            return .red
        case ...30:
            return .orange
        default:
            return .blue
        }
    }

    private var timerColor: Color {
        guard let expisesAt = expiresAtDate else {
            return .gray
        }

        let time = expisesAt.timeIntervalSince(timerDate)

        switch time {
        case ...8.hours.timeInterval:
            return .red
        case ...1.days.timeInterval:
            return .orange
        default:
            return .green
        }
    }
}