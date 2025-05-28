```cpp
Product::Product() : id(""), name(""), quantity(0), price(0.0) {}
Product::Product(std::string id, std::string name, int quantity, double price)
    : id(id), name(name), quantity(quantity), price(price) {}
std::string Product::getId() const { return id; }
std::string Product::getName() const { return name; }
int Product::getQuantity() const { return quantity; }
double Product::getPrice() const { return price; }
void Product::setName(std::string name) { this->name = name; }
void Product::setQuantity(int quantity) { this->quantity = quantity; }
void Product::setPrice(double price) { this->price = price; }
void Product::display() const {
    std::cout << "ID: " << id
              << " | Name: " << name
              << " | Quantity: " << quantity
              << " | Price: $" << price << std::endl;
}
```
---
