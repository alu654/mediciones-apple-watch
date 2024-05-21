//
//  ContentView.swift
//  Medicion Watch App
//
//  Created by Alan Fried on 16/05/2024.
//

import SwiftUI
import WatchKit

struct ContentView: View {
    @State private var input: String = ""
    @State private var output: String = ""
    @State private var selectedInputUnit: UnitType = .dbm
    @State private var selectedOutputUnit: UnitType = .kilowatts
    @State private var showKeypad: Bool = false
    @State private var conversionHistory: [String] = []
    @State private var decimalPlaces: Int = 2

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Enter value")
                    .font(.headline)
                    .foregroundColor(.accentColor)
                
                HStack(spacing: 10) {
                    Text(input)
                        .font(.system(size: 40))
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 60)
                        .background(Color.clear)
                        .cornerRadius(5)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.accentColor, lineWidth: 1))
                        .foregroundColor(.white)
                        .onTapGesture {
                            self.showKeypad.toggle()
                        }
                    
                    Button(action: {
                        if !input.isEmpty {
                            input.removeLast()
                            performHapticFeedback()
                        }
                    }) {
                        Image(systemName: "delete.left")
                            .font(.system(size: 12))
                            .foregroundColor(.red)
                            .padding(2)
                            .background(Circle().fill(Color.black).frame(width: 16, height: 16))
                    }
                }
                
                if showKeypad {
                    NumericKeypad(input: $input)
                }
                
                HStack(spacing: 20) {
                    VStack {
                        Text("From:")
                        Picker("Input Unit", selection: $selectedInputUnit) {
                            ForEach(UnitType.allCases, id: \.self) { unit in
                                Text(unit.rawValue).tag(unit)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(WheelPickerStyle())
                        .frame(height: 100)
                    }
                    
                    VStack {
                        Text("To:")
                        Picker("Output Unit", selection: $selectedOutputUnit) {
                            ForEach(UnitType.allCases, id: \.self) { unit in
                                Text(unit.rawValue).tag(unit)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(WheelPickerStyle())
                        .frame(height: 100)
                    }
                }
                
                HStack {
                    Button(action: {
                        input = ""
                        output = ""
                        performHapticFeedback()
                    }) {
                        Text("Clear")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                    
                    Button(action: {
                        if let inputValue = Double(input) {
                            let convertedValue = convert(value: inputValue, from: selectedInputUnit, to: selectedOutputUnit)
                            output = formatNumber(convertedValue) + " " + selectedOutputUnit.rawValue
                            let historyEntry = "\(input) \(selectedInputUnit.rawValue) = \(output)"
                            conversionHistory.append(historyEntry)
                            performHapticFeedback()
                        } else {
                            output = "Invalid input"
                        }
                    }) {
                        Text("Convert")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                }
                
                Text("Result: \(output)")
                    .padding()
                
                if !conversionHistory.isEmpty {
                    VStack(alignment: .leading) {
                        Text("History")
                            .font(.headline)
                            .foregroundColor(.accentColor)
                        
                        ForEach(conversionHistory, id: \.self) { entry in
                            Text(entry)
                                .font(.footnote)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                }
            }
            .padding()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .animation(.easeInOut, value: showKeypad)
    }

    func performHapticFeedback() {
        WKInterfaceDevice.current().play(.success) // Cambiar a una vibración más fuerte
    }

    func convert(value: Double, from inputUnit: UnitType, to outputUnit: UnitType) -> Double {
        let baseValue: Double
        
        // Convertir la unidad de entrada a la unidad base
        switch inputUnit {
        case .watts:
            baseValue = value * 1_000_000 // Convertir a microwatts (unidad base)
        case .milliwatts:
            baseValue = value * 1_000 // Convertir a microwatts (unidad base)
        case .microwatts:
            baseValue = value // Microwatts a microwatts (unidad base)
        case .kilowatts:
            baseValue = value * 1_000_000_000 // Convertir a microwatts (unidad base)
        case .dbm:
            baseValue = pow(10, value / 10) * 1_000 // Convertir dBm a microwatts
        case .bps:
            baseValue = value // Bps a bps (unidad base)
        case .kbps:
            baseValue = value * 1_000 // Convertir a bps (unidad base)
        case .mbps:
            baseValue = value * 1_000_000 // Convertir a bps (unidad base)
        case .mpps:
            baseValue = value * 1_000_000 // Convertir a pps (unidad base)
        case .kpps:
            baseValue = value * 1_000 // Convertir a pps (unidad base)
        case .pps:
            baseValue = value // PPS a PPS (unidad base)
        case .baudios:
            baseValue = value // Baudios a baudios (unidad base)
        case .mbaudios:
            baseValue = value * 1_000_000 // Convertir a baudios (unidad base)
        case .volts:
            baseValue = value * 1_000 // Convertir a millivolts (unidad base)
        case .millivolts:
            baseValue = value // Millivolts a millivolts (unidad base)
        case .ghz:
            baseValue = value * 1_000_000_000 // Convertir a Hz (unidad base)
        case .hz:
            baseValue = value // Hz a Hz (unidad base)
        case .mhz:
            baseValue = value * 1_000_000 // Convertir a Hz (unidad base)
        case .khz:
            baseValue = value * 1_000 // Convertir a Hz (unidad base)
        case .times:
            baseValue = value // Veces a veces (unidad base)
        case .db:
            baseValue = pow(10, value / 10) // Convertir dB a veces (unidad base)
        case .mw:
            baseValue = value // mW a mW (unidad base)
        case .p1:
            baseValue = value // Potencia de entrada a potencia de entrada (unidad base)
        case .p2:
            baseValue = value // Potencia de salida a potencia de salida (unidad base)
        }
        
        // Convertir la unidad base a la unidad de salida
        switch outputUnit {
        case .watts:
            return baseValue / 1_000_000 // Convertir de microwatts a watts
        case .milliwatts:
            return baseValue / 1_000 // Convertir de microwatts a milliwatts
        case .microwatts:
            return baseValue // Microwatts a microwatts (unidad base)
        case .kilowatts:
            return baseValue / 1_000_000_000 // Convertir de microwatts a kilowatts
        case .dbm:
            return 10 * log10(baseValue / 1_000) // Convertir microwatts a dBm
        case .bps:
            return baseValue // Bps a bps (unidad base)
        case .kbps:
            return baseValue / 1_000 // Convertir de bps a kbps
        case .mbps:
            return baseValue / 1_000_000 // Convertir de bps a Mbps
        case .mpps:
            return baseValue / 1_000_000 // Convertir de pps a MPPS
        case .kpps:
            return baseValue / 1_000 // Convertir de pps a KPPS
        case .pps:
            return baseValue // PPS a PPS (unidad base)
        case .baudios:
            return baseValue // Baudios a baudios (unidad base)
        case .mbaudios:
            return baseValue / 1_000_000 // Convertir de baudios a MBaudios
        case .volts:
            return baseValue / 1_000 // Convertir de millivolts a volts
        case .millivolts:
            return baseValue // Millivolts a millivolts (unidad base)
        case .ghz:
            return baseValue / 1_000_000_000 // Convertir de Hz a GHz
        case .hz:
            return baseValue // Hz a Hz (unidad base)
        case .mhz:
            return baseValue / 1_000_000 // Convertir de Hz a MHz
        case .khz:
            return baseValue / 1_000 // Convertir de Hz a kHz
        case .times:
            return baseValue // Veces a veces (unidad base)
        case .db:
            return 10 * log10(baseValue) // Convertir veces a dB
        case .mw:
            return baseValue // mW a mW (unidad base)
        case .p1:
            return baseValue // Potencia de entrada a potencia de entrada (unidad base)
        case .p2:
            return 10 * log10(baseValue) // Calcular ganancia en dB (P2/P1) basado en P1 como unidad base
        }
    }




    func formatNumber(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = decimalPlaces
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
}

struct NumericKeypad: View {
    @Binding var input: String

    let buttons = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        [".", "0", "⌫"]
    ]

    var body: some View {
        VStack(spacing: 5) {
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 5) {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            self.buttonTapped(button)
                        }) {
                            Text(button)
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
    }

    private func buttonTapped(_ button: String) {
        if button == "⌫" {
            if !input.isEmpty {
                input.removeLast()
            }
        } else {
            input.append(button)
        }
        performHapticFeedback()
    }

    private func performHapticFeedback() {
        WKInterfaceDevice.current().play(.success) 
    }
}

enum UnitType: String, CaseIterable {
    case watts = "Watts"
    case milliwatts = "Milliwatts"
    case microwatts = "Microwatts"
    case kilowatts = "Kilowatts" 
    case bps = "Bps"
    case kbps = "Kbps"
    case mbps = "Mbps"
    case mpps = "MPPS"
    case kpps = "KPPS"
    case pps = "PPS"
    case baudios = "Baudios"
    case mbaudios = "MBaudios"
    case volts = "Volts"
    case millivolts = "Millivolts"
    case ghz = "GHz"
    case hz = "Hz"
    case mhz = "MHz"
    case khz = "kHz"
    case times = "Veces"
    case db = "dB"
    case dbm = "dBm"
    case mw = "mW"
    case p1 = "P1"
    case p2 = "P2"
}
