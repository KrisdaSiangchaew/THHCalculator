//
//  ContentView.swift
//  THH Calculator
//
//  Created by Kris Siangchaew on 18/1/2564 BE.
//

import SwiftUI
import CoreML

struct NumberProb: Identifiable {
    let id = UUID()
    let number: Int64
    let prob: Double
}

struct Lottery: Decodable, Identifiable {
    var id: String { "\(Day + Month + Year)"}
    let Day: Int
    let Month: Int
    let Year: Int
    let hundredth: Int
    let tenth: Int
    let oneth: Int
    
    static let allLotteries = Bundle.main.decode([Lottery].self, from: "30Y_preproc.json")
}

struct ContentView: View {
    @State private var day: Int = 1
    @State private var month: Int = 12
    @State private var year: Int = 2563
    @State private var date: Date = Date()
    
    let days: [Int] = [1, 7, 16, 17, 30]
    let beginDay: Int = 1
    let endDay: Int = 31
    let beginMonth: Int = 1
    let endMonth = 12
    let beginYear: Int = 2533
    let endYear: Int = 2564
    
    var hundredth: [NumberProb] {
        var numberProb = [NumberProb]()
        do {
            // Hundredth
            let model: Hundredth = try Hundredth(configuration: MLModelConfiguration())
            let prediction = try model.prediction(Day: Double(day), Month: Double(month), Year: Double(year))
            let predictedValues = prediction.hundredthProbability
            for (key, value) in predictedValues {
                let predicted = NumberProb(number: key, prob: value)
                numberProb.append(predicted)
            }
        } catch {
            fatalError()
        }
        return numberProb
    }
    
    var one: [NumberProb] {
        var numberProb = [NumberProb]()
        do {
            // One
            let model: Oneth = try Oneth(configuration: MLModelConfiguration())
            let prediction = try model.prediction(Day: Double(day), Month: Double(month), Year: Double(year))
            let predictedValues = prediction.onethProbability
            for (key, value) in predictedValues {
                let predicted = NumberProb(number: key, prob: value)
                numberProb.append(predicted)
            }
        } catch {
            fatalError()
        }
        
        return numberProb
    }
    
    var tenth: [NumberProb] {
        var numberProb = [NumberProb]()
        do {
            // Tenth
            let model: Tenth = try Tenth(configuration: MLModelConfiguration())
            let prediction = try model.prediction(Day: Double(day), Month: Double(month), Year: Double(year))
            let predictedValues = prediction.tenthProbability
            for (key, value) in predictedValues {
                let predicted = NumberProb(number: key, prob: value)
                numberProb.append(predicted)
            }
        } catch {
            fatalError()
        }
        
        return numberProb
    }
    
    var actualValueView: some View {
        let result = Lottery.allLotteries.filter { lottery in
            return lottery.Day == day && lottery.Month == month && lottery.Year == year
        }
        if result.isEmpty {
            return Text("Not available")
        } else {
            return Text("\(result[0].hundredth)" + "\(result[0].tenth)" + "\(result[0].oneth)")
        }
    }
    
    func placeView(for numProbs: [NumberProb]) -> some View {
        VStack(alignment: .leading) {
            ForEach(numProbs.sorted { $0.prob > $1.prob }) { numberProb in
                Text("\(numberProb.number) (\(numberProb.prob * 100, specifier: "%.1f")%)")
            }
        }
    }
    
    var predictionValueView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(hundredth.isEmpty ? "" : "Hundredth")
                    .font(.system(.caption))
                    .fontWeight(.bold)
                placeView(for: hundredth)
            }
            VStack(alignment: .leading) {
                Text(tenth.isEmpty ? "" : "Tenth")
                    .font(.system(.caption))
                    .fontWeight(.bold)
                placeView(for: tenth)
            }
            VStack(alignment: .leading) {
                Text(one.isEmpty ? "" : "One")
                    .font(.system(.caption))
                    .fontWeight(.bold)
                placeView(for: one)
            }
        }
        .font(.system(.callout))
    }
    
    var dateSelectionView: some View {
        List {
            Stepper("Day: \(day)", value: $day, in: beginDay...endDay)
            Stepper("Month: \(month)", value: $month, in: beginMonth...endMonth)
            Stepper("Year: \(year.description)", value: $year, in: beginYear...endYear)
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select lottery date")) {
                    dateSelectionView
                }
                
                Section(header: Text("Actual")) {
                    actualValueView
                }
                
                Section(header: Text("Prediction")) {
                    predictionValueView
                }
            }
            .navigationTitle(Text("TengHengHeng"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
