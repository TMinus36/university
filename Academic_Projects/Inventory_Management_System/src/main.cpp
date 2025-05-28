```cpp
int main() {
    InventoryManager manager;
    std::string choice, id, name;
    int quantity;
    double price;
    while (true) {
        std::cout << "\n== Inventory Tracker ==\n";
        std::cout << "1. Add Product\n2. Show All\n3. Search by ID\n4. Edit Product\n5. Delete Product\n6. Save to File\n7. Load from File\n8. Exit\nChoice: ";
        std::cin >> choice;
        if (choice == "1") {
            std::cout << "Enter ID: "; std::cin >> id;
            std::cout << "Enter Name: "; std::cin >> name;
            std::cout << "Enter Quantity: "; std::cin >> quantity;
            std::cout << "Enter Price: "; std::cin >> price;
            manager.addProduct(Product(id, name, quantity, price));
        } else if (choice == "2") {
            manager.showAll();
        } else if (choice == "3") {
            std::cout << "Enter ID: "; std::cin >> id;
            manager.searchById(id);
        } else if (choice == "4") {
            std::cout << "Enter ID to edit: "; std::cin >> id;
            manager.editProduct(id);
        } else if (choice == "5") {
            std::cout << "Enter ID to delete: "; std::cin >> id;
            manager.deleteProduct(id);
        } else if (choice == "6") {
            manager.saveToFile("inventory.txt");
        } else if (choice == "7") {
            manager.loadFromFile("inventory.txt");
        } else if (choice == "8") {
            break;
        } else {
            std::cout << "Invalid option.\n";
        }
    }
    return 0;
}
```
---
This C++ project builds core competency in class-based programming and file handling. It's structured for easy enhancement—like adding categories, inventory warnings, or sorting.
