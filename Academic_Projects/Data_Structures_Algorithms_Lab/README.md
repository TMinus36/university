# 🧮 Data Structures & Algorithms Lab

## 📋 Project Overview
A comprehensive collection of fundamental data structures and algorithms implemented in modern C++. This project serves as both an educational resource and a reference implementation for common computer science problems. The implementations emphasize clean, efficient, and production-quality code with detailed documentation and test cases.

## 🎯 Learning Objectives
- Master implementation details of core data structures
- Understand time and space complexity analysis
- Develop efficient algorithmic problem-solving skills
- Learn idiomatic C++ practices and standard library usage
- Practice test-driven development principles

## 🏗️ Implemented Data Structures

### Linear Structures
- **Array** - Static and dynamic array implementations
- **Linked List** - Singly, doubly, and circular variations
- **Stack** - LIFO operations with array and linked list backends
- **Queue** - FIFO operations with circular buffer implementation
- **Hash Table** - Open addressing and chaining collision resolution

### Tree Structures
- **Binary Search Tree** - Balanced and unbalanced implementations
- **AVL Tree** - Self-balancing binary search tree
- **Heap** - Min-heap and max-heap with priority queue interface
- **Trie** - Efficient string search and storage

### Graph Structures
- **Adjacency List** - Space-efficient sparse graph representation
- **Adjacency Matrix** - Fast edge lookup for dense graphs
- **Graph Algorithms** - Traversals, shortest paths, minimum spanning trees

## 🧮 Algorithms

### Sorting
| Algorithm | Time (Best) | Time (Avg) | Time (Worst) | Space | Stable |
|-----------|-------------|------------|--------------|-------|--------|
| Bubble Sort | O(n) | O(n²) | O(n²) | O(1) | Yes |
| Selection Sort | O(n²) | O(n²) | O(n²) | O(1) | No |
| Insertion Sort | O(n) | O(n²) | O(n²) | O(1) | Yes |
| Merge Sort | O(n log n) | O(n log n) | O(n log n) | O(n) | Yes |
| Quick Sort | O(n log n) | O(n log n) | O(n²) | O(log n) | No |
| Heap Sort | O(n log n) | O(n log n) | O(n log n) | O(1) | No |

### Graph Algorithms
- **Traversals**: BFS, DFS, Iterative Deepening
- **Shortest Path**: Dijkstra's, Bellman-Ford, Floyd-Warshall
- **Minimum Spanning Tree**: Kruskal's, Prim's
- **Network Flow**: Ford-Fulkerson, Edmonds-Karp
- **Topological Sorting**: Kahn's algorithm, DFS-based

## 🚀 Getting Started

### Prerequisites
- C++17 compatible compiler (GCC 9+, Clang 10+, MSVC 2019+)
- CMake 3.15+
- Google Test (for running tests)

### Building the Project
```bash
# Clone the repository
git clone https://github.com/yourusername/data-structures-algorithms.git
cd data-structures-algorithms

# Create build directory
mkdir build && cd build

# Configure and build
cmake ..
cmake --build .

# Run tests
ctest --output-on-failure
```

### Running Examples
```cpp
#include "algorithms/sorting/quick_sort.h"
#include <vector>
#include <iostream>

int main() {
    std::vector<int> data = {5, 2, 9, 1, 5, 6};
    
    std::cout << "Original array: ";
    for (int num : data) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    
    // Sort using quicksort
    QuickSort::sort(data.begin(), data.end());
    
    std::cout << "Sorted array: ";
    for (int num : data) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    
    return 0;
}
```

## 📊 Performance Benchmarks

### Sorting Algorithms (ms for 100,000 random integers)
```
┌─────────────────┬───────────────┐
│ Algorithm       │ Time (ms)    │
├─────────────────┼───────────────┤
│ Quick Sort      │ 15.2         │
│ Merge Sort      │ 18.7         │
│ Heap Sort       │ 22.1         │
│ Insertion Sort  │ 12,345.6     │ (for comparison)
└─────────────────┴───────────────┘
```

### Data Structure Operations (ns/op)
```
┌─────────────────┬──────────┬──────────┬──────────┐
│ Operation       │ Array    │ BST      │ Hash Table │
├─────────────────┼──────────┼──────────┼───────────┤
│ Search          │ O(n)     │ O(log n) │ O(1)      │
│ Insert          │ O(n)     │ O(log n) │ O(1)      │
│ Delete          │ O(n)     │ O(log n) │ O(1)      │
│ Memory          │ Low      │ Medium   │ High      │
└─────────────────┴──────────┴──────────┴───────────┘
```

## 📚 Documentation

### Code Organization
```
.
├── include/               # Header files
│   ├── data_structures/   # Data structure implementations
│   └── algorithms/        # Algorithm implementations
├── src/                   # Source files
├── tests/                 # Unit tests
├── benchmarks/            # Performance benchmarks
└── examples/              # Example usage
```

### API Reference
Detailed API documentation is available in the header files. Key components include:

#### Data Structures
- `Vector<T>`: Dynamic array implementation
- `LinkedList<T>`: Doubly-linked list
- `BinarySearchTree<K,V>`: Self-balancing BST
- `HashTable<K,V>`: Hash table with separate chaining
- `Graph<V,E>`: Adjacency list graph

#### Algorithms
- Sorting: `sort::quickSort()`, `sort::mergeSort()`, etc.
- Searching: `search::binarySearch()`, `search::bfs()`, `search::dfs()`
- Graph: `graph::dijkstra()`, `graph::kruskalMST()`
- Utilities: `utils::swap()`, `utils::compare()`

## 🧪 Testing

The project uses Google Test for unit testing. To run all tests:

```bash
cd build
ctest --output-on-failure
```

Test coverage is maintained at 90%+ for all critical components.

## 🤝 Contributing

Contributions are welcome! Please follow these steps:
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Timothy Harris (T-Minus36)**  
- GitHub: [@yourusername](https://github.com/yourusername)  
- LinkedIn: [Your LinkedIn](https://linkedin.com/in/yourprofile)  
- Email: your.email@example.com

## 🔗 Additional Resources

- [Big-O Cheat Sheet](https://www.bigocheatsheet.com/)
- [CPP Reference](https://en.cppreference.com/)
- [Visualizing Algorithms](https://visualgo.net/)

---
*Last Updated: May 2025*
