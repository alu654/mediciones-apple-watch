//
//  UnitConversionTests.swift
//  Medicion Watch AppTests
//
//  Created by Alan Fried on 17/05/2024.
//
import XCTest
@testable import Medicion_Watch_App // Reemplaza con el nombre de tu proyecto

class UnitConversionTests: XCTestCase {

    var converter: ContentView!

    override func setUp() {
        super.setUp()
        converter = ContentView()
    }

    override func tearDown() {
        converter = nil
        super.tearDown()
    }

    // dBm to other units
    func testConversion_dBm_to_Milliwatts() {
        let result = converter.convert(value: 50, from: .dbm, to: .milliwatts)
        XCTAssertEqual(result, 100000, accuracy: 0.0001)
    }

    func testConversion_dBm_to_Watts() {
        let result = converter.convert(value: 50, from: .dbm, to: .watts)
        XCTAssertEqual(result, 100, accuracy: 0.0001)
    }

    func testConversion_dBm_to_Kilowatts() {
        let result = converter.convert(value: 50, from: .dbm, to: .kilowatts)
        XCTAssertEqual(result, 0.1, accuracy: 0.0001)
    }

    // Watts to other units
    func testConversion_Watts_to_Milliwatts() {
        let result = converter.convert(value: 1, from: .watts, to: .milliwatts)
        XCTAssertEqual(result, 1000, accuracy: 0.0001)
    }

    func testConversion_Watts_to_Microwatts() {
        let result = converter.convert(value: 1, from: .watts, to: .microwatts)
        XCTAssertEqual(result, 1000000, accuracy: 0.0001)
    }

    func testConversion_Watts_to_Kilowatts() {
        let result = converter.convert(value: 1000, from: .watts, to: .kilowatts)
        XCTAssertEqual(result, 1, accuracy: 0.0001)
    }

    // Kilowatts to other units
    func testConversion_Kilowatts_to_Watts() {
        let result = converter.convert(value: 1, from: .kilowatts, to: .watts)
        XCTAssertEqual(result, 1000, accuracy: 0.0001)
    }

    func testConversion_Kilowatts_to_Milliwatts() {
        let result = converter.convert(value: 0.1, from: .kilowatts, to: .milliwatts)
        XCTAssertEqual(result, 100000, accuracy: 0.0001)
    }

    func testConversion_Kilowatts_to_Microwatts() {
        let result = converter.convert(value: 0.001, from: .kilowatts, to: .microwatts)
        XCTAssertEqual(result, 1000000, accuracy: 0.0001)
    }

    // Milliwatts to other units
    func testConversion_Milliwatts_to_Watts() {
        let result = converter.convert(value: 1000, from: .milliwatts, to: .watts)
        XCTAssertEqual(result, 1, accuracy: 0.0001)
    }

    func testConversion_Milliwatts_to_Microwatts() {
        let result = converter.convert(value: 1, from: .milliwatts, to: .microwatts)
        XCTAssertEqual(result, 1000, accuracy: 0.0001)
    }

    func testConversion_Milliwatts_to_Kilowatts() {
        let result = converter.convert(value: 1000000, from: .milliwatts, to: .kilowatts)
        XCTAssertEqual(result, 1, accuracy: 0.0001)
    }

    // Microwatts to other units
    func testConversion_Microwatts_to_Watts() {
        let result = converter.convert(value: 1000000, from: .microwatts, to: .watts)
        XCTAssertEqual(result, 1, accuracy: 0.0001)
    }

    func testConversion_Microwatts_to_Milliwatts() {
        let result = converter.convert(value: 1000, from: .microwatts, to: .milliwatts)
        XCTAssertEqual(result, 1, accuracy: 0.0001)
    }

    func testConversion_Microwatts_to_Kilowatts() {
        let result = converter.convert(value: 1000000000, from: .microwatts, to: .kilowatts)
        XCTAssertEqual(result, 1, accuracy: 0.0001)
    }

    // bps to other units
    func testConversion_Bps_to_Kbps() {
        let result = converter.convert(value: 1000, from: .bps, to: .kbps)
        XCTAssertEqual(result, 1, accuracy: 0.0001)
    }

    func testConversion_Bps_to_Mbps() {
        let result = converter.convert(value: 1000000, from: .bps, to: .mbps)
        XCTAssertEqual(result, 1, accuracy: 0.0001)
    }

    // Kbps to other units
    func testConversion_Kbps_to_Bps() {
        let result = converter.convert(value: 1, from: .kbps, to: .bps)
        XCTAssertEqual(result, 1000, accuracy: 0.0001)
    }

    func testConversion_Kbps_to_Mbps() {
        let result = converter.convert(value: 1000, from: .kbps, to: .mbps)
        XCTAssertEqual(result, 1, accuracy: 0.0001)
    }

    // Mbps to other units
    func testConversion_Mbps_to_Bps() {
        let result = converter.convert(value: 1, from: .mbps, to: .bps)
        XCTAssertEqual(result, 1000000, accuracy: 0.0001)
    }

    func testConversion_Mbps_to_Kbps() {
        let result = converter.convert(value: 1, from: .mbps, to: .kbps)
        XCTAssertEqual(result, 1000, accuracy: 0.0001)
    }

    // Volts to other units
    func testConversion_Volts_to_Millivolts() {
        let result = converter.convert(value: 1, from: .volts, to: .millivolts)
        XCTAssertEqual(result, 1000, accuracy: 0.0001)
    }

    func testConversion_Millivolts_to_Volts() {
        let result = converter.convert(value: 1000, from: .millivolts, to: .volts)
        XCTAssertEqual(result, 1, accuracy: 0.0001)
    }

    // Frequency units
    func testConversion_GHz_to_Hz() {
        let result = converter.convert(value: 1, from: .ghz, to: .hz)
        XCTAssertEqual(result, 1000000000, accuracy: 0.0001)
    }

    func testConversion_GHz_to_MHz() {
        let result = converter.convert(value: 1, from: .ghz, to: .mhz)
        XCTAssertEqual(result, 1000, accuracy: 0.0001)
    }

    func testConversion_MHz_to_Hz() {
        let result = converter.convert(value: 1, from: .mhz, to: .hz)
        XCTAssertEqual(result, 1000000, accuracy: 0.0001)
    }

    func testConversion_kHz_to_Hz() {
        let result = converter.convert(value: 1, from: .khz, to: .hz)
        XCTAssertEqual(result, 1000, accuracy: 0.0001)
    }

    func testConversion_Hz_to_MHz() {
        let result = converter.convert(value: 1000000, from: .hz, to: .mhz)
        XCTAssertEqual(result, 1, accuracy: 0.0001)
    }

    func testConversion_Hz_to_kHz() {
        let result = converter.convert(value: 1000, from: .hz, to: .khz)
        XCTAssertEqual(result, 1, accuracy: 0.0001)
    }

    // Times and dB
    func testConversion_dB_to_Times() {
        let result = converter.convert(value: 10, from: .db, to: .times)
        XCTAssertEqual(result, 10, accuracy: 0.0001)
    }

    func testConversion_Times_to_dB() {
        let result = converter.convert(value: 10, from: .times, to: .db)
        XCTAssertEqual(result, 10, accuracy: 0.0001)
    }

    // Baud rates
    func testConversion_Baud_to_MBaud() {
        let result = converter.convert(value: 1000000, from: .baudios, to: .mbaudios)
        XCTAssertEqual(result, 1, accuracy: 0.0001)
    }

    func testConversion_MBaud_to_Baud() {
        let result = converter.convert(value: 1, from: .mbaudios, to: .baudios)
        XCTAssertEqual(result, 1000000, accuracy: 0.0001)
    }

    // Packets per second (pps)
    func testConversion_Pps_to_Kpps() {
        let result = converter.convert(value: 1000, from: .pps, to: .kpps)
        XCTAssertEqual(result, 1, accuracy: 0.0001)
    }

    func testConversion_Pps_to_Mpps() {
        let result = converter.convert(value: 1000000, from: .pps, to: .mpps)
        XCTAssertEqual(result, 1, accuracy: 0.0001)
    }

    func testConversion_Kpps_to_Pps() {
        let result = converter.convert(value: 1, from: .kpps, to: .pps)
        XCTAssertEqual(result, 1000, accuracy: 0.0001)
    }

    func testConversion_Mpps_to_Pps() {
        let result = converter.convert(value: 1, from: .mpps, to: .pps)
        XCTAssertEqual(result, 1000000, accuracy: 0.0001)
    }

    // Tests for P1 to P2 conversions
    func testConversion_P1_to_P2() {
        let result = converter.convert(value: 2, from: .p1, to: .p2)
        XCTAssertEqual(result, 10 * log10(2), accuracy: 0.0001)
    }

    func testConversion_P2_to_P1() {
        let result = converter.convert(value: 10, from: .p2, to: .p1)
        XCTAssertEqual(result, pow(10, 10 / 10), accuracy: 0.0001)
    }

    // Add more tests for all the units defined in UnitType as needed
}
