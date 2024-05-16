//
//  ContentView.swift
//  Medicion Watch App
//
//  Created by Alan Fried on 16/05/2024.
//
import SwiftUI

struct ContentView: View {
    @State private var input: String = ""
    @State private var output: String = ""
    @State private var selectedInputUnit: UnitType = .bps
    @State private var selectedOutputUnit: UnitType = .mbps
    @State private var showKeypad: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Enter value")
                    .font(.headline)
                    .foregroundColor(.accentColor) // Usar el color de acento
                
                Text(input)
                    .font(.largeTitle)
                    .padding()
                    .background(Color.clear)
                    .cornerRadius(5)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.accentColor, lineWidth: 1)) // Usar el color de acento
                    .foregroundColor(.white)
                    .onTapGesture {
                        self.showKeypad.toggle()
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
                
                Button(action: {
                    if let inputValue = Double(input) {
                        let convertedValue = convert(value: inputValue, from: selectedInputUnit, to: selectedOutputUnit)
                        output = String(format: "%.2f", convertedValue) + " " + selectedOutputUnit.rawValue
                    }
                }) {
                    Text("Convert")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor) // Usar el color de acento
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
                
                Text("Result: \(output)")
                    .padding()
            }
            .padding()
        }
    }
    
    func convert(value: Double, from inputUnit: UnitType, to outputUnit: UnitType) -> Double {
        let baseValue: Double
        
        switch inputUnit {
        case .watts:
            baseValue = value * 1_000 // Convert to milliwatts (base unit)
        case .milliwatts:
            baseValue = value // Milliwatts to milliwatts (base unit)
        case .bps:
            baseValue = value // Bps to bps (base unit)
        case .mbps:
            baseValue = value * 1_000_000 // Convert to bps (base unit)
        case .ghz:
            baseValue = value * 1_000_000_000 // Convert to Hz (base unit)
        case .hz:
            baseValue = value // Hz to Hz (base unit)
        case .mhz:
            baseValue = value * 1_000_000 // Convert to Hz (base unit)
        case .times:
            baseValue = value // Times to times (base unit)
        case .db:
            baseValue = pow(10, value / 10) // Convert dB to times (base unit)
        case .dbm:
            baseValue = pow(10, value / 10) // Convert dBm to mW (base unit)
        case .mw:
            baseValue = value // mW to mW (base unit)
        case .p1:
            baseValue = value // Power input to power input (base unit)
        case .p2:
            baseValue = value // Power output to power output (base unit)
        }
        
        switch outputUnit {
        case .watts:
            return baseValue / 1_000 // Convert from milliwatts to watts
        case .milliwatts:
            return baseValue // Milliwatts to milliwatts (base unit)
        case .bps:
            return baseValue // Bps to bps (base unit)
        case .mbps:
            return baseValue / 1_000_000 // Convert from bps to Mbps
        case .ghz:
            return baseValue / 1_000_000_000 // Convert from Hz to GHz
        case .hz:
            return baseValue // Hz to Hz (base unit)
        case .mhz:
            return baseValue / 1_000_000 // Convert from Hz to MHz
        case .times:
            return baseValue // Times to times (base unit)
        case .db:
            return 10 * log10(baseValue) // Convert times to dB
        case .dbm:
            return 10 * log10(baseValue) // Convert mW to dBm
        case .mw:
            return baseValue // mW to mW (base unit)
        case .p1:
            return baseValue // Power input to power input (base unit)
        case .p2:
            return 10 * log10(baseValue / value) // Calculate gain in dB (P2/P1)
        }
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
        VStack(spacing: 5) { // Reduce spacing between rows
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 5) { // Reduce spacing between buttons
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            self.buttonTapped(button)
                        }) {
                            Text(button)
                                .font(.system(size: 20)) // Set the font size
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
    }
}

enum UnitType: String, CaseIterable {
    case watts = "Watts"
    case milliwatts = "Milliwatts"
    case bps = "Bps"
    case mbps = "Mbps"
    case ghz = "GHz"
    case hz = "Hz"
    case mhz = "MHz"
    case times = "Veces"
    case db = "dB"
    case dbm = "dBm"
    case mw = "mW"
    case p1 = "P1"
    case p2 = "P2"
}
