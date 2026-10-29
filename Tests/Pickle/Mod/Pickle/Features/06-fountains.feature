# The meditation focus strength is read through the game's own stat worker, which adds the offsets
# of the focus component. Nothing artificial stands near (the fixture's ruins are 40 cells away
# and the fountains no longer count as artificial), so each fountain reads exactly the strength
# the patch gives it and the anima tree keeps its own 0.28. Strength follows the size, the zen
# fountain one step above its twins. Cells are on a free band of test-colony, south of Jet.
@functional
@requires:sarg.alphapropsparks
@requires:ludeon.rimworld.royalty
@requires:nelim.pickletools.stagedecor
Feature: Props in Use turns the Alpha Props fountains into natural meditation foci

  Background:
    Given the save "test-colony" is loaded
    And I close all dialogs

  Scenario: each fountain reads the focus strength its size earns, beside the others
    Given I spawn a "AP_ArabicFountain" at (92, 214)
    And I spawn a "AP_ZenFountain" at (99, 214)
    And I spawn a "AP_ThreeTieredFountain" at (106, 214)
    And I spawn a "AP_RoundFountain" at (113, 214)
    And I spawn a "AP_HexagonalFountain" at (120, 214)
    And I spawn a "AP_SquareFountain" at (127, 214)
    And I spawn a "AP_ObeliskFountain" at (134, 214)
    Then the "AP_ArabicFountain" at (92, 214) stat "MeditationFocusStrength" is 0.28
    And the "AP_ZenFountain" at (99, 214) stat "MeditationFocusStrength" is 0.26
    And the "AP_ThreeTieredFountain" at (106, 214) stat "MeditationFocusStrength" is 0.24
    And the "AP_RoundFountain" at (113, 214) stat "MeditationFocusStrength" is 0.22
    And the "AP_HexagonalFountain" at (120, 214) stat "MeditationFocusStrength" is 0.22
    And the "AP_SquareFountain" at (127, 214) stat "MeditationFocusStrength" is 0.18
    And the "AP_ObeliskFountain" at (134, 214) stat "MeditationFocusStrength" is 0.18

  Scenario: seven fountains around an anima tree do not weaken it
    Given Nelim's Pickle Tools: I place the decor "Plant_TreeAnima" at (113, 222) fully grown
    And I spawn a "AP_ArabicFountain" at (92, 214)
    And I spawn a "AP_ZenFountain" at (99, 214)
    And I spawn a "AP_ThreeTieredFountain" at (106, 214)
    And I spawn a "AP_RoundFountain" at (113, 214)
    And I spawn a "AP_HexagonalFountain" at (120, 214)
    And I spawn a "AP_SquareFountain" at (127, 214)
    And I spawn a "AP_ObeliskFountain" at (134, 214)
    Then the "Plant_TreeAnima" at (113, 222) stat "MeditationFocusStrength" is 0.28
