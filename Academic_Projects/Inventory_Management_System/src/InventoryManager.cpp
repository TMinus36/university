```cpp
void InventoryManager::addProduct(const Product& p) {
    products.push_back(p);
}
void InventoryManager::showAll() const {
    if (products.empty()) {
        std::cout << "No products available.\n";
        return;
    }
    for (const auto& p : products) {
        p.display();
    }
}
int InventoryManager::findProductIndex(const std::string& id) const {
    for (size_t i = 0; i < products.size(); ++i) {
        if (products[i].getId() == id) return i;
    }
    return -1;
}
void InventoryManager::searchById(const std::string& id) const {
    int index = findProductIndex(id);
    if (index != -1) products[index].display();
    else std::cout << "Product not found.\n";
}
void InventoryManager::editProduct(const std::string& id) {
    int index = findProductIndex(id);
    if (index != -1) {
        std::string name;
        int quantity;
        double price;
        std::cout << "New Name: ";
        std::cin >> name;
        std::cout << "New Quantity: ";
        std::cin >> quantity;
        std::cout << "New Price: ";
        std::cin >> price;
        products[index].setName(name);
        products[index].setQuantity(quantity);
        products[index].setPrice(price);
    } else {
        std::cout << "Product not found.\n";
    }
}
void InventoryManager::deleteProduct(const std::string& id) {
    int index = findProductIndex(id);
    if (index != -1) {
        products.erase(products.begin() + index);
        std::cout << "Product deleted.\n";
    } else {
        std::cout << "Product not found.\n";
    }
}
void InventoryManager::saveToFile(const std::string& filename) const {
    std::ofstream out(filename);
    for (const auto& p : products) {
        out << p.getId() << "," << p.getName() << "," << p.getQuantity() << "," << p.getPrice() << "\n";
    }
    std::cout << "Saved to file.\n";
}
void InventoryManager::loadFromFile(const std::string& filename) {
    std::ifstream in(filename);
    std::string id, name;
    int quantity;
    double price;
    products.clear();
    while (in >> id >> name >> quantity >> price) {
        products.emplace_back(id, name, quantity, price);
    }
    std::cout << "Loaded from file.\n";
}
```
---
