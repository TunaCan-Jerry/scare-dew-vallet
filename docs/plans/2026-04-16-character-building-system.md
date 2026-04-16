# Scaredew Valley — Character Building System

**Status:** Work in progress

---

## Overview

Each recruitable character has a personal building that can be placed in the settlement. These buildings replace standalone crafting stations (Kitchen, Armory, Arcane Study, etc.) — every piece of infrastructure is someone's home and contribution. Buildings are upgraded through branching paths gated by heart level and resources, unlocking passives, ability upgrades, and character-specific recipes.

---

## Map Structure

Two zones:

- **The Farm** — crops, animals, foraging. Not defended, not attacked — enemies target people, not plants. Safe at night because no one is there.
- **The Settlement** — where everyone lives. Fixed building plots for character buildings, surrounded by a defensive perimeter. This is what enemies attack at night.

The settlement starts with a **shed** (upgradeable into an infirmary). Characters without a building sleep here. It also handles status effect treatment (ghoul plague, lycanthropy, etc.). The shed is functional but characters take a morale penalty for not having their own space.

**15 fixed plots** for character buildings. When a character is recruited, their building becomes available to construct on any open plot. You choose which plot, spend resources, and it goes up. Once built, the character moves in and gets a morale boost.

### Perimeter Breach = Game Over

Characters don't die individually. If the settlement perimeter is breached, it's game over — everyone is lost. This makes wall defense the singular survival pressure.

### Character Recruitment

Players choose between 2+ characters at recruitment events. Characters you don't pick end up at other survivor camps. Some of the characters you pass on don't make it — occasionally a zombie looks a little familiar.

12-15 characters end up on the farm per run, drawn from the unlocked pool.

---

## Character Buildings

Every character building has a **unique name and identity** tied to that character, built on a **shared archetype skeleton** based on their pillar.

### Five Building Archetypes (by Pillar)

| Pillar | Archetype Role | Replaces | Example |
|--------|---------------|----------|---------|
| Fighter | Combat station | Armory | Jasper's "The Blind" — ammo, weapon upgrades |
| Fixer | Workshop | Workbench | Rowan's "The Forge" — building upgrades, repair tools |
| Community | Gathering place | Kitchen | Greg's "The Hearth" — meals, morale recipes |
| Knowledge | Research station | Arcane Study | Rem's "The Library" — research, intel |
| Weird | Sanctum | Chapel | Ohm's "The Shrine" — blessings, rituals |

Characters with two different pillars (e.g., Marco is Fighter + Community) get a building that blends both archetypes — the primary pillar drives the building type, the secondary pillar flavors the branches.

### Construction

- Costs resources to build (scaling with character power/complexity)
- Character sleeps in the shed/infirmary until built
- Morale boost on completion

---

## Upgrade Structure

Each character building has **2-3 branches** depending on character complexity. Simpler characters (like Greg) have 2; complex characters (like Ohm) have 3. Branch choice is **permanent per run**, adding weight to the decision and replayability across runs.

### Gating

| Tier | Heart Level Required | Resource Cost | Unlocks |
|------|---------------------|---------------|---------|
| Tier 1 | Heart 2 | Low | Branch choice + first passive + basic recipes |
| Tier 2 | Heart 5 | Medium | Stronger passive + advanced recipes |
| Tier 3 | Heart 8 | High | Powerful passive + signature recipe/ability |

### What Upgrades Unlock

Three categories:

- **Passives** — always-on bonuses. Rowan's Forge branch might give all turrets +10% damage. Greg's Kitchen branch might give meals +1 morale.
- **Recipes** — things you craft at that building. Character-specific. Greg can cook unique meals nobody else can. Ohm can bless turrets in ways nobody else can.
- **Ability Upgrades** — improves the character's existing trait or night-phase contribution. Jasper's Dead Eye gets longer range or faster reload depending on branch.

### Example — Greg's "The Hearth" (Community archetype, 2 branches)

| | Branch A: "Family Table" | Branch B: "Campfire Songs" |
|--|--------------------------|---------------------------|
| Tier 1 | Comfort meals (+morale) | Guitar buffs extend to full settlement |
| Tier 2 | Group dinners (multi-character morale boost) | Songs reduce panic during waves |
| Tier 3 | Signature dish (full morale reset, 1/night) | Anthem (fear immunity, 1/night) |

---

## Open Questions

- How do building archetypes interact with the tag synergy system? (e.g., 2+ Maker buildings adjacent = Workshop Synergy bonus?)
- Should building placement within fixed plots matter strategically? (e.g., buildings closer to perimeter take more damage risk but provide defense bonuses?)
- What happens to a building's upgrades when the settlement is attacked — can buildings take damage and lose function temporarily?
- Specific branch designs for each of the 18 characters (TBD per character)
- Shed → Infirmary upgrade path details
- Visual differentiation for building archetypes and branches
