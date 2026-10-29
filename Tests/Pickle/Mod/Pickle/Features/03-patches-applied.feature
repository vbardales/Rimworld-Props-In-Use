# Pass with the source mods. The offline suite applies the patches with a simulator; here the real
# loader must have applied each one, after the source it patches, so Pickle's patch attribution
# names Props in Use on every def the mod touches.
@requires:leo.propsdecor
@requires:sarg.alphapropsparks
@requires:mlie.musicalinstruments
@requires:nelim.repossessedfurniture
@requires:ludeon.rimworld.royalty
Feature: Props in Use patched every source def in the running game

  Scenario: the nine miniature instruments are patched
    Then def "Prop_Accordion" was patched by mod "Props in Use"
    And def "Prop_Guzheng" was patched by mod "Props in Use"
    And def "Prop_Oboe" was patched by mod "Props in Use"
    And def "Prop_Snare_Drum" was patched by mod "Props in Use"
    And def "Prop_Trombone" was patched by mod "Props in Use"
    And def "Prop_Trumpet" was patched by mod "Props in Use"
    And def "Prop_Violin" was patched by mod "Props in Use"
    And def "Prop_Cello" was patched by mod "Props in Use"
    And def "Prop_Guitar" was patched by mod "Props in Use"

  Scenario: the game console, the ham radio and their jobs are patched in
    Then def "Prop_GameConsole" was patched by mod "Props in Use"
    And def "Props_Ham_Radio" was patched by mod "Props in Use"
    And def "PIU_PlayGameConsole" of type "JobDef" exists
    And def "PIU_PlayGameConsole" of type "JoyGiverDef" exists
    And def "PIU_ListenHamRadio" of type "JobDef" exists
    And def "PIU_ListenHamRadio" of type "JoyGiverDef" exists

  Scenario: the seven fountains are patched
    Then def "AP_RoundFountain" was patched by mod "Props in Use"
    And def "AP_SquareFountain" was patched by mod "Props in Use"
    And def "AP_ObeliskFountain" was patched by mod "Props in Use"
    And def "AP_ThreeTieredFountain" was patched by mod "Props in Use"
    And def "AP_HexagonalFountain" was patched by mod "Props in Use"
    And def "AP_ArabicFountain" was patched by mod "Props in Use"
    And def "AP_ZenFountain" was patched by mod "Props in Use"

  Scenario: the two hedges and the four natural foci they feed are patched
    Then def "AP_Hedge_Anima" was patched by mod "Props in Use"
    And def "AP_Hedge_Gau" was patched by mod "Props in Use"
    And def "Plant_TreeAnima" was patched by mod "Props in Use"
    And def "AnimusStone" was patched by mod "Props in Use"
    And def "NatureShrine_Small" was patched by mod "Props in Use"
    And def "NatureShrine_Large" was patched by mod "Props in Use"

  Scenario: the five troughs are patched
    Then def "AP_EmptyTrough" was patched by mod "Props in Use"
    And def "AP_TroughWithHay" was patched by mod "Props in Use"
    And def "AP_TroughWithFlowersA" was patched by mod "Props in Use"
    And def "AP_TroughWithFlowersB" was patched by mod "Props in Use"
    And def "AP_TroughWithFlowersC" was patched by mod "Props in Use"

  Scenario: the Chinese bookcase is patched
    Then def "SZ_ZhuangShiShuJia" was patched by mod "Props in Use"
