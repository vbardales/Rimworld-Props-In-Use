# The anima tree reads 0.28 on its own. The Alpha Props hedges used to count as artificial buildings
# and weaken it; the mod clears that flag. The hedges themselves add nothing: they are impassable,
# and the base game's building offset (FocusStrengthOffset_BuildingDefs) only counts buildings
# whose district is the tree's, which an impassable building never has (ticket 8dbc, 2026-11-12).
# So the stat must stay at 0.28 with hedges around the tree: a weaker value means the fix is gone.
@functional
@requires:sarg.alphapropsparks
@requires:ludeon.rimworld.royalty
@requires:nelim.pickletools.stagedecor
Feature: Props in Use stops the Alpha Props hedges from weakening the anima tree

  Background:
    Given the save "test-colony" is loaded
    And I close all dialogs
    And Nelim's Pickle Tools: I place the decor "Plant_TreeAnima" at (112, 222) fully grown

  Scenario: without a hedge the anima tree keeps its own strength
    Then the "Plant_TreeAnima" at (112, 222) stat "MeditationFocusStrength" is 0.28

  Scenario: anima hedges around the tree do not weaken it
    Given Nelim's Pickle Tools: I place the decor "AP_Hedge_Anima" owned by the colonists at (108, 222)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Anima" owned by the colonists at (109, 222)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Anima" owned by the colonists at (110, 222)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Anima" owned by the colonists at (111, 222)
    When I wait 120 ticks
    Then the "Plant_TreeAnima" at (112, 222) stat "MeditationFocusStrength" is 0.28

  Scenario: gauranlen hedges around the tree do not weaken it
    Given Nelim's Pickle Tools: I place the decor "AP_Hedge_Gau" owned by the colonists at (108, 224)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Gau" owned by the colonists at (109, 224)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Gau" owned by the colonists at (110, 224)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Gau" owned by the colonists at (111, 224)
    When I wait 120 ticks
    Then the "Plant_TreeAnima" at (112, 222) stat "MeditationFocusStrength" is 0.28
