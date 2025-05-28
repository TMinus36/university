```cpp
class Product {
private:
    std::string id;
    std::string name;
    int quantity;
    double price;
public:
    Product();
    Product(std::string, std::string, int, double);
    std::string getId() const;
    std::string getName() const;
    int getQuantity() const;
    double getPrice() const;
    void setName(std::string);
    void setQuantity(int);
    void setPrice(double);
    void display() const;
};
```
---
