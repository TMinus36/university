#include "LinkedList.cpp"
#include "Stack.cpp"
#include "BST.cpp"
#include "Sorting.cpp"
#include "Graph.cpp"

int main() {
    cout << "LinkedList Demo:\n";
    LinkedList list;
    list.insert(10);
    list.insert(20);
    list.insert(30);
    list.display();

    cout << "\nStack Demo:\n";
    Stack s;
    s.push(5); s.push(10);
    cout << "Top: " << s.top() << endl;
    s.pop();
    cout << "Top after pop: " << s.top() << endl;

    cout << "\nBST Demo:\n";
    BST tree;
    tree.insert(50); tree.insert(30); tree.insert(70);
    tree.display();

    cout << "\nBubble Sort Demo:\n";
    vector<int> arr = {64, 25, 12, 22, 11};
    bubbleSort(arr);
    for (int x : arr) cout << x << " ";
    cout << endl;

    cout << "\nGraph BFS Demo:\n";
    Graph g(5);
    g.addEdge(0, 1); g.addEdge(0, 4); g.addEdge(1, 2);
    g.bfs(0);

    return 0;
}
