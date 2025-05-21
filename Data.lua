WoWLinksData = {
    tools = {
        {name = "Warcraft Logs", description = "Combat logging and analysis", url = "https://www.warcraftlogs.com/"},
        {name = "Bloodmallet", description = "Gear and trait comparisons", url = "https://bloodmallet.com/"},
        {name = "Raidbots", description = "Online simulation platform", url = "https://www.raidbots.com/"},
        {name = "SimulationCraft", description = "Detailed character simulation", url = "https://www.simulationcraft.org/"},
        {name = "WoWAnalyzer", description = "Performance analysis", url = "https://wowanalyzer.com/"},
        {name = "Mythic Plus Score", description = "M+ rating tracker", url = "https://raider.io/"},
        {name = "Method Dungeon Tools", description = "Mythic+ route planner", url = "https://www.curseforge.com/wow/addons/method-dungeon-tools"},
        {name = "Wago.io", description = "WeakAuras and macro sharing", url = "https://wago.io/"},
        {name = "WoWProgress", description = "Guild and raid progression", url = "https://www.wowprogress.com/"},
        {name = "Ask Mr. Robot", description = "Gearing tool", url = "https://www.askmrrobot.com/"},
        {name = "Wowhead DB", description = "Item database and tools", url = "https://www.wowhead.com/items"},
        {name = "Wowuction", description = "Auction house tracker", url = "https://www.wowuction.com/"},
    },
    
    classIcons = {
        ["WARRIOR"] = {file = "Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES", coords = {0, 0.25, 0, 0.25}},
        ["PALADIN"] = {file = "Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES", coords = {0, 0.25, 0.25, 0.5}},
        ["HUNTER"] = {file = "Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES", coords = {0, 0.25, 0.5, 0.75}},
        ["ROGUE"] = {file = "Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES", coords = {0.49609375, 0.7421875, 0, 0.25}},
        ["PRIEST"] = {file = "Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES", coords = {0.49609375, 0.7421875, 0.25, 0.5}},
        ["DEATHKNIGHT"] = {file = "Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES", coords = {0.25, 0.5, 0.5, 0.75}},
        ["SHAMAN"] = {file = "Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES", coords = {0.25, 0.49609375, 0.25, 0.5}},
        ["MAGE"] = {file = "Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES", coords = {0.25, 0.49609375, 0, 0.25}},
        ["WARLOCK"] = {file = "Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES", coords = {0.7421875, 0.98828125, 0.25, 0.5}},
        ["MONK"] = {file = "Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES", coords = {0.5, 0.73828125, 0.5, 0.75}},
        ["DRUID"] = {file = "Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES", coords = {0.7421875, 0.98828125, 0, 0.25}},
        ["DEMONHUNTER"] = {file = "Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES", coords = {0.7421875, 0.98828125, 0.5, 0.75}},
        ["EVOKER"] = {file = "Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES", coords = {0.25, 0.5, 0.75, 1}},
    },
    
    specIcons = {
        -- Death Knight
        ["Blood"] = "Interface\\Icons\\Spell_Deathknight_BloodPresence",
        ["Frost DK"] = "Interface\\Icons\\Spell_Deathknight_FrostPresence",
        ["Unholy"] = "Interface\\Icons\\Spell_Deathknight_UnholyPresence",
        -- Demon Hunter
        ["Havoc"] = "Interface\\Icons\\Ability_DemonHunter_SpecDPS",
        ["Vengeance"] = "Interface\\Icons\\Ability_DemonHunter_SpecTank",
        -- Druid
        ["Balance"] = "Interface\\Icons\\Spell_Nature_StarFall",
        ["Feral"] = "Interface\\Icons\\Ability_Druid_CatForm",
        ["Guardian"] = "Interface\\Icons\\Ability_Racial_BearForm",
        ["Restoration Druid"] = "Interface\\Icons\\Spell_Nature_HealingTouch",
        -- Evoker
        ["Devastation"] = "Interface\\Icons\\Ability_Evoker_DevastatingBlast",
        ["Preservation"] = "Interface\\Icons\\Ability_Evoker_Preservation_PrimaryCombat",
        ["Augmentation"] = "Interface\\Icons\\Ability_Evoker_Augmentation", 
        -- Hunter
        ["Beast Mastery"] = "Interface\\Icons\\Ability_Hunter_BeastTaming",
        ["Marksmanship"] = "Interface\\Icons\\Ability_Hunter_FocusedAim",
        ["Survival"] = "Interface\\Icons\\Ability_Hunter_Camouflage",
        -- Mage
        ["Arcane"] = "Interface\\Icons\\Spell_Holy_MagicalSentry",
        ["Fire"] = "Interface\\Icons\\Spell_Fire_FireBolt02",
        ["Frost Mage"] = "Interface\\Icons\\Spell_Frost_FrostBolt02",
        -- Monk
        ["Brewmaster"] = "Interface\\Icons\\Monk_Stance_OxStance",
        ["Mistweaver"] = "Interface\\Icons\\Monk_Stance_WiseSerpen",
        ["Windwalker"] = "Interface\\Icons\\Monk_Stance_WhiteTiger",
        -- Paladin
        ["Holy Paladin"] = "Interface\\Icons\\Spell_Holy_HolyBolt",
        ["Protection Paladin"] = "Interface\\Icons\\Ability_Paladin_ShieldoftheTemplar",
        ["Retribution"] = "Interface\\Icons\\Spell_Holy_AuraOfLight",
        -- Priest
        ["Discipline"] = "Interface\\Icons\\Spell_Holy_PowerWordShield",
        ["Holy Priest"] = "Interface\\Icons\\Spell_Holy_GuardianSpirit",
        ["Shadow"] = "Interface\\Icons\\Spell_Shadow_ShadowWordPain",
        -- Rogue
        ["Assassination"] = "Interface\\Icons\\Ability_Rogue_Eviscerate",
        ["Outlaw"] = "Interface\\Icons\\Ability_Rogue_PistolShot",
        ["Subtlety"] = "Interface\\Icons\\Ability_Stealth",
        -- Shaman
        ["Elemental"] = "Interface\\Icons\\Spell_Nature_Lightning",
        ["Enhancement"] = "Interface\\Icons\\Spell_Shaman_ImprovedStormstrike",
        ["Restoration Shaman"] = "Interface\\Icons\\Spell_Nature_MagicImmunity",
        -- Warlock
        ["Affliction"] = "Interface\\Icons\\Spell_Shadow_DeathCoil",
        ["Demonology"] = "Interface\\Icons\\Spell_Shadow_Metamorphosis",
        ["Destruction"] = "Interface\\Icons\\Spell_Shadow_RainOfFire",
        -- Warrior
        ["Arms"] = "Interface\\Icons\\Ability_Warrior_SavageBlow",
        ["Fury"] = "Interface\\Icons\\Ability_Warrior_InnerRage",
        ["Protection Warrior"] = "Interface\\Icons\\Ability_Warrior_DefensiveStance"
    },
    
    classes = {
        ["DEATHKNIGHT"] = {
            specs = {
                ["Blood"] = {
                    creators = {
                        {name = "Darkmech", url = "https://www.youtube.com/c/darkmech"},
                        {name = "Bicepspump", url = "https://www.twitch.tv/bicepspump"},
                        {name = "Avengtv", url = "https://www.twitch.tv/avengtv"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/death-knight/blood"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/blood-death-knight-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/blood-death-knight-guide"},
                    }
                },
                ["Frost DK"] = {
                    creators = {
                        {name = "Koltira", url = "https://www.youtube.com/c/koltira"},
                        {name = "Hazzed", url = "https://www.twitch.tv/hazzed"},
                        {name = "Trickslol", url = "https://www.youtube.com/c/trickslol"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/death-knight/frost"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/frost-death-knight-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/frost-death-knight-guide"},
                    }
                },
                ["Unholy"] = {
                    creators = {
                        {name = "Bicepspump", url = "https://www.twitch.tv/bicepspump"},
                        {name = "BikiniBottomTV", url = "https://www.youtube.com/c/bikinibottomtv"},
                        {name = "DeadlyDoze", url = "https://www.twitch.tv/deadlydoze"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/death-knight/unholy"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/unholy-death-knight-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/unholy-death-knight-guide"},
                    }
                },
            }
        },
        ["DEMONHUNTER"] = {
            specs = {
                ["Havoc"] = {
                    creators = {
                        {name = "Motoko", url = "https://www.youtube.com/c/motokodh"},
                        {name = "Raider.IO", url = "https://raider.io/havoc-demon-hunter-guide"},
                        {name = "Asmongold", url = "https://www.twitch.tv/asmongold"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/demon-hunter/havoc"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/havoc-demon-hunter-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/havoc-demon-hunter-guide"},
                    }
                },
                ["Vengeance"] = {
                    creators = {
                        {name = "Shakib", url = "https://www.youtube.com/c/shakibtv"},
                        {name = "Xelannz", url = "https://www.twitch.tv/xelannz"},
                        {name = "TankNotes", url = "https://tanknotes.com"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/demon-hunter/vengeance"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/vengeance-demon-hunter-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/vengeance-demon-hunter-guide"},
                    }
                },
            }
        },
        ["DRUID"] = {
            specs = {
                ["Balance"] = {
                    creators = {
                        {name = "Naguura", url = "https://www.twitch.tv/naguura"},
                        {name = "Balance Druid Discord", url = "https://discord.gg/dreamgrove"},
                        {name = "Gingitv", url = "https://www.twitch.tv/gingitv"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/druid/balance"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/balance-druid-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/balance-druid-guide"},
                    }
                },
                ["Feral"] = {
                    creators = {
                        {name = "Mystic", url = "https://www.youtube.com/c/mysticdruid"},
                        {name = "Psybearslat", url = "https://www.twitch.tv/psybearslat"},
                        {name = "Xanzara", url = "https://www.twitch.tv/xanzara"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/druid/feral"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/feral-druid-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/feral-druid-guide"},
                    }
                },
                ["Guardian"] = {
                    creators = {
                        {name = "Trille", url = "https://www.twitch.tv/trille"},
                        {name = "Consentient", url = "https://www.youtube.com/c/consentient"},
                        {name = "TankNotes", url = "https://tanknotes.com"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/druid/guardian"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/guardian-druid-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/guardian-druid-guide"},
                    }
                },
                ["Restoration Druid"] = {
                    creators = {
                        {name = "Growl", url = "https://www.twitch.tv/growl"},
                        {name = "Automaticjak", url = "https://www.youtube.com/c/automaticjak"},
                        {name = "YumyTV", url = "https://www.twitch.tv/yumytv"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/druid/restoration"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/restoration-druid-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/restoration-druid-guide"},
                    }
                },
            }
        },
        ["EVOKER"] = {
            specs = {
                ["Devastation"] = {
                    creators = {
                        {name = "GingeTv", url = "https://www.twitch.tv/gingetv"},
                        {name = "Nanners", url = "https://www.youtube.com/c/nannerswow"},
                        {name = "Zader", url = "https://www.twitch.tv/zader"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/evoker/devastation"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/devastation-evoker-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/devastation-evoker-guide"},
                    }
                },
                ["Preservation"] = {
                    creators = {
                        {name = "Automaticjak", url = "https://www.youtube.com/c/automaticjak"},
                        {name = "Growl", url = "https://www.twitch.tv/growl"},
                        {name = "YumyTV", url = "https://www.twitch.tv/yumytv"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/evoker/preservation"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/preservation-evoker-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/preservation-evoker-guide"},
                    }
                },
                ["Augmentation"] = {
                    creators = {
                        {name = "EvokerHub", url = "https://www.twitch.tv/evokerhub"},
                        {name = "DarthTerrex", url = "https://www.youtube.com/c/darthterrex"},
                        {name = "Nanners", url = "https://www.youtube.com/c/nannerswow"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/evoker/augmentation"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/augmentation-evoker-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/augmentation-evoker-guide"},
                    }
                },
            }
        },
        ["HUNTER"] = {
            specs = {
                ["Beast Mastery"] = {
                    creators = {
                        {name = "Azortharion", url = "https://www.youtube.com/c/azortharion"},
                        {name = "TrueShot Lodge", url = "https://discord.gg/trueshot"},
                        {name = "Mrfatboyd", url = "https://www.twitch.tv/mrfatboyd"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/hunter/beast-mastery"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/beast-mastery-hunter-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/beast-mastery-hunter-guide"},
                    }
                },
                ["Marksmanship"] = {
                    creators = {
                        {name = "Azortharion", url = "https://www.youtube.com/c/azortharion"},
                        {name = "TrueShot Lodge", url = "https://discord.gg/trueshot"},
                        {name = "Bicepspump", url = "https://www.twitch.tv/bicepspump"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/hunter/marksmanship"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/marksmanship-hunter-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/marksmanship-hunter-guide"},
                    }
                },
                ["Survival"] = {
                    creators = {
                        {name = "Azortharion", url = "https://www.youtube.com/c/azortharion"},
                        {name = "TrueShot Lodge", url = "https://discord.gg/trueshot"},
                        {name = "Deliahunter", url = "https://www.twitch.tv/deliahunter"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/hunter/survival"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/survival-hunter-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/survival-hunter-guide"},
                    }
                },
            }
        },
        ["MAGE"] = {
            specs = {
                ["Arcane"] = {
                    creators = {
                        {name = "Altered Time", url = "https://discord.gg/altered-time"},
                        {name = "Asuna", url = "https://www.twitch.tv/asuna"},
                        {name = "FromTheTop", url = "https://www.youtube.com/c/fromthetop"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/mage/arcane"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/arcane-mage-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/arcane-mage-guide"},
                    }
                },
                ["Fire"] = {
                    creators = {
                        {name = "Altered Time", url = "https://discord.gg/altered-time"},
                        {name = "Asuna", url = "https://www.twitch.tv/asuna"},
                        {name = "Silohdeath", url = "https://www.twitch.tv/silohdeath"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/mage/fire"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/fire-mage-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/fire-mage-guide"},
                    }
                },
                ["Frost Mage"] = {
                    creators = {
                        {name = "Altered Time", url = "https://discord.gg/altered-time"},
                        {name = "Asuna", url = "https://www.twitch.tv/asuna"},
                        {name = "Fromthetop", url = "https://www.youtube.com/c/fromthetop"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/mage/frost"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/frost-mage-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/frost-mage-guide"},
                    }
                },
            }
        },
        ["MONK"] = {
            specs = {
                ["Brewmaster"] = {
                    creators = {
                        {name = "Peak of Serenity", url = "https://www.peakofserenity.com/"},
                        {name = "Llarold", url = "https://www.twitch.tv/llarold"},
                        {name = "TankNotes", url = "https://tanknotes.com"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/monk/brewmaster"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/brewmaster-monk-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/brewmaster-monk-guide"},
                    }
                },
                ["Mistweaver"] = {
                    creators = {
                        {name = "Peak of Serenity", url = "https://www.peakofserenity.com/"},
                        {name = "YumyTV", url = "https://www.twitch.tv/yumytv"},
                        {name = "Automaticjak", url = "https://www.youtube.com/c/automaticjak"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/monk/mistweaver"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/mistweaver-monk-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/mistweaver-monk-guide"},
                    }
                },
                ["Windwalker"] = {
                    creators = {
                        {name = "Babylonius", url = "https://www.peakofserenity.com/windwalker/"},
                        {name = "Peak of Serenity", url = "https://www.peakofserenity.com/"},
                        {name = "Andybrew", url = "https://www.youtube.com/c/andybrew"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/monk/windwalker"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/windwalker-monk-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/windwalker-monk-guide"},
                    }
                },
            }
        },
        ["PALADIN"] = {
            specs = {
                ["Holy Paladin"] = {
                    creators = {
                        {name = "Borngood", url = "https://www.twitch.tv/borngood"},
                        {name = "Ellesmere", url = "https://www.twitch.tv/ellesmere_gaming"},
                        {name = "Automaticjak", url = "https://www.youtube.com/c/automaticjak"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/paladin/holy"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/holy-paladin-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/holy-paladin-guide"},
                    }
                },
                ["Protection Paladin"] = {
                    creators = {
                        {name = "Lysander", url = "https://www.twitch.tv/lysandertv"},
                        {name = "TankNotes", url = "https://tanknotes.com"},
                        {name = "AngrySalad", url = "https://www.youtube.com/c/angrysalad"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/paladin/protection"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/protection-paladin-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/protection-paladin-guide"},
                    }
                },
                ["Retribution"] = {
                    creators = {
                        {name = "Savix", url = "https://www.youtube.com/c/savix"},
                        {name = "HammerOfWrath", url = "https://discord.gg/hammerofwrath"},
                        {name = "Vanguards", url = "https://www.youtube.com/c/vanguardstv"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/paladin/retribution"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/retribution-paladin-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/retribution-paladin-guide"},
                    }
                },
            }
        },
        ["PRIEST"] = {
            specs = {
                ["Discipline"] = {
                    creators = {
                        {name = "Automaticjak", url = "https://www.youtube.com/c/automaticjak"},
                        {name = "Moadmoad", url = "https://www.twitch.tv/moadmoad"},
                        {name = "YumyTV", url = "https://www.twitch.tv/yumytv"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/priest/discipline"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/discipline-priest-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/discipline-priest-guide"},
                    }
                },
                ["Holy Priest"] = {
                    creators = {
                        {name = "Automaticjak", url = "https://www.youtube.com/c/automaticjak"},
                        {name = "YumyTV", url = "https://www.twitch.tv/yumytv"},
                        {name = "Moadmoad", url = "https://www.twitch.tv/moadmoad"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/priest/holy"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/holy-priest-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/holy-priest-guide"},
                    }
                },
                ["Shadow"] = {
                    creators = {
                        {name = "Publik", url = "https://www.youtube.com/c/publikwow"},
                        {name = "Ellipsis", url = "https://www.twitch.tv/ellipsis"},
                        {name = "TipsOut", url = "https://www.youtube.com/c/tipsout"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/priest/shadow"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/shadow-priest-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/shadow-priest-guide"},
                    }
                },
            }
        },
        ["ROGUE"] = {
            specs = {
                ["Assassination"] = {
                    creators = {
                        {name = "Ravenholdt", url = "https://discord.gg/ravenholdt"},
                        {name = "Palarogue", url = "https://www.youtube.com/c/palarogue"},
                        {name = "DrJay", url = "https://www.twitch.tv/drjaytv"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/rogue/assassination"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/assassination-rogue-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/assassination-rogue-guide"},
                    }
                },
                ["Outlaw"] = {
                    creators = {
                        {name = "Ravenholdt", url = "https://discord.gg/ravenholdt"},
                        {name = "Palarogue", url = "https://www.youtube.com/c/palarogue"},
                        {name = "Nahj", url = "https://www.twitch.tv/nahj"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/rogue/outlaw"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/outlaw-rogue-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/outlaw-rogue-guide"},
                    }
                },
                ["Subtlety"] = {
                    creators = {
                        {name = "Ravenholdt", url = "https://discord.gg/ravenholdt"},
                        {name = "Palarogue", url = "https://www.youtube.com/c/palarogue"},
                        {name = "Nahj", url = "https://www.twitch.tv/nahj"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/rogue/subtlety"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/subtlety-rogue-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/subtlety-rogue-guide"},
                    }
                },
            }
        },
        ["SHAMAN"] = {
            specs = {
                ["Elemental"] = {
                    creators = {
                        {name = "Stormearthandlava", url = "https://www.stormearthandlava.com/"},
                        {name = "WorrGaming", url = "https://www.youtube.com/c/worrgaming"},
                        {name = "NaesiumGaming", url = "https://www.twitch.tv/naesiumgaming"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/shaman/elemental"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/elemental-shaman-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/elemental-shaman-guide"},
                    }
                },
                ["Enhancement"] = {
                    creators = {
                        {name = "Tiqqle", url = "https://www.twitch.tv/tiqqle"},
                        {name = "WorrGaming", url = "https://www.youtube.com/c/worrgaming"},
                        {name = "NaesiumGaming", url = "https://www.twitch.tv/naesiumgaming"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/shaman/enhancement"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/enhancement-shaman-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/enhancement-shaman-guide"},
                    }
                },
                ["Restoration Shaman"] = {
                    creators = {
                        {name = "YumyTV", url = "https://www.twitch.tv/yumytv"},
                        {name = "Automaticjak", url = "https://www.youtube.com/c/automaticjak"},
                        {name = "Growl", url = "https://www.twitch.tv/growl"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/shaman/restoration"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/restoration-shaman-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/restoration-shaman-guide"},
                    }
                },
            }
        },
        ["WARLOCK"] = {
            specs = {
                ["Affliction"] = {
                    creators = {
                        {name = "Kalamazi", url = "https://www.youtube.com/c/kalamazi"},
                        {name = "Council of the Black Harvest", url = "https://discord.gg/blackharvest"},
                        {name = "MoTsuTV", url = "https://www.twitch.tv/motsutv"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/warlock/affliction"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/affliction-warlock-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/affliction-warlock-guide"},
                    }
                },
                ["Demonology"] = {
                    creators = {
                        {name = "Kalamazi", url = "https://www.youtube.com/c/kalamazi"},
                        {name = "Council of the Black Harvest", url = "https://discord.gg/blackharvest"},
                        {name = "MoTsuTV", url = "https://www.twitch.tv/motsutv"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/warlock/demonology"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/demonology-warlock-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/demonology-warlock-guide"},
                    }
                },
                ["Destruction"] = {
                    creators = {
                        {name = "Kalamazi", url = "https://www.youtube.com/c/kalamazi"},
                        {name = "Council of the Black Harvest", url = "https://discord.gg/blackharvest"},
                        {name = "MoTsuTV", url = "https://www.twitch.tv/motsutv"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/warlock/destruction"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/destruction-warlock-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/destruction-warlock-guide"},
                    }
                },
            }
        },
        ["WARRIOR"] = {
            specs = {
                ["Arms"] = {
                    creators = {
                        {name = "Bajheera", url = "https://www.youtube.com/bajheera"},
                        {name = "Swifty", url = "https://www.twitch.tv/swifty"},
                        {name = "Magnusz", url = "https://www.youtube.com/c/magnuszow"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/warrior/arms"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/arms-warrior-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/arms-warrior-guide"},
                    }
                },
                ["Fury"] = {
                    creators = {
                        {name = "Bajheera", url = "https://www.youtube.com/bajheera"},
                        {name = "Maximum", url = "https://www.twitch.tv/maximum"},
                        {name = "Asmongold", url = "https://www.twitch.tv/asmongold"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/warrior/fury"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/fury-warrior-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/fury-warrior-guide"},
                    }
                },
                ["Protection Warrior"] = {
                    creators = {
                        {name = "TankNotes", url = "https://tanknotes.com"},
                        {name = "Tryh", url = "https://www.twitch.tv/tryh"},
                        {name = "DorkiTV", url = "https://www.twitch.tv/dorkitv"},
                    },
                    guides = {
                        {name = "Wowhead", url = "https://www.wowhead.com/guide/classes/warrior/protection"},
                        {name = "Icy Veins", url = "https://www.icy-veins.com/wow/protection-warrior-guide"},
                        {name = "Maxroll", url = "https://maxroll.gg/wow/guides/protection-warrior-guide"},
                    }
                },
            }
        },
    }
}