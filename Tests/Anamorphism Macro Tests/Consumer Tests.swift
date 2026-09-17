import Anamorphism_Macro
import Testing

@Anamorphism
private indirect enum Natural {
    case zero
    case successor(Natural)
}

@Test
func `anamorphism unfolds a seed`() {
    let two = Natural.anamorphism(2) { seed -> Natural.Base<Int> in
        seed == 0 ? .zero : .successor(seed - 1)
    }
    guard case .successor(.successor(.zero)) = two else {
        Issue.record("Expected two successors")
        return
    }
}
