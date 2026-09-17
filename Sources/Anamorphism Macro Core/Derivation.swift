import Corecursive_Macro_Core
public import SwiftSyntax
import SwiftSyntaxBuilder

public enum Derivation {
    public static func expansion(of declaration: EnumDeclSyntax) -> [DeclSyntax] {
        Corecursive_Macro_Core.Derivation.expansion(of: declaration)
            + operation(of: declaration)
    }

    public static func operation(of declaration: EnumDeclSyntax) -> [DeclSyntax] {
        let access = declaration.modifiers.contains { $0.name.tokenKind == .keyword(.public) }
            ? "public " : ""
        return ["""
            \(raw: access)static func anamorphism<Seed>(
                _ seed: Seed,
                _ coalgebra: (Seed) -> Base<Seed>
            ) -> Self {
                embed(coalgebra(seed).map { anamorphism($0, coalgebra) })
            }
            """]
    }
}
