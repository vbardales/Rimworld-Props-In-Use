# What only a running game shows: Musical Instruments' joy giver finds each patched prop, hands a
# colonist the playing job, and the job holds for a few hundred ticks without an exception (the
# patch adds CompQuality and CompMusicSpot because Musical Instruments dereferences both).
# The joy giver is forced so the scenario does not depend on the game's random pick.
@functional
@timeout:60
@requires:leo.propsdecor
@requires:mlie.musicalinstruments
@requires:nelim.pickletools.colonistrace
Feature: Props in Use lets a colonist play each miniature instrument

  Background:
    Given the save "test-colony" is loaded
    And I close all dialogs

  Scenario Outline: a colonist plays the <instrument> of Miniature Props and Decor
    Given I spawn a "<instrument>" at (110, 208)
    And Nelim's Pickle Tools: the joy giver "MusicPlay" is asked what it would give "Jet"
    When Nelim's Pickle Tools: the joy giver "MusicPlay" job is forced on "Jet"
    Then "Jet" has job "MusicPlayJoy"
    When I wait 300 ticks
    Then "Jet" has job "MusicPlayJoy"
    And no errors were logged

    Examples:
      | instrument      |
      | Prop_Accordion  |
      | Prop_Guzheng    |
      | Prop_Oboe       |
      | Prop_Snare_Drum |
      | Prop_Trombone   |
      | Prop_Trumpet    |
      | Prop_Violin     |
      | Prop_Cello      |
      | Prop_Guitar     |
