# The offline suite checks the def (class, ten-book capacity, tabs). Here the real game builds the
# bookcase, opens its tabs without an exception and keeps it across a save and a reload.
# The ten-book limit itself is not here: no step counts what a storage building holds (see the
# README of this suite).
@functional
@requires:nelim.repossessedfurniture
@requires:nelim.pickletools.inspecttabs
Feature: Props in Use makes the Chinese bookcase hold books

  Background:
    Given the save "test-colony" is loaded
    And I close all dialogs

  Scenario: the Chinese bookcase opens its Contents and Storage tabs
    Given I spawn a "SZ_ZhuangShiShuJia" at (112, 216)
    When Nelim's Pickle Tools: I select the thing of def "SZ_ZhuangShiShuJia" at (112, 216)
    And I open the "ITab_ContentsBooks" inspect tab
    Then the "ITab_ContentsBooks" inspect tab is open
    When I open the "ITab_Storage" inspect tab
    Then the "ITab_Storage" inspect tab is open
    And no errors were logged

  Scenario: the Chinese bookcase survives a save and a reload
    Given I spawn a "SZ_ZhuangShiShuJia" at (112, 216)
    When I save and reload
    Then a "SZ_ZhuangShiShuJia" is at (112, 216)
    And no errors were logged
