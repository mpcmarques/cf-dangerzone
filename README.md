
# 🚨 QBCore Danger Zone Script

A **FiveM script** that allows **police officers** (and optionally admins) to create, manage, and remove **danger zones**—marked locations on the map representing active threats, crimes, or emergencies.

Built on the **QBCore Framework**, this script enhances roleplay immersion by enabling real-time danger zone management for law enforcement roles.

---

## 🔧 Features

- 👮 Police-only `/1010` and `/remove1010` commands
- 🔧 Admin-only `/createdangerzone` and `/removedangerzone` commands
- 📍 Adds visible blips/zones on the map (requires client implementation)
- 🧠 Automatic synchronization on player join
- ♻️ Cleans up all zones when the resource stops

---

## 🛠️ Dependencies

- [QBCore Framework](https://github.com/qbcore-framework)
- `ox_lib` (for `lib.locale()` and command registration)

---

## 📦 Installation

1. **Clone or download** this repository into your server's `resources` folder.
2. Add to your `server.cfg`:
   ```cfg
   ensure rp_dangerzone
   ```
3. Make sure `ox_lib` and `qb-core` are started **before** this resource.

---

## 💻 Commands

| Command | Description | Permission |
|--------|-------------|------------|
| `/1010 [radius]` | Creates a danger zone at the officer's location | Police only |
| `/remove1010` | Removes the officer’s active danger zone | Police only |
| `/createdangerzone <name> [radius]` | Admin command to create a custom zone | Admin only |
| `/removedangerzone <name>` | Admin command to remove a named zone | Admin only |

### 🔹 Radius

- Optional in all commands
- Defaults to `100.0` units if not specified

---

## 🔐 Access Control

- Police-only access is enforced for `/1010` and `/remove1010`
- Admin-only commands (`/createdangerzone`, `/removedangerzone`) require group permissions via `ox_lib`'s `restricted` property

---

## 🔄 Zone Persistence

- Zones are **temporary and reset** when the resource stops or restarts.
- Use external database support or file writing if persistence is needed across restarts.

---

## 📂 Code Overview

- **Command Handling**: Uses `lib.addCommand` from `ox_lib`
- **Event Dispatching**:
  - `rp_dangerzone:new` and `rp_dangerzone:remove` to add/remove zones
  - `rp_dangerzones:updateAll` triggers client updates
- **Zone Storage**: Managed by the internal `DangerZones` module (`server.model.zones`)
- **Sync on Join**: Zones are sent to players when they load in (`QBCore:Server:OnPlayerLoaded`)

---

## ⚠️ Important Notes

- The client-side display of zones (`rp_dangerzones:updateAll`) **must be implemented** separately.
- Make sure all officers have the correct job roles defined in QBCore (`police`).
- Zones are keyed either by **citizen ID** or **custom names**, depending on the command used.

---

## 📜 License

This script is open-source and provided under the **MIT License**. Modify and use freely for personal or community servers.

---

## 🤝 Credits

Developed by [Codex Factory]  
Powered by [QBCore Framework](https://github.com/qbcore-framework) & [ox_lib](https://overextended.dev/)

## Check out other scripts in our Discord:
https://discord.gg/RHA2ZZdKbM

