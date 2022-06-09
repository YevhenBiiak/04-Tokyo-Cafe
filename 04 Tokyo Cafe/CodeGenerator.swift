//
//  CodeGenerator.swift
//  04 Tokyo Cafe
//
//  Created by Евгений Бияк on 07.06.2022.
//

protocol GeneratorProtocol {
    func getRandomValue() -> String
}

struct CodeGenerator: GeneratorProtocol {
    func getRandomValue() -> String {
        let code = "0000\(Int.random(in: 0...9999))"
        return String(code.suffix(4))
    }
}
