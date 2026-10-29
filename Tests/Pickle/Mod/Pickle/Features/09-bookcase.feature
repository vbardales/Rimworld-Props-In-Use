# The offline suite checks the def (class, ten-book capacity, tabs). Here the real game builds the
# bookcase, opens its tabs without an exception and keeps it across a save and a reload.
# The ten-book limit uses the StageDecor storage steps (compiled by NPT, not played yet).
@functional
@requires:nelim.repossessedfurniture
@requires:nelim.pickletools.inspecttabs
@requires:nelim.pickletools.stagedecor
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

  Scenario: the Chinese bookcase holds ten books and refuses an eleventh
    Given I spawn a "SZ_ZhuangShiShuJia" at (112, 216)
    And Nelim's Pickle Tools: I fill the storage building "SZ_ZhuangShiShuJia" at (112, 216) with 10 things "Novel"
    Then Nelim's Pickle Tools: the storage building "SZ_ZhuangShiShuJia" at (112, 216) holds 10 things
    And Nelim's Pickle Tools: the storage building "SZ_ZhuangShiShuJia" at (112, 216) refuses another "Novel"
    And no errors were logged

  Scenario: the Chinese bookcase refuses an item that is not a book
    Given I spawn a "SZ_ZhuangShiShuJia" at (112, 216)
    Then Nelim's Pickle Tools: the storage building "SZ_ZhuangShiShuJia" at (112, 216) refuses another "WoodLog"
    And no errors were logged
