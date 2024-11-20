# Orbital Asteroid Defense

Created: 2024-11-18

Status: Tasking

- [x] Scope
- [x] Tasking
- [x] Setup Project
- [ ] Create Planets
  - [x] Create circular orbit/s
  - [x] Create Planet Sprites & Collider
- [ ] Setup Player controller
  - [ ] Line rotates around player planet to indicate fire direction
  - [ ] Ability to fire missiles
- [ ] Create Missile/s
  - [ ] Missiles are drawn towards planets based on gravity value
  - [ ] Missiles explode on collision
  - [ ] (OP) Missiles leave trail
- [ ] Create Asteroids
  - [ ] Asteroids are drawn to player planet (they ignore other planets, pretend they are sentient and angry)
  - [ ] Asteroids are destroyed on collision (w planets, missiles)
- [ ] Create Game Manager
  - [ ] Track Score
  - [ ] Spawn Asteroids
  - [ ] Handle game over/reset
  - [ ] Manage Missile Pool
- [ ] Create sounds
  - [ ] Missile explosion
  - [ ] Missile launch
  - [ ] Asteroid destroyed
  - [ ] Planet Destroyed / Game over

## Concept - What it is

Survival shooter where you have to defend Earth from extinction-level asteroids hurtling towards the planet. The player will fire missiles from the planet towards the asteroids, with the missiles being affected by the gravity of other planets/bodies in the system. The challenge will be to fire the missiles trough the orbits of the planets to hit the asteroids in time.

## Pillars - What's the focus?

- Small, self-contained gameplay between sessions. This will be a desk toy. You pull it up while watching a YT video and fiddle for a bit while doing something else
- Minimal and highly abstract presentation. The visuals exist to communicate game state in a clean manner. They should be informative, and all visuals will have to justify their occupation of window space
- Antijank. The only redeeming this whole thing is basically a means to deliver simple gameplay. If something grates on the flow state, it gets fixed. 

## Limitations - Time, Tools, and Targets

- **Purpose:** To learn and reinforce familiarity with the Godot Editor and GDScript, as well as expand knowledge with basic features of Godot
- **Time Limit:** 20h
- **Team:** Me
- **Target Platform:** 
  - Windows (my machine)
  - Web (itch.io embed)
- **Target Inputs:** 
  - Keyboard
- **Tools:**
  - Godot 4.3 & GDScript for code and compile
  - ChipTone & Reaper for sound
  - MS Paint for icon
  - Git & Github for versioning and archive

## Art

- **Sound:** Blips and bloops. Sound will be entirely abstract and more or less serve only to improve feedback by adding exclamation points to events.
- **Visuals:** Highly simplified monochrome visual style using only Godot's inbuilt gradient textures. Art will be composed of simple shapes made by combining square sprites and layering them. Animations will be purely side-effects of mechanics

## Mechanics

- Asteroids will spawn indefinitely and be attracted towards the planet

- The player will be able to fire missiles from the planet to try and destroy these asteroids before they collide

- Player will rotate the trjectory of the missile either clockwise or counter-clockwise around the planet.

- Both missiles and asteroids will be subject to the gravitational pull of the planets in the system

- The player has a limited number of missiles that can be in play at any given moment (if three is the limit, and the player has three missiles active, the player can't shoot again till one of them is destroyed/expires)

- The player gains a point for each asteroid destroyed

- The game ends if the planet is hit
