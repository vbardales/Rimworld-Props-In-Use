# What the XML cannot show: a colonist really builds each trough from the 25 wood the patch asks
# for (the class that charged silver was replaced), an animal really eats the hay stored in one,
# and the changed class survives a save and a reload. That hay does not rot in the rain is not
# here: no step reads the hit points of an item (see the README of this suite).
@functional
@timeout:100
@requires:sarg.alphapropsparks
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.coatsteps
Feature: Props in Use turns the Alpha Props troughs into animal feeders

  Background:
    Given the save "test-colony" is loaded
    And I close all dialogs

  Scenario Outline: a colonist builds the <trough> from wood
    Given Nelim's Pickle Tools: 25 of the item "WoodLog" are spawned at (112, 212)
    And I set "Jet" priority "Construction" to 1
    And "Jet" skill "Construction" is set to level 8
    When I use the build designator for "<trough>" at (112, 210)
    And I wait for the "<trough>" at (112, 210) to be built
    Then a "<trough>" is at (112, 210)
    And no errors were logged

    Examples:
      | trough                |
      | AP_EmptyTrough        |
      | AP_TroughWithHay      |
      | AP_TroughWithFlowersA |
      | AP_TroughWithFlowersB |
      | AP_TroughWithFlowersC |

  Scenario: a hungry cow eats the hay stored in a trough
    Given I spawn a "AP_EmptyTrough" at (112, 216)
    And Nelim's Pickle Tools: 1 of the item "Hay" are spawned at (112, 216)
    And Nelim's Pickle Tools: 1 adult animals of kind "Cow" are spawned around (104, 216)
    And Nelim's Pickle Tools: the animals of kind "Cow" have food at 10 percent
    When Nelim's Pickle Tools: the animal "coat-1" is forced into the job "Ingest" on the item "Hay" at (112, 216)
    And I wait 1000 ticks
    And I wait 1000 ticks
    Then no "Hay" exists
    And no errors were logged

  Scenario: hay stored in a trough survives a save and a reload
    Given I spawn a "AP_EmptyTrough" at (112, 216)
    And Nelim's Pickle Tools: 5 of the item "Hay" are spawned at (112, 216)
    When I save and reload
    Then a "AP_EmptyTrough" is at (112, 216)
    And 5 "Hay" exist
