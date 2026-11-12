# Meant to be played in each language pass (the language is chosen at launch with -Language, never
# switched in a scenario): the @english scenarios run in the English pass, the @french ones in the
# French pass, and the other pair is excluded by tag. The first scenario of each pair reads the
# texts the mod and its French injections give.
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
