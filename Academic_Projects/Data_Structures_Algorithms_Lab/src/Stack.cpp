#include <iostream>
#include <vector>
using namespace std;

class Stack {
    vector<int> elements;
public:
    void push(int x) { elements.push_back(x); }
    void pop() {
        if (!elements.empty()) elements.pop_back();
        else cout << "Stack underflow\n";
    }
    int top() {
        if (!elements.empty()) return elements.back();
        return -1;
    }
    bool isEmpty() { return elements.empty(); }
};
