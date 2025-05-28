#include <iostream>
using namespace std;

struct TreeNode {
    int data;
    TreeNode* left;
    TreeNode* right;
};

class BST {
    TreeNode* root;

    TreeNode* insert(TreeNode* node, int val) {
        if (!node) return new TreeNode{val, nullptr, nullptr};
        if (val < node->data) node->left = insert(node->left, val);
        else node->right = insert(node->right, val);
        return node;
    }

    void inOrder(TreeNode* node) {
        if (!node) return;
        inOrder(node->left);
        cout << node->data << " ";
        inOrder(node->right);
    }

public:
    BST() : root(nullptr) {}
    void insert(int val) { root = insert(root, val); }
    void display() { inOrder(root); cout << endl; }
};
