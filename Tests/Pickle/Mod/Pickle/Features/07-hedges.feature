# The anima tree reads 0.28 on its own. Each hedge within 9.9 cells adds 0.01, four at most per kind,
# and the hedges no longer count as artificial buildings. Pickle's stat step accepts a difference
# of 0.01, so every expectation below sits at least 0.04 from the one it must not be: 0.28 (no
# hedge), 0.32 (four of one kind, also eight of one kind: the cap), 0.36 (four of each kind).
# The first scenario is also the control: it fails if the fixture has artificial buildings near
# the tree, which would make every other value here meaningless.
@functional
@requires:sarg.alphapropsparks
@requires:ludeon.rimworld.royalty
@requires:nelim.pickletools.stagedecor
Feature: Props in Use makes the Alpha Props hedges strengthen the anima tree

  Background:
    Given the save "test-colony" is loaded
    And I close all dialogs
    And Nelim's Pickle Tools: I place the decor "Plant_TreeAnima" at (112, 222) fully grown

  Scenario: without a hedge the anima tree keeps its own strength
    Then the "Plant_TreeAnima" at (112, 222) stat "MeditationFocusStrength" is 0.28

  Scenario: four anima hedges add four hundredths
    Given Nelim's Pickle Tools: I place the decor "AP_Hedge_Anima" owned by the colonists at (108, 222)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Anima" owned by the colonists at (109, 222)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Anima" owned by the colonists at (110, 222)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Anima" owned by the colonists at (111, 222)
    When I wait 120 ticks
    Then the "Plant_TreeAnima" at (112, 222) stat "MeditationFocusStrength" is 0.32

  Scenario: eight anima hedges count for four
    Given Nelim's Pickle Tools: I place the decor "AP_Hedge_Anima" owned by the colonists at (104, 222)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Anima" owned by the colonists at (105, 222)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Anima" owned by the colonists at (106, 222)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Anima" owned by the colonists at (107, 222)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Anima" owned by the colonists at (108, 222)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Anima" owned by the colonists at (109, 222)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Anima" owned by the colonists at (110, 222)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Anima" owned by the colonists at (111, 222)
    When I wait 120 ticks
    Then the "Plant_TreeAnima" at (112, 222) stat "MeditationFocusStrength" is 0.32

  Scenario: four gauranlen hedges add four hundredths
    Given Nelim's Pickle Tools: I place the decor "AP_Hedge_Gau" owned by the colonists at (108, 224)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Gau" owned by the colonists at (109, 224)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Gau" owned by the colonists at (110, 224)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Gau" owned by the colonists at (111, 224)
    When I wait 120 ticks
    Then the "Plant_TreeAnima" at (112, 222) stat "MeditationFocusStrength" is 0.32

  Scenario: four hedges of each kind add eight hundredths
    Given Nelim's Pickle Tools: I place the decor "AP_Hedge_Anima" owned by the colonists at (108, 222)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Anima" owned by the colonists at (109, 222)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Anima" owned by the colonists at (110, 222)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Anima" owned by the colonists at (111, 222)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Gau" owned by the colonists at (108, 224)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Gau" owned by the colonists at (109, 224)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Gau" owned by the colonists at (110, 224)
    And Nelim's Pickle Tools: I place the decor "AP_Hedge_Gau" owned by the colonists at (111, 224)
    When I wait 120 ticks
    Then the "Plant_TreeAnima" at (112, 222) stat "MeditationFocusStrength" is 0.36
