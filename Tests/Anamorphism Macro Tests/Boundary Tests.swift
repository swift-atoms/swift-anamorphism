import Corecursive_Macro
import Functor_Base_Macro
import Anamorphism_Macro
import Testing

@Corecursive
@FunctorBase
@Anamorphism
private indirect enum Tree {
    case leaf
    case node(Tree, Tree)
}

private func leaves(_ tree: Tree) -> Int {
    switch tree {
    case .leaf: 1
    case let .node(left, right): leaves(left) + leaves(right)
    }
}

@Suite
struct `Anamorphism boundaries` {
    @Test
    func `a seed that stops at once unfolds to the base case`() {
        let tree = Tree.anamorphism(0) { depth -> Tree.Base<Int> in
            depth == 0 ? .leaf : .node(depth - 1, depth - 1)
        }
        #expect(leaves(tree) == 1)
    }

    @Test
    func `both children of a node are unfolded`() {
        let tree = Tree.anamorphism(4) { depth -> Tree.Base<Int> in
            depth == 0 ? .leaf : .node(depth - 1, depth - 1)
        }
        #expect(leaves(tree) == 16)
    }
}
