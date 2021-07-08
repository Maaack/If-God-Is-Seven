# Roadmap
## V 0.1

### Goals
* 10-20 characters
* 5-10 locations
* Relationship map
    * Map one-way relationships between characters (Affinity)
* Dialogue system
    * Keep simple. No options yet. Print text and continue.
    * Rumors lose importance over time.
* Date / Time system
    * Date and time passes as actions are taken.
    * Schedule events to happen at certain times.
        * Citizens will learn new rumors.
* Location system
    * Pick a location from the map to move there. Pass time.
    * Locations have people to chat with, objects to pick up, interact with.
* Inventory system
    * Be able to pick up objects and refer to objects in your container.



### Sprint Plans
#### Sprint 1
* UI Elements
    * Buttons
    * Font
    * Panels
    * 9-Box
* Start Screen
    * Chiptune Music
    * Start Button
    * Quit Button
    * Credits Button
    * Creepy Background
* Play Screen
    * Current Location Label
    * Current Location Background
    * Current Date/Time
    * Actions Panel
        * Travel Options Panel
        * Open inventory
            * Always open?
        * Activity text
            * Moving to location
    * Character Stats
        * Current Health / Sanity
        * Full body outline?
        * Character portrait?
        

#### Sprint 2
* UI Elements
    * H Scroll Bar
    * V Scroll Bar
    * Progress Bar? 
* Locations
    * 4 in house
        * Bedroom
        * Kitchen
        * Living Room
        * Bathroom
    * Traveling between locations
    
#### Sprint 3
* UI Elements
    * Location-Specific Options Panel
        * Interactions
            * Look At
            * Listen To
            * Smell
            * Take
            * Talk to
            * Interact with
    * Popup Panel
        * Announce things on arrival to location
    * Temporal Awareness
        * Add comment when changing locations
        * Add time to clock when changing locations
        * Add days to calendar when time > 24:00
    
#### Sprint 4
* UI Redesign
    * Merge map and interactable window.
* World manager
    * Global time
    * Updates objects
    * Clock objects
* Dynamic Event System
    * Clocks read current time
    * Calendars show current date

#### Sprint 5
* Location short descriptions.
    * Set expectation of possible interactions.
* Use Interactions
    * Add hours or minutes to clocks.
    * Mark calendar days.
    * Sleep in beds.
    * Shut off alarm clocks.
* Smell Interactions
    * Pancakes in other rooms

#### Sprint 6
* Player Inventory
    * Player as Interactable
        * Container of other Interactables
* Events
    * X Close button
    * Can Close state
    * Streamline continuing if another event is chosen
        * Auto continue if can close and play next event

#### Sprint 7
* Dialogue screen
    * Speaking character
        * Portrait
        * Dialogue / text
        * Title / name
    * Reply options
        * Button
        * Sample text
        * Hint text