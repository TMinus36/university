```cpp
class InventoryManager {
private:
    std::vector<Product> products;
public:
    void addProduct(const Product&);
    void showAll() const;
    int findProductIndex(const std::string&) const;
    void searchById(const std::string&) const;
    void editProduct(const std::string&);
    void deleteProduct(const std::string&);
    void saveToFile(const std::string&) const;
    void loadFromFile(const std::string&);
};
```
---
