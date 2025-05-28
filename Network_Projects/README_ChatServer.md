# 💬 TCP Chat Server (Python) — Real-Time Socket Communication

## 🌐 Objective
Demonstrate non-blocking, multi-client communication using low-level socket APIs and `select` in Python.

---

## 🧰 Technical Features
- Multi-user support
- Terminal-based chat interface
- Broadcasting with username tagging
- Non-blocking I/O via `select.select()`

---

## ⚙️ Architecture
- **Server**:
  - Accepts connections
  - Receives and broadcasts messages
- **Client**:
  - Sends/receives messages
  - Displays prompt and feedback

---

## 💻 Implementation Flow
1. Server binds and listens
2. Clients connect via TCP
3. Messages broadcasted with sender info
4. Select handles async I/O

---

## 📈 Expansion Paths
- SSL/TLS encryption
- User authentication
- GUI frontend (Tkinter or Electron)

---

## 👤 Author
Timothy Harris — T-Minus36
