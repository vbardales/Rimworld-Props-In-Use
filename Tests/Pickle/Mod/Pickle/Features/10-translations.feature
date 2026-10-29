# Meant to be played in each language pass (the language is chosen at launch with -Language, never
# switched in a scenario): the @english scenarios run in the English pass, the @french ones in the
# French pass, and the other pair is excluded by tag. The first scenario of each pair reads the
# texts the mod and its French injections give; the second reads the hedge explanation line where
# a player sees it, in the tooltip of the stat of the anima tree.
@requires:leo.propsdecor
@requires:sarg.alphapropsparks
@requires:ludeon.rimworld.royalty
@requires:nelim.pickletools.deffields
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.inspecttabs
@requires:nelim.pickletools.hoversteps
Feature: Props in Use reads in the language of the pass

  @english
  Scenario: the trough labels and the two report strings of Props in Use read in English
    Then the language is "English"
    And Nelim's Pickle Tools: def "AP_EmptyTrough" of type "ThingDef" field "label" is "empty trough"
    And Nelim's Pickle Tools: def "AP_TroughWithHay" of type "ThingDef" field "label" is "trough with hay"
    And Nelim's Pickle Tools: def "AP_TroughWithFlowersA" of type "ThingDef" field "label" is "trough with flowers"
    And Nelim's Pickle Tools: def "AP_TroughWithFlowersB" of type "ThingDef" field "label" is "trough with flowers"
    And Nelim's Pickle Tools: def "AP_TroughWithFlowersC" of type "ThingDef" field "label" is "trough with flowers"
    And Nelim's Pickle Tools: def "PIU_PlayGameConsole" of type "JobDef" field "reportString" is "playing on the game console."
    And Nelim's Pickle Tools: def "PIU_ListenHamRadio" of type "JobDef" field "reportString" is "listening to the radio."

  @french
  Scenario: the trough labels and the two report strings of Props in Use read in French
    Then the language is "French"
    And Nelim's Pickle Tools: def "AP_EmptyTrough" of type "ThingDef" field "label" is "mangeoire vide"
    And Nelim's Pickle Tools: def "AP_TroughWithHay" of type "ThingDef" field "label" is "mangeoire à foin"
    And Nelim's Pickle Tools: def "AP_TroughWithFlowersA" of type "ThingDef" field "label" is "mangeoire fleurie"
    And Nelim's Pickle Tools: def "AP_TroughWithFlowersB" of type "ThingDef" field "label" is "mangeoire fleurie"
    And Nelim's Pickle Tools: def "AP_TroughWithFlowersC" of type "ThingDef" field "label" is "mangeoire fleurie"
    And Nelim's Pickle Tools: def "PIU_PlayGameConsole" of type "JobDef" field "reportString" is "jouer à la console."
    And Nelim's Pickle Tools: def "PIU_ListenHamRadio" of type "JobDef" field "reportString" is "écouter la radio."

  @english
  Scenario: the hedge lines of the anima tree stat read in English
    Given the save "test-colony" is loaded
    And I close all dialogs
    And Nelim's Pickle Tools: I place the decor "Plant_TreeAnima" at (112, 222) fully grown
    And I spawn a "AP_Hedge_Anima" at (110, 222)
    And I spawn a "AP_Hedge_Anima" at (111, 222)
    And I spawn a "AP_Hedge_Gau" at (110, 224)
    And I spawn a "AP_Hedge_Gau" at (111, 224)
    When Nelim's Pickle Tools: I select the thing of def "Plant_TreeAnima" at (112, 222)
    And Nelim's Pickle Tools: I open the info card of the selected thing on the "Stats" tab
    And Nelim's Pickle Tools: the info card Stats tab is scrolled to the stat "MeditationFocusStrength"
    And Nelim's Pickle Tools: I hover over the tooltip containing "per nearby anima hedge"
    Then Nelim's Pickle Tools: the tooltip containing "per nearby anima hedge" is drawn
    And Nelim's Pickle Tools: the tooltip containing "per nearby gauranlen hedge" is drawn
    When Nelim's Pickle Tools: I close the info card

  @french
  Scenario: the hedge lines of the anima tree stat read in French
    Given the save "test-colony" is loaded
    And I close all dialogs
    And Nelim's Pickle Tools: I place the decor "Plant_TreeAnima" at (112, 222) fully grown
    And I spawn a "AP_Hedge_Anima" at (110, 222)
    And I spawn a "AP_Hedge_Anima" at (111, 222)
    And I spawn a "AP_Hedge_Gau" at (110, 224)
    And I spawn a "AP_Hedge_Gau" at (111, 224)
    When Nelim's Pickle Tools: I select the thing of def "Plant_TreeAnima" at (112, 222)
    And Nelim's Pickle Tools: I open the info card of the selected thing on the "Stats" tab
    And Nelim's Pickle Tools: the info card Stats tab is scrolled to the stat "MeditationFocusStrength"
    And Nelim's Pickle Tools: I hover over the tooltip containing "par haie anima à proximité"
    Then Nelim's Pickle Tools: the tooltip containing "par haie anima à proximité" is drawn
    And Nelim's Pickle Tools: the tooltip containing "par haie Gauranlen à proximité" is drawn
    When Nelim's Pickle Tools: I close the info card
