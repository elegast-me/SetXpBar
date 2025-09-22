# SetXpBar

## Description

SetXpBar is a World of Warcraft addon designed to work in conjunction with the **AzerothCore `mod-individual-xp` module**. It allows players to easily control their experience gain rate by right-clicking their XP bar. Players can access a menu to select a desired XP rate or input a custom value, which is then communicated to the `mod-individual-xp` module.

## Features

*   **Quick XP Rate Selection:** Choose from predefined XP rates (x1, x2, x3, x4, x5) via a dropdown menu.
*   **Custom XP Rate:** Set a specific XP rate using a custom input dialog.
*   **UI Integration:** Works with both ElvUI's experience bar and the default World of Warcraft experience bar.
*   **Dependency Integration:** Communicates the selected XP rate to the `mod-individual-xp` module via chat commands.

## Requirements

*   World of Warcraft client.
*   **AzerothCore `mod-individual-xp` module installed and active on the realm.** This addon is a client-side interface for that module.
    *   Module repository: [https://github.com/azerothcore/mod-individual-xp](https://github.com/azerothcore/mod-individual-xp)

## Installation

1.  Download the addon.
2.  Extract the `SetXpBar` folder into your World of Warcraft `Interface\AddOns` directory.
3.  Ensure the **AzerothCore `mod-individual-xp` module** is installed and configured on your server.
4.  Restart your World of Warcraft client.

## Usage

1.  Locate your experience bar (XP bar) on your UI.
2.  **Right-click** on the XP bar.
3.  A menu will appear with options:
    *   "Experience:" (Title)
    *   "x1", "x2", "x3", "x4", "x5" (Predefined rates)
    *   "Custom" (Opens a dialog to enter a specific rate)
4.  Select an option to set the XP rate. The change will be sent to the `mod-individual-xp` module.

## Authors

*   brian8544
*   Rochet2
*   talamortis
*   Elegast.Me

## Version

1.0