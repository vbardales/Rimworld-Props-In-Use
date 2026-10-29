# The game console and the ham radio were buildings with no joy giver. Forcing the joy giver the
# patch adds proves a colonist is handed the job and keeps it; the colonist's own choice among
# recreations is not waited for.
@functional
@timeout:60
@requires:leo.propsdecor
@requires:nelim.pickletools.colonistrace
Feature: Props in Use makes the game console and the ham radio recreation

  Background:
    Given the save "test-colony" is loaded
    And I close all dialogs

  Scenario: a colonist plays on the game console of Miniature Props and Decor
    Given I spawn a "Prop_GameConsole" at (110, 208)
    And Nelim's Pickle Tools: the joy giver "PIU_PlayGameConsole" is asked what it would give "Jet"
    When Nelim's Pickle Tools: the joy giver "PIU_PlayGameConsole" job is forced on "Jet"
    Then "Jet" has job "PIU_PlayGameConsole"
    When I wait 300 ticks
    Then "Jet" has job "PIU_PlayGameConsole"
    And no errors were logged

  Scenario: a colonist listens to the ham radio of Miniature Props and Decor
    Given I spawn a "Props_Ham_Radio" at (110, 208)
    And Nelim's Pickle Tools: the joy giver "PIU_ListenHamRadio" is asked what it would give "Jet"
    When Nelim's Pickle Tools: the joy giver "PIU_ListenHamRadio" job is forced on "Jet"
    Then "Jet" has job "PIU_ListenHamRadio"
    When I wait 300 ticks
    Then "Jet" has job "PIU_ListenHamRadio"
    And no errors were logged
