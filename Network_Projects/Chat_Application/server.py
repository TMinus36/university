import socket
import select

HEADER_LENGTH = 10
IP = '127.0.0.1'
PORT = 1234

server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server_socket.bind((IP, PORT))
server_socket.listen()

sockets_list = [server_socket]
clients = {}

def receive_message(client_socket):
    try:
        msg_header = client_socket.recv(HEADER_LENGTH)
        if not msg_header: return False
        msg_length = int(msg_header.decode('utf-8').strip())
        return {'header': msg_header, 'data': client_socket.recv(msg_length)}
    except:
        return False

print(f'Listening on {IP}:{PORT}...')

while True:
    read_sockets, _, exception_sockets = select.select(sockets_list, [], sockets_list)
    for notified_socket in read_sockets:
        if notified_socket == server_socket:
            client_socket, client_address = server_socket.accept()
            user = receive_message(client_socket)
            if not user: continue
            sockets_list.append(client_socket)
            clients[client_socket] = user
            print(f'Accepted new connection from {client_address[0]}:{client_address[1]} username:{user["data"].decode()}')
        else:
            message = receive_message(notified_socket)
            if not message:
                print(f'Closed connection from {clients[notified_socket]["data"].decode()}')
                sockets_list.remove(notified_socket)
                del clients[notified_socket]
                continue
            user = clients[notified_socket]
            print(f'Received message from {user["data"].decode()}: {message["data"].decode()}')
            for client_socket in clients:
                if client_socket != notified_socket:
                    client_socket.send(user['header'] + user['data'] + message['header'] + message['data'])

    for notified_socket in exception_sockets:
        sockets_list.remove(notified_socket)
        del clients[notified_socket]
