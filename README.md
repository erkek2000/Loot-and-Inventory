# Loot and Inventory

A Godot inventory prototype demonstrating generated loot, equipment, item details, and transfers between a player inventory and containers.

## Features

- Random loot generation
- Inventory and loot-container panels
- Weapons and armor defined as resources
- Item information display
- JSON-backed item definitions
- Localization support

## Getting started

1. Install Godot 4.6 or a compatible Godot 4 release.
2. Import `project.godot` in the Godot Project Manager.
3. Open the project and press **F6** or **F5** to run it.

The main scene is `scenes/loot_container.tscn`.

## Project structure

- `items/` — item definitions
- `resources/` — weapon and armor resources
- `resources_scripts/` — resource classes
- `scenes/` — inventory UI and loot-container scenes
- `scripts/` — inventory, item, and loot-generation logic
- `translation/` — localization data

## Status

This project is a work in progress.
