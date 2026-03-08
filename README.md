# Nexus

> Self-sovereign communication platform with cryptographic identity and low-friction deployment

Nexus is a decentralized communication platform that aims for a simple user experience with cryptographic identity. Your username and password deterministically generate an Ed25519 keypair—no registration, no email, no phone number required.

## Screenshots 
### Login
![alt text](media/login.png)  
### Main Window
![alt text](media/nexus.png)

## Features

- 🔐 **Cryptographic Identity** - Ed25519 keypairs derived from username + password
- 🆔 **Deterministic GUIDs** - Same credentials always produce the same identity
- 💬 **Real-time Chat** - WebSocket-based messaging with full history
- 🖥️ **Multiple Clients** - Desktop app, web app and tui coming later
- 🎙️ **Voice Chat** - Built-in SFU for low-latency voice channels
- 🌐 **Easy Deployment** - One command to run your own server
- 🔒 **Privacy-First** - Self-hosted, local-first data storage

## Quick Start

### Run a Server

**Docker (recommended):**
*Under Construction*

**Run Binary Directly:**
Simply run nexus-server using either windows or linux (currenlty supports Ubuntu)

Server runs on `https://localhost:8443` (TLS enabled by default) with:
- **Web Client:** https://localhost:8443/
- **Admin Panel:** https://localhost:8443/admin
- **WebSocket:** wss://localhost:8443/ws

### Connect as a User

**Desktop App:**
1. Download installer for your platform
2. Launch app and enter server URL
3. Login with username/password

> 💡 **Your identity is deterministic:** Same username + password = Same GUID across all clients

## How It Works

```
Username + Password
        ↓
    Argon2id (password derivation)
        ↓
   Ed25519 Keypair
        ↓
  SHA256(Public Key)
        ↓
      GUID
```

Your GUID is your identity. No server stores your password. Authentication uses challenge-response with digital signatures.

## Platform Support

### Current Release Platforms

Nexus provides pre-built binaries for the following platforms:

**Server**
- Ubuntu (x86_64)
- Windows (x86_64)

**Desktop App:**
- Linux (x86_64) - AppImage
- Windows (x86_64) - MSI

**Docker Images:**
- linux/amd64  
  
*More support will come at a later date as code base stabilizes*