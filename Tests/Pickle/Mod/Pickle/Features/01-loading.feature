@requires:nelim.pickletools.loadaudit
Feature: Props in Use loads clean in the language this pass runs

  Scenario: Props in Use loads with no error or warning of its own
    Given Nelim's Pickle Tools: the game has finished starting
    Then mod "nelim.propsinuse" is loaded
    And no errors were logged
    And no warnings from mod "nelim.propsinuse"

  Scenario: the load of Props in Use is clean, its keyed texts included
    Then Nelim's Pickle Tools: the load of the mod "nelim.propsinuse" is clean
    And Nelim's Pickle Tools: the active language recorded no load error
