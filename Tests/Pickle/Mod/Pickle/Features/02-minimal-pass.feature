# Minimal pass only (no source mod staged). The offline suite shows the guards with a simulator;
# this is the real loader refusing to add anything when the sources are absent.
@minimal
Feature: Props in Use stays dormant without its source mods

  Scenario: none of the six source mods is part of this pass
    Then mod "leo.propsdecor" is not loaded
    And mod "sarg.alphapropsparks" is not loaded
    And mod "mlie.musicalinstruments" is not loaded
    And mod "nelim.repossessedfurniture" is not loaded

  Scenario: Props in Use alone adds no def and logs nothing of its own
    Then mod "nelim.propsinuse" is loaded
    And no def "PIU_PlayGameConsole" exists
    And no def "PIU_ListenHamRadio" exists
    And no def "AP_Hedge_Anima" exists
    And no def "SZ_ZhuangShiShuJia" exists
    And no errors were logged
    And no warnings from mod "nelim.propsinuse"
