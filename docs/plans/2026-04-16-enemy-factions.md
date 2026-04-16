# Scaredew Valley — Enemy Faction System

**Status:** Work in progress

---

## Overview

Enemies are organized into factions, each with a distinct identity, escalating leadership tiers, and lore. Factions are part of the meta-progression unlock pool — early runs see fewer factions with shallow hierarchies. As players progress across runs, new factions, enemy tiers, and bosses unlock permanently, adding depth to factions already encountered.

---

## Structure

### Faction Template

Each faction has:

- **Fodder** — rank and file enemies
- **Captain** — first named boss, organizes the fodder into a real threat
- **Lieutenant** — mid-boss, escalates the faction's power
- **Leader** — faction boss, the true power behind the faction

Leadership tiers unlock **in order** across runs (captain → lieutenant → leader). Once unlocked, a boss is guaranteed to appear in any run that includes their faction, if the player survives long enough.

### Runs

- Seed determines which factions appear and in what order
- Early runs feature 2 factions; the pool expands with meta-progression
- Each faction is balanced to scale correctly regardless of order
- Cthulhu sits above all factions as the finale

---

## The Five Factions

### 1. Undead — Numbers, Relentless

The introductory threat. Deepest faction hierarchy.

| Tier | Role | Type | Notes |
|------|------|------|-------|
| Fodder | rank and file | **Zombies, Ghouls** | Slow swarms, break walls. The baseline threat that teaches you the game. |
| Captain | first boss | **The Lich** | Organizes the dead into coordinated waves. Beat them and things calm down — until something worse steps in. |
| Lieutenant | mid-boss | **TBD** | Something between the Lich and the Necromancer. |
| Leader | faction boss | **The Necromancer** | The one pulling the strings. Human or something else — TBD. Potential connections to Vess's cult and Everett's ritual. |

### 2. Vampires — Speed, Power, Cunning

Supernaturally quick, strong, and hard to kill. Age = power. Fledglings look the most human; the Nosferatu looks the least.

| Tier | Role | Type | Notes |
|------|------|------|-------|
| Fodder | rank and file | **Fledglings** | Fast, strong, but undisciplined. Prone to bloodfury — dangerous but predictable. |
| Captain | first boss | **TBD (Enforcer type)** | Mature vampire. Controlled, tactical, uses abilities (charm, mist form). |
| Lieutenant | mid-boss | **The Baron/Baroness** | Old money, old power. Thinks they're in charge. Organized, commands the others. |
| Leader | faction boss | **Ancient Nosferatu** | The real thing. Monstrous, barely human-looking. Centuries of power. The Baron was a puppet. |

### 3. Werewolves — Strength, Durability

Pure physical escalation. Each tier is just *more* — more durable, more damage, more unstoppable. Forces you to get smarter because you can't match it head-on.

| Tier | Role | Type | Notes |
|------|------|------|-------|
| Fodder | rank and file | **The Cursed** | Recently turned, feral, all muscle. Hard to put down, hit like trucks. The "wall test." |
| Captain | first boss | **The Alpha** | Biggest, strongest of the pack. Not clever — just relentless. Keeps getting back up. Tears through walls that stopped everything else. |
| Lieutenant | mid-boss | **The Packmother/Packfather** | Old, scarred, has survived everything. Absorbs punishment that should kill anything. Pack fights harder around them, won't retreat while they stand. |
| Leader | faction boss | **The Skinwalker** | Older than words. The curse is a pale imitation of what this thing does naturally. Shifts between any form at will. Strength and durability that breaks your scaling. A force of nature wearing skin. |

### 4. Eldritch — Alien, Unknowable

Not a traditional faction. No hierarchy in the human sense. Not hostile — doesn't even know you're there. The horror is indifference. The Deep One can offer lore insights into what they want, but this is story flavor, not a gameplay gate.

| Tier | Role | Type | Notes |
|------|------|------|-------|
| Fodder | rank and file | **Shoggoths** | Massive, formless, absorb damage, split into blobs. Not evil — just *moving*. Like weather that dissolves walls. |
| Captain | first emissary | **The Mouth** | Shows up and talks. Nobody understands. Clearly trying to communicate something. Aggressive when ignored. |
| Lieutenant | second emissary | **The Geometry** | Doesn't obey physics. Angles that hurt to look at. Passes through walls because it doesn't understand walls. |
| Leader | faction boss | **The Dreamer** | Not awake. The attacks are the dreams of something sleeping underneath. Fighting it means entering the dream. Defeating it doesn't kill it — just makes it roll over. For now. |

### 5. Spirits — Curses, Debuffs

Not a combat faction. A persistent haunting that erodes the settlement from the inside while other factions hit the perimeter. Escalation is layers of curse, not waves of enemies. The "boss fight" is knowledge, not combat. Smartypants characters (Rem, Everett, Mabel) are essential here.

| Tier | Role | Type | Effect |
|------|------|------|--------|
| Fodder | ambient haunting | **Whispers** | Low-level mood debuffs, bad dreams, characters on edge. Background noise. |
| Captain | first named spirit | **The Weeping** | Targets specific characters. Morale drain on one person, spreading to those close to them. Research to identify, ritual to cleanse. |
| Lieutenant | deeper curse | **The Hollow** | Affects buildings — stops them functioning, crops wilt, turrets jam. The settlement itself feels sick. |
| Leader | the source | **The Grief** | An ancient sorrow, a death so big it left a scar on the land. Cleansing it is a major research quest across multiple nights. |

---

## Meta-Progression

The enemy roster is part of the Isaac-style unlock pool:

- **First runs:** 2 factions, fodder only (e.g., zombies + fledglings)
- **Unlock triggers:** reaching certain nights, defeating bosses, achieving milestones
- **Boss unlocks are sequential:** must beat the Captain before the Lieutenant can appear in future runs, must beat the Lieutenant before the Leader enters the pool
- **Once unlocked, guaranteed:** a boss is permanently part of their faction. They will appear in any run featuring that faction if you survive long enough.
- **Pool expands over time:** more factions, deeper hierarchies, eventually all five factions available with full leadership chains

The world gets deeper as you play. Early runs are simpler on purpose.

---

## Open Questions

- Undead lieutenant between Lich and Necromancer — who/what?
- Vampire captain/enforcer — name and identity
- Necromancer connections to Vess's cult / Everett's ritual
- How do factions interact when multiple appear in the same run? Overlap? Alliances? Conflicts?
- Spirit faction interaction with the Hearth Spirit character
- Specific unlock triggers for each tier
- Cthulhu as finale — how does it relate to the faction system?
- Named enemy lore delivery — how do you hear about bosses before you fight them? (Excursion intel, character dialogue, commune warnings?)
