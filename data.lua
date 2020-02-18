StageAPI.LogMinor("Loading Reimplementation Data")

do -- Base Game Doors, Door Spawns

-- Base Game Custom State Doors
StageAPI.BaseDoorOpenState = {
    StartAnim = "Open",
    Anim = "Opened",
    StartSound = SoundEffect.SOUND_DOOR_HEAVY_OPEN,
    Triggers = {
        Unclear = "Closed"
    },
    Passable = true
}

StageAPI.BaseDoorClosedState = {
    StartAnim = "Close",
    Anim = "Closed",
    StartSound = SoundEffect.SOUND_DOOR_HEAVY_CLOSE,
    Triggers = {
        Clear = "Opened",
        Bomb = "BrokenOpen"
    }
}

StageAPI.BaseDoorBrokenOpenState = {
    StartAnim = "Break",
    Anim = "BrokenOpen",
    Passable = true,
    NoMemory = true
}

StageAPI.BaseDoorStates = {
    Default = {
        Default = "Opened",
        Closed = StageAPI.BaseDoorClosedState,
        Opened = StageAPI.BaseDoorOpenState,
        BrokenOpen = StageAPI.BaseDoorBrokenOpenState
    },
    Vault = {
        Default = "TwoChains",
        TwoChains = {
            Anim = "Closed",
            OverlayAnim = "TwoChains",
            Triggers = {
                GoldKey = {
                    State = "AwaitChain",
                    OverlayAnim = "GoldenKeyOpenChain1"
                },
                Key = {
                    State = "AwaitChain",
                    OverlayAnim = "KeyOpenChain1"
                }
            }
        },
        AwaitChain = {
            Anim = "Closed",
            OverlayAnim = "OneChain",
            Triggers = {
                FinishOverlayTrigger = "OneChain"
            },
            RememberAs = "OneChain"
        },
        OneChain = {
            Anim = "Closed",
            OverlayAnim = "OneChain",
            Triggers = {
                GoldKey = {
                    State = "Opened",
                    OverlayAnim = "GoldenKeyOpenChain2"
                },
                Key = {
                    State = "Opened",
                    OverlayAnim = "KeyOpenChain2"
                }
            }
        },
        Closed = StageAPI.BaseDoorClosedState,
        Opened = StageAPI.BaseDoorOpenState,
        BrokenOpen = StageAPI.BaseDoorBrokenOpenState
    },
    Bedroom = {
        Default = "TwoBombs",
        TwoBombs = {
            Anim = "Closed",
            OverlayAnim = "Idle",
            Triggers = {
                Bomb = {
                    State = "OneBomb",
                    Particle = {
                        Variant = EffectVariant.WOOD_PARTICLE,
                    }
                }
            }
        },
        OneBomb = {
            Anim = "Closed",
            OverlayAnim = "Damaged",
            Triggers = {
                Bomb = {
                    State = "Opened",
                    Particle = {
                        Variant = EffectVariant.WOOD_PARTICLE,
                    }
                }
            }
        },
        Closed = StageAPI.BaseDoorClosedState,
        Opened = StageAPI.BaseDoorOpenState,
        BrokenOpen = StageAPI.BaseDoorBrokenOpenState
    },
    Key = {
        Default = "Locked",
        Locked = {
            Anim = "KeyClosed",
            Triggers = {
                GoldKey = {
                    State = "Opened",
                    Anim = "GoldenKeyOpen"
                },
                Key = {
                    State = "Opened",
                    Anim = "KeyOpen"
                }
            }
        },
        Closed = StageAPI.BaseDoorClosedState,
        Opened = StageAPI.BaseDoorOpenState,
        BrokenOpen = StageAPI.BaseDoorBrokenOpenState
    },
    Arcade = {
        Default = "Locked",
        Locked = {
            Anim = "KeyClosed",
            Triggers = {
                Coin = {
                    State = "Opened",
                    Anim = "KeyOpen"
                }
            }
        },
        Closed = StageAPI.BaseDoorClosedState,
        Opened = StageAPI.BaseDoorOpenState,
        BrokenOpen = StageAPI.BaseDoorBrokenOpenState
    },
    Secret = {
        Default = "Hidden",
        Hidden = {
            Anim = "Hidden",
            Triggers = {
                Bomb = {
                    State = "Opened",
                    Anim = "Opened",
                    Jingle = Music.MUSIC_JINGLE_SECRETROOM_FIND,
                    Particles = {
                        {Variant = EffectVariant.ROCK_PARTICLE},
                        {Variant = EffectVariant.DUST_CLOUD, Timeout = 40, LifeSpan = 40, Rotation = -3, Count = 2, Velocity = 2}
                    }
                }
            }
        },
        Closed = {
            Anim = "Close",
            StartAnim = "Close",
            Triggers = {
                Clear = "Opened"
            }
        },
        Opened = {
            Anim = "Opened",
            StartAnim = "Open",
            Triggers = {
                Unclear = "Closed"
            },
            Passable = true
        }
    }
}

StageAPI.BaseDoors = {
    Default = StageAPI.CustomStateDoor("DefaultDoor", nil, StageAPI.BaseDoorStates.Default),
    Shop = StageAPI.CustomStateDoor("ShopDoor", nil, StageAPI.BaseDoorStates.Key),
    Treasure = StageAPI.CustomStateDoor("TreasureDoor", "gfx/grid/door_02_treasureroomdoor.anm2", StageAPI.BaseDoorStates.Key),
    Secret = StageAPI.CustomStateDoor("SecretDoor", "gfx/grid/door_08_holeinwall.anm2", StageAPI.BaseDoorStates.Secret, nil, nil, StageAPI.SecretDoorOffsetsByDirection),
    Arcade = StageAPI.CustomStateDoor("ArcadeDoor", "gfx/grid/door_05_arcaderoomdoor.anm2", StageAPI.BaseDoorStates.Arcade),
    Bedroom = StageAPI.CustomStateDoor("BedroomDoor", nil, StageAPI.BaseDoorStates.Bedroom, nil, "gfx/grid/door_18_crackeddoor.anm2"),
    Vault = StageAPI.CustomStateDoor("VaultDoor", nil, StageAPI.BaseDoorStates.Vault, nil, "gfx/grid/door_16_doublelock.anm2")
}

-- these two are redundant but being kept for now since they are used in the old door system
StageAPI.DefaultDoorSpawn = {
    RequireCurrent = {RoomType.ROOM_DEFAULT, RoomType.ROOM_MINIBOSS, RoomType.ROOM_SACRIFICE, RoomType.ROOM_SHOP, RoomType.ROOM_LIBRARY, RoomType.ROOM_BARREN, RoomType.ROOM_ISAACS, RoomType.ROOM_DICE, RoomType.ROOM_CHEST},
    RequireTarget = {RoomType.ROOM_DEFAULT, RoomType.ROOM_MINIBOSS, RoomType.ROOM_SACRIFICE, RoomType.ROOM_SHOP, RoomType.ROOM_LIBRARY, RoomType.ROOM_BARREN, RoomType.ROOM_ISAACS, RoomType.ROOM_DICE, RoomType.ROOM_CHEST}
}

StageAPI.SecretDoorSpawn = {
    RequireTarget = {RoomType.ROOM_SECRET, RoomType.ROOM_SUPERSECRET},
    NotCurrent = {RoomType.ROOM_SECRET, RoomType.ROOM_SUPERSECRET}
}

StageAPI.DefaultDoorEntrances = {RoomType.ROOM_DEFAULT, RoomType.ROOM_MINIBOSS, RoomType.ROOM_SACRIFICE}
StageAPI.BaseDoorSpawns = {
    Default = {
        Sprite = "Default",
        RequireCurrent = {RoomType.ROOM_DEFAULT},
        RequireTarget = StageAPI.DefaultDoorEntrances
    },
    SpecialInterior = { -- same as default door, but cannot be blown up
        Sprite = "Default",
        NotCurrent = {RoomType.ROOM_DEFAULT, RoomType.ROOM_CURSE},
        RequireTarget = StageAPI.DefaultDoorEntrances
    },
    SurpriseMiniboss = {
        Sprite = "Default",
        IsSurpriseMiniboss = true
    },
    Miniboss = {
        Sprite = "Default",
        RequireCurrent = {RoomType.ROOM_MINIBOSS}
    },
    Secret = {
        Sprite = "Secret",
        RequireTarget = {RoomType.ROOM_SECRET, RoomType.ROOM_SUPERSECRET}
    },
    Lock = {
        Sprite = "Default",
        RequireCurrent = {RoomType.ROOM_DEFAULT},
        RequireTarget = {RoomType.ROOM_SHOP, RoomType.ROOM_LIBRARY}
    },
    Treasure = {
        Sprite = "Treasure",
        RequireCurrent = {RoomType.ROOM_DEFAULT},
        RequireTarget = {RoomType.ROOM_TREASURE}
    },
    Boss = {
        Sprite = "Boss",
        RequireCurrent = {RoomType.ROOM_DEFAULT},
        RequireTarget = {RoomType.ROOM_BOSS}
    },
    Ambush = {
        Sprite = "Ambush",
        RequireCurrent = {RoomType.ROOM_DEFAULT},
        RequireTarget = {RoomType.ROOM_CHALLENGE},
        IsBossAmbush = false
    },
    BossAmbush = {
        Sprite = "BossAmbush",
        RequireCurrent = {RoomType.ROOM_DEFAULT},
        RequireTarget = {RoomType.ROOM_CHALLENGE},
        IsBossAmbush = true
    },
    Boarded = {
        Sprite = "Boarded",
        RequireCurrent = {RoomType.ROOM_DEFAULT},
        RequireTarget = {RoomType.ROOM_BARREN, RoomType.ROOM_ISAACS}
    },
    DoubleLock = {
        Sprite = "DoubleLock",
        RequireCurrent = {RoomType.ROOM_DEFAULT},
        RequireTarget = {RoomType.ROOM_CHEST, RoomType.ROOM_DICE}
    },
    CurseInterior = {
        Sprite = "Default",
        RequireCurrent = {RoomType.ROOM_CURSE},
        RequireTarget = StageAPI.DefaultDoorEntrances
    },
    Curse = {
        Sprite = "Curse",
        RequireCurrent = {RoomType.ROOM_DEFAULT},
        RequireTarget = {RoomType.ROOM_CURSE}
    },
    Devil = {
        Sprite = "Devil",
        RequireTarget = {RoomType.ROOM_DEVIL}
    },
    Angel = {
        Sprite = "Angel",
        RequireTarget = {RoomType.ROOM_ANGEL}
    },
    PayToPlay = {
        Sprite = "PayToPlay",
        IsPayToPlay = true
    }
}
StageAPI.BaseDoorSpawnList = {StageAPI.BaseDoorSpawns.PayToPlay, StageAPI.BaseDoorSpawns.Devil, StageAPI.BaseDoorSpawns.Angel, StageAPI.BaseDoorSpawns.CurseInterior, StageAPI.BaseDoorSpawns.Curse, StageAPI.BaseDoorSpawns.SpecialInterior} -- in priority order

for k, v in pairs(StageAPI.BaseDoorSpawns) do
    if not StageAPI.IsIn(StageAPI.BaseDoorSpawnList, v) and k ~= "Default" then
        StageAPI.BaseDoorSpawnList[#StageAPI.BaseDoorSpawnList + 1] = v
    end
end

StageAPI.BaseDoorSpawnList[#StageAPI.BaseDoorSpawnList + 1] = StageAPI.BaseDoorSpawns.Default

end

do -- Reimplementation of most base game GridGfx, Backdrops, RoomGfx

-- Base Game Backdrops
local function autoBackdrop(name, wallVariants, extraFloors, extraWalls, lfloors, nfloors)
    lfloors = lfloors or 1
    nfloors = nfloors or 1

    local backdrop = {WallVariants = {}, Floors = {}}

    for var, count in ipairs(wallVariants) do
        backdrop.WallVariants[var] = {Corners = {}}

        for i = 1, count do
            backdrop.WallVariants[var][#backdrop.WallVariants[var] + 1] = "stageapi/floors/" .. name .. "/" .. name .. tostring(var) .. "_" .. tostring(i) .. ".png"
            backdrop.Floors[#backdrop.Floors + 1] = "stageapi/floors/" .. name .. "/" .. name .. tostring(var) .. "_" .. tostring(i) .. ".png"
        end

        backdrop.WallVariants[var].Corners[#backdrop.WallVariants[var].Corners + 1] = "stageapi/floors/" .. name .. "/" .. name .. tostring(var) .. "_corner.png"
    end

    if extraFloors then
        for i = 1, extraFloors do
            backdrop.Floors[#backdrop.Floors + 1] = "stageapi/floors/" .. name .. "/" .. name .. "extrafloor_" .. tostring(i) .. ".png"
        end
    end

    if extraWalls then
        for var, count in ipairs(extraWalls) do
            if not backdrop.WallVariants[var] then
                backdrop.WallVariants[var] = {}
            end

            if count > 0 then
                for i = 1, count do
                    backdrop.WallVariants[var][#backdrop.WallVariants[var] + 1] = "stageapi/floors/" .. name .. "/" .. name .. tostring(var) .. "extrawall_" .. tostring(i) .. ".png"
                end
            end
        end
    end

    if lfloors > 0 then
        backdrop.LFloors = {}
        for i = 1, lfloors do
            if lfloors == 1 then
                backdrop.LFloors[#backdrop.LFloors + 1] = "stageapi/floors/" .. name .. "/" .. name .. "_lfloor"
            else
                backdrop.LFloors[#backdrop.LFloors + 1] = "stageapi/floors/" .. name .. "/" .. name .. "_lfloor" .. tostring(i)
            end
        end
    end

    if nfloors > 0 then
        backdrop.NFloors = {}
        for i = 1, nfloors do
            if nfloors == 1 then
                backdrop.NFloors[#backdrop.NFloors + 1] = "stageapi/floors/" .. name .. "/" .. name .. "_nfloor"
            else
                backdrop.NFloors[#backdrop.NFloors + 1] = "stageapi/floors/" .. name .. "/" .. name .. "_nfloor" .. tostring(i)
            end
        end
    end

    return backdrop
end

StageAPI.BaseBackdrops = {
    Basement = autoBackdrop("basement", {3}, 2),
    Cellar = autoBackdrop("cellar", {2, 2}, 2),
    BurningBasement = autoBackdrop("burningbasement", {2, 2}, 2),
    Caves = autoBackdrop("caves", {3, 3}),
    Catacombs = autoBackdrop("catacombs", {2, 1}, 3),
    FloodedCaves = autoBackdrop("floodedCaves", {3, 3}),
    Depths = autoBackdrop("depths", {3}, 3, nil, nil, 2),
    Necropolis = autoBackdrop("necropolis", {1}, nil, nil, nil, 2),
    DankDepths = autoBackdrop("dankdepths", {5}, nil, nil, nil, 2),
    Womb = autoBackdrop("womb", {1}, 5),
    Utero = autoBackdrop("utero", {4}),
    ScarredWomb = autoBackdrop("scarredwomb", {3, 1}, nil, {0, 2}, nil, 2),
    BlueWomb = autoBackdrop("bluewomb", {3}, 3, nil, 0, 0),
    Sheol = autoBackdrop("sheol", {1}),
    Cathedral = {
        FloorVariants = {{"stageapi/floors/cathedral/cathedralfloor_1.png"},{"stageapi/floors/cathedral/cathedralfloor_2.png"},{"stageapi/floors/cathedral/cathedralfloor_3.png"}},
        Walls = {"stageapi/floors/cathedral/cathedral1_1.png","stageapi/floors/cathedral/cathedral1_2.png","stageapi/floors/cathedral/cathedral1_3.png","stageapi/floors/cathedral/cathedral1_4.png"},
        Corners = {"stageapi/floors/cathedral/cathedral1_corner.png"},
        LFloors = {"stageapi/floors/cathedral/cathedral_lfloor.png"},
        NFloors = {"stageapi/floors/cathedral/cathedral_nfloor.png"},
        FloorAnm2 = "stageapi/floors/cathedral/FloorBackdrop.anm2",
        PreFloorSheetFunc = function(sprite)
            sprite:ReplaceSpritesheet(20, "stageapi/floors/cathedral/cathedral_bigfloor.png")
        end
    },
    -- Dark room not included yet due to replication difficulty
    Chest = autoBackdrop("chest", {4}),

    -- Special Rooms
    Shop = autoBackdrop("shop", {4}, nil, nil, 0),
    Library = autoBackdrop("library", {1}, nil, nil, 0),
    Secret = autoBackdrop("secret", {2}, 1, nil, 0),
    Barren = autoBackdrop("barren", {2}, 4, nil, 0, 0),
    Isaacs = autoBackdrop("isaacs", {2}, 4, nil, 0, 0),
    Arcade = autoBackdrop("arcade", {4}, 2, nil, 0, 0),
    Dice = autoBackdrop("dice", {4}, 2, nil, 0),
    BlueSecret = autoBackdrop("bluesecret", {2}, 1, nil, 0, 0)
}

-- Base Game GridGfx
StageAPI.BaseGridGfx = {}

StageAPI.BaseGridGfx.Basement = StageAPI.GridGfx()
StageAPI.BaseGridGfx.Basement:SetRocks("gfx/grid/rocks_basement.png")
StageAPI.BaseGridGfx.Basement:SetDecorations("gfx/grid/props_01_basement.png", "gfx/grid/props_01_basement.anm2", 43)
StageAPI.BaseGridGfx.Basement:SetDoorSprites{
    Default = {
        [RoomType.ROOM_DEFAULT] = "gfx/grid/door_01_normaldoor.png",
    },
    Secret = "gfx/grid/door_08_holeinwall.png"
}
StageAPI.BaseGridGfx.Basement:SetDoorSpawns(StageAPI.BaseDoorSpawnList)

StageAPI.BaseGridGfx.Cellar = StageAPI.GridGfx()
StageAPI.BaseGridGfx.Cellar:SetRocks("gfx/grid/rocks_cellar.png")
StageAPI.BaseGridGfx.Cellar:SetDecorations("gfx/grid/props_01_basement.png", "gfx/grid/props_01_basement.anm2", 43)
StageAPI.BaseGridGfx.Cellar:SetDoorSprites{
    Default = {
        [RoomType.ROOM_DEFAULT] = "gfx/grid/door_12_cellardoor.png",
    },
    Secret = "gfx/grid/door_08_holeinwall.png"
}
StageAPI.BaseGridGfx.Cellar:SetDoorSpawns(StageAPI.BaseDoorSpawnList)

StageAPI.BaseGridGfx.BurningBasement = StageAPI.GridGfx()
StageAPI.BaseGridGfx.BurningBasement:SetRocks("gfx/grid/rocks_burningbasement.png")
StageAPI.BaseGridGfx.BurningBasement:SetDecorations("gfx/grid/props_01_basement.png", "gfx/grid/props_01_basement.anm2", 43)
StageAPI.BaseGridGfx.BurningBasement:SetDoorSprites{
    Default = {
        [RoomType.ROOM_DEFAULT] = "gfx/grid/door_01_burningbasement.png",
    },
    Secret = "gfx/grid/door_08_holeinwall.png"
}
StageAPI.BaseGridGfx.BurningBasement:SetDoorSpawns(StageAPI.BaseDoorSpawnList)

StageAPI.BaseGridGfx.Caves = StageAPI.GridGfx()
StageAPI.BaseGridGfx.Caves:SetRocks("gfx/grid/rocks_caves.png")
StageAPI.BaseGridGfx.Caves:SetPits("gfx/grid/grid_pit.png", "gfx/grid/grid_pit_water.png")
StageAPI.BaseGridGfx.Caves:SetBridges("gfx/grid/grid_bridge.png")
StageAPI.BaseGridGfx.Caves:SetDecorations("gfx/grid/props_03_caves.png")
StageAPI.BaseGridGfx.Caves:SetDoorSprites{
    Default = {
        [RoomType.ROOM_DEFAULT] = "gfx/grid/door_01_normaldoor.png",
    },
    Secret = "gfx/grid/door_08_holeinwall_caves.png"
}
StageAPI.BaseGridGfx.Caves:SetDoorSpawns(StageAPI.BaseDoorSpawnList)

StageAPI.BaseGridGfx.Secret = StageAPI.GridGfx()
StageAPI.BaseGridGfx.Secret:SetRocks("gfx/grid/rocks_secretroom.png")
StageAPI.BaseGridGfx.Secret:SetPits("gfx/grid/grid_pit.png", "gfx/grid/grid_pit_water.png")
StageAPI.BaseGridGfx.Secret:SetBridges("gfx/grid/grid_bridge.png")
StageAPI.BaseGridGfx.Secret:SetDecorations("gfx/grid/props_03_caves.png")
StageAPI.BaseGridGfx.Secret:SetDoorSprites{
    Default = "gfx/grid/door_08_holeinwall.png",
    Secret = "gfx/grid/door_08_holeinwall.png"
}
StageAPI.BaseGridGfx.Secret:SetDoorSpawns(StageAPI.BaseDoorSpawnList)

StageAPI.BaseGridGfx.Catacombs = StageAPI.GridGfx()
StageAPI.BaseGridGfx.Catacombs:SetRocks("gfx/grid/rocks_catacombs.png")
StageAPI.BaseGridGfx.Catacombs:SetPits("gfx/grid/grid_pit_catacombs.png", "gfx/grid/grid_pit_water_catacombs.png")
StageAPI.BaseGridGfx.Catacombs:SetBridges("stageapi/floors/catacombs/grid_bridge_catacombs.png")
StageAPI.BaseGridGfx.Catacombs:SetDecorations("gfx/grid/props_03_caves.png")
StageAPI.BaseGridGfx.Catacombs:SetDoorSprites{
    Default = {
        [RoomType.ROOM_DEFAULT] = "gfx/grid/door_01_normaldoor.png",
    },
    Secret = "gfx/grid/door_08_holeinwall.png"
}
StageAPI.BaseGridGfx.Catacombs:SetDoorSpawns(StageAPI.BaseDoorSpawnList)

StageAPI.BaseGridGfx.FloodedCaves = StageAPI.GridGfx()
StageAPI.BaseGridGfx.FloodedCaves:SetRocks("gfx/grid/rocks_drownedcaves.png")
StageAPI.BaseGridGfx.FloodedCaves:SetPits("gfx/grid/grid_pit_water_drownedcaves.png", "gfx/grid/grid_pit_water_drownedcaves.png")
StageAPI.BaseGridGfx.FloodedCaves:SetBridges("gfx/grid/grid_bridge_drownedcaves.png")
StageAPI.BaseGridGfx.FloodedCaves:SetDecorations("gfx/grid/props_03_caves.png")
StageAPI.BaseGridGfx.FloodedCaves:SetDoorSprites{
    Default = {
        [RoomType.ROOM_DEFAULT] = "gfx/grid/door_27_drownedcaves.png",
    },
    Secret = "gfx/grid/door_08_holeinwall_cathedral.png"
}
StageAPI.BaseGridGfx.FloodedCaves:SetDoorSpawns(StageAPI.BaseDoorSpawnList)

StageAPI.BaseGridGfx.Depths = StageAPI.GridGfx()
StageAPI.BaseGridGfx.Depths:SetRocks("gfx/grid/rocks_depths.png")
StageAPI.BaseGridGfx.Depths:SetPits("gfx/grid/grid_pit_depths.png")
StageAPI.BaseGridGfx.Depths:SetBridges("gfx/grid/grid_bridge_depths.png")
StageAPI.BaseGridGfx.Depths:SetDecorations("gfx/grid/props_05_depths.png", "gfx/grid/props_05_depths.anm2", 43)

StageAPI.BaseGridGfx.Necropolis = StageAPI.GridGfx()
StageAPI.BaseGridGfx.Necropolis:SetRocks("gfx/grid/rocks_depths.png")
StageAPI.BaseGridGfx.Necropolis:SetPits("gfx/grid/grid_pit_necropolis.png")
StageAPI.BaseGridGfx.Necropolis:SetBridges("stageapi/floors/necropolis/grid_bridge_necropolis.png")
StageAPI.BaseGridGfx.Necropolis:SetDecorations("gfx/grid/props_05_depths.png", "gfx/grid/props_05_depths.anm2", 43)

StageAPI.BaseGridGfx.DankDepths = StageAPI.GridGfx()
StageAPI.BaseGridGfx.DankDepths:SetRocks("gfx/grid/rocks_depths.png")
StageAPI.BaseGridGfx.DankDepths:SetPits("gfx/grid/grid_pit_dankdepths.png","gfx/grid/grid_pit_water_dankdepths.png")
StageAPI.BaseGridGfx.DankDepths:SetBridges("gfx/grid/grid_bridge_dankdepths.png")
StageAPI.BaseGridGfx.DankDepths:SetDecorations("gfx/grid/props_05_depths.png", "gfx/grid/props_05_depths.anm2", 43)

StageAPI.BaseGridGfx.Womb = StageAPI.GridGfx()
StageAPI.BaseGridGfx.Womb:SetRocks("gfx/grid/rocks_womb.png")
StageAPI.BaseGridGfx.Womb:SetPits("gfx/grid/grid_pit_womb.png", {
    { File = "gfx/grid/grid_pit_blood_womb.png" },
    { File = "gfx/grid/grid_pit_acid_womb.png" },
})
StageAPI.BaseGridGfx.Womb:SetBridges("stageapi/floors/utero/grid_bridge_womb.png")
StageAPI.BaseGridGfx.Womb:SetDecorations("gfx/grid/props_07_the womb.png", "gfx/grid/props_07_the womb.anm2", 43)

StageAPI.BaseGridGfx.Utero = StageAPI.GridGfx()
StageAPI.BaseGridGfx.Utero:SetRocks("gfx/grid/rocks_womb.png")
StageAPI.BaseGridGfx.Utero:SetPits("gfx/grid/grid_pit_womb.png", {
    { File = "gfx/grid/grid_pit_blood_womb.png" },
    { File = "gfx/grid/grid_pit_acid_womb.png" },
})
StageAPI.BaseGridGfx.Utero:SetBridges("stageapi/floors/utero/grid_bridge_womb.png")
StageAPI.BaseGridGfx.Utero:SetDecorations("gfx/grid/props_07_the womb.png", "gfx/grid/props_07_the womb.anm2", 43)

StageAPI.BaseGridGfx.ScarredWomb = StageAPI.GridGfx()
StageAPI.BaseGridGfx.ScarredWomb:SetRocks("gfx/grid/rocks_scarredwomb.png")
StageAPI.BaseGridGfx.ScarredWomb:SetPits("gfx/grid/grid_pit_blood_scarredwomb.png")
StageAPI.BaseGridGfx.ScarredWomb:SetBridges("gfx/grid/grid_bridge_scarredwomb.png")
StageAPI.BaseGridGfx.ScarredWomb:SetDecorations("gfx/grid/props_07_the womb.png", "gfx/grid/props_07_the womb.anm2", 43)

StageAPI.BaseGridGfx.BlueWomb = StageAPI.GridGfx()
StageAPI.BaseGridGfx.BlueWomb:SetRocks("gfx/grid/rocks_bluewomb.png")
StageAPI.BaseGridGfx.BlueWomb:SetDecorations("gfx/grid/props_07_the womb_blue.png", "gfx/grid/props_07_the womb.anm2", 43)

StageAPI.BaseGridGfx.Cathedral = StageAPI.GridGfx()
StageAPI.BaseGridGfx.Cathedral:SetRocks("gfx/grid/rocks_cathedral.png")
StageAPI.BaseGridGfx.Cathedral:SetPits("gfx/grid/grid_pit_cathedral.png")
StageAPI.BaseGridGfx.Cathedral:SetBridges("gfx/grid/grid_bridge_cathedral.png")
StageAPI.BaseGridGfx.Cathedral:SetDecorations("gfx/grid/props_10_cathedral.png", "gfx/grid/props_10_cathedral.anm2", 43)

StageAPI.BaseGridGfx.Sheol = StageAPI.GridGfx()
StageAPI.BaseGridGfx.Sheol:SetRocks("gfx/grid/rocks_sheol.png")
StageAPI.BaseGridGfx.Sheol:SetPits("gfx/grid/grid_pit_depths.png")
StageAPI.BaseGridGfx.Sheol:SetBridges("gfx/grid/grid_bridge_depths.png")
StageAPI.BaseGridGfx.Sheol:SetDecorations("gfx/grid/props_09_sheol.png", "gfx/grid/props_09_sheol.anm2", 43)

StageAPI.BaseGridGfx.Chest = StageAPI.GridGfx()
StageAPI.BaseGridGfx.Chest:SetDecorations("gfx/grid/props_11_chest.png", "gfx/grid/props_11_the chest.anm2", 43)

StageAPI.BaseGridGfx.DarkRoom = StageAPI.GridGfx()
StageAPI.BaseGridGfx.DarkRoom:SetPits("gfx/grid/grid_pit_darkroom.png")
StageAPI.BaseGridGfx.DarkRoom:SetDecorations("stageapi/none.png")

StageAPI.BaseRoomGfx = {
    Basement = StageAPI.RoomGfx(StageAPI.BaseBackdrops.Basement, StageAPI.BaseGridGfx.Basement, "_default"),
    Cellar = StageAPI.RoomGfx(StageAPI.BaseBackdrops.Cellar, StageAPI.BaseGridGfx.Cellar, "_default"),
    BurningBasement = StageAPI.RoomGfx(StageAPI.BaseBackdrops.BurningBasement, StageAPI.BaseGridGfx.BurningBasement, "_default"),
    Caves = StageAPI.RoomGfx(StageAPI.BaseBackdrops.Caves, StageAPI.BaseGridGfx.Caves, "_default"),
    Catacombs = StageAPI.RoomGfx(StageAPI.BaseBackdrops.Catacombs, StageAPI.BaseGridGfx.Catacombs, "_default"),
    FloodedCaves = StageAPI.RoomGfx(StageAPI.BaseBackdrops.FloodedCaves, StageAPI.BaseGridGfx.FloodedCaves, "_default"),
    Depths = StageAPI.RoomGfx(StageAPI.BaseBackdrops.Depths, StageAPI.BaseGridGfx.Depths, "_default"),
    Necropolis = StageAPI.RoomGfx(StageAPI.BaseBackdrops.Necropolis, StageAPI.BaseGridGfx.Necropolis, "_default"),
    DankDepths = StageAPI.RoomGfx(StageAPI.BaseBackdrops.DankDepths, StageAPI.BaseGridGfx.DankDepths, "_default"),
    Womb = StageAPI.RoomGfx(StageAPI.BaseBackdrops.Womb, StageAPI.BaseGridGfx.Womb, "_default"),
    Utero = StageAPI.RoomGfx(StageAPI.BaseBackdrops.Utero, StageAPI.BaseGridGfx.Utero, "_default"),
    ScarredWomb = StageAPI.RoomGfx(StageAPI.BaseBackdrops.ScarredWomb, StageAPI.BaseGridGfx.ScarredWomb, "_default"),
    BlueWomb = StageAPI.RoomGfx(StageAPI.BaseBackdrops.BlueWomb, StageAPI.BaseGridGfx.BlueWomb, "_default"),
    Sheol = StageAPI.RoomGfx(StageAPI.BaseBackdrops.Sheol, StageAPI.BaseGridGfx.Sheol, "_default"),
    Cathedral = StageAPI.RoomGfx(StageAPI.BaseBackdrops.Cathedral, StageAPI.BaseGridGfx.Cathedral, "_default"),
    DarkRoom = StageAPI.RoomGfx(StageAPI.BaseBackdrops.DarkRoom, StageAPI.BaseGridGfx.DarkRoom, "_default"),
    Chest = StageAPI.RoomGfx(StageAPI.BaseBackdrops.Chest, StageAPI.BaseGridGfx.Chest, "_default"),

    -- Special Rooms
    Shop = StageAPI.RoomGfx(StageAPI.BaseBackdrops.Shop, StageAPI.BaseGridGfx.Basement, "_default"),
    Library = StageAPI.RoomGfx(StageAPI.BaseBackdrops.Library, StageAPI.BaseGridGfx.Basement, "_default"),
    Secret = StageAPI.RoomGfx(StageAPI.BaseBackdrops.Secret, StageAPI.BaseGridGfx.Secret, "_default"),
    Barren = StageAPI.RoomGfx(StageAPI.BaseBackdrops.Barren, StageAPI.BaseGridGfx.Basement, "_default"),
    Isaacs = StageAPI.RoomGfx(StageAPI.BaseBackdrops.Isaacs, StageAPI.BaseGridGfx.Basement, "_default"),
    Arcade = StageAPI.RoomGfx(StageAPI.BaseBackdrops.Arcade, StageAPI.BaseGridGfx.Basement, "_default"),
    Dice = StageAPI.RoomGfx(StageAPI.BaseBackdrops.Dice, StageAPI.BaseGridGfx.Basement, "_default"),
    BlueSecret = StageAPI.RoomGfx(StageAPI.BaseBackdrops.BlueSecret, nil, "_default")
}

end


do -- Overriden Stages Reimplementation

-- Catacombs --

-- this stuff is legacy but a few mods might use it, so we're not removing it yet, there's no need to actually set the roomgfx for the stage because stageapi doesn't remove any of the existing gfx
StageAPI.CatacombsGridGfx = StageAPI.BaseGridGfx.Catacombs
StageAPI.CatacombsBackdrop = StageAPI.BaseBackdrops.Catacombs
StageAPI.CatacombsRoomGfx = StageAPI.BaseRoomGfx.Catacombs
--StageAPI.Catacombs:SetRoomGfx(StageAPI.BaseRoomGfx.Catacombs, {RoomType.ROOM_DEFAULT, RoomType.ROOM_TREASURE, RoomType.ROOM_MINIBOSS, RoomType.ROOM_BOSS})

StageAPI.CatacombsMusicID = Isaac.GetMusicIdByName("Catacombs")
StageAPI.Catacombs = StageAPI.CustomStage("Catacombs", nil, true)
StageAPI.Catacombs:SetStageMusic(StageAPI.CatacombsMusicID)
StageAPI.Catacombs:SetBossMusic({Music.MUSIC_BOSS, Music.MUSIC_BOSS2}, Music.MUSIC_BOSS_OVER)

StageAPI.Catacombs.DisplayName = "Catacombs I"

StageAPI.CatacombsTwo = StageAPI.Catacombs("Catacombs 2")
StageAPI.CatacombsTwo.DisplayName = "Catacombs II"

StageAPI.CatacombsXL = StageAPI.Catacombs("Catacombs XL")
StageAPI.CatacombsXL.DisplayName = "Catacombs XL"
StageAPI.Catacombs:SetXLStage(StageAPI.CatacombsXL)

StageAPI.AddOverrideStage("CatacombsOne", LevelStage.STAGE2_1, StageType.STAGETYPE_WOTL, StageAPI.Catacombs)
StageAPI.AddOverrideStage("CatacombsTwo", LevelStage.STAGE2_2, StageType.STAGETYPE_WOTL, StageAPI.CatacombsTwo)

StageAPI.Catacombs:SetReplace(StageAPI.StageOverride.CatacombsOne)
StageAPI.CatacombsTwo:SetReplace(StageAPI.StageOverride.CatacombsTwo)

-- Necropolis --

-- this stuff is legacy but a few mods might use it, so we're not removing it yet, there's no need to actually set the roomgfx for the stage because stageapi doesn't remove any of the existing gfx
StageAPI.NecropolisGridGfx = StageAPI.BaseGridGfx.Necropolis
StageAPI.NecropolisBackdrop = StageAPI.BaseBackdrops.Necropolis
StageAPI.NecropolisRoomGfx = StageAPI.BaseRoomGfx.Necropolis
--StageAPI.Necropolis:SetRoomGfx(StageAPI.BaseRoomGfx.Necropolis, {RoomType.ROOM_DEFAULT, RoomType.ROOM_TREASURE, RoomType.ROOM_MINIBOSS, RoomType.ROOM_BOSS})

StageAPI.NecropolisOverlays = {
    StageAPI.Overlay("stageapi/floors/necropolis/overlay.anm2", Vector(0.33, -0.15), nil, nil, 0.5),
    StageAPI.Overlay("stageapi/floors/necropolis/overlay.anm2", Vector(-0.33, -0.15), Vector(128, 128), nil, 0.5),
    StageAPI.Overlay("stageapi/floors/necropolis/overlay.anm2", Vector(0.33, 0.1), nil, nil, 0.5),
}

StageAPI.NecropolisMusicID = Isaac.GetMusicIdByName("Necropolis")
StageAPI.Necropolis = StageAPI.CustomStage("Necropolis", nil, true)
StageAPI.Necropolis:SetStageMusic(StageAPI.NecropolisMusicID)
StageAPI.Necropolis:SetBossMusic({Music.MUSIC_BOSS, Music.MUSIC_BOSS2}, Music.MUSIC_BOSS_OVER)
StageAPI.Necropolis.DisplayName = "Necropolis I"

StageAPI.NecropolisTwo = StageAPI.Necropolis("Necropolis 2")
StageAPI.NecropolisTwo.DisplayName = "Necropolis II"

StageAPI.NecropolisXL = StageAPI.Necropolis("Necropolis XL")
StageAPI.NecropolisXL.DisplayName = "Necropolis XL"
StageAPI.Necropolis:SetXLStage(StageAPI.NecropolisXL)

StageAPI.AddOverrideStage("NecropolisOne", LevelStage.STAGE3_1, StageType.STAGETYPE_WOTL, StageAPI.Necropolis)
StageAPI.AddOverrideStage("NecropolisTwo", LevelStage.STAGE3_2, StageType.STAGETYPE_WOTL, StageAPI.NecropolisTwo)

-- Utero --

-- this stuff is legacy but a few mods might use it, so we're not removing it yet, there's no need to actually set the roomgfx for the stage because stageapi doesn't remove any of the existing gfx
StageAPI.UteroGridGfx = StageAPI.BaseGridGfx.Utero
StageAPI.UteroBackdrop = StageAPI.BaseBackdrops.Utero
StageAPI.UteroRoomGfx = StageAPI.BaseRoomGfx.Utero
--StageAPI.Utero:SetRoomGfx(StageAPI.BaseRoomGfx.Utero, {RoomType.ROOM_DEFAULT, RoomType.ROOM_TREASURE, RoomType.ROOM_MINIBOSS, RoomType.ROOM_BOSS})

StageAPI.UteroOverlays = {
    StageAPI.Overlay("stageapi/floors/utero/overlay.anm2", Vector(2, -1.6), nil, nil, 0.5),
    StageAPI.Overlay("stageapi/floors/utero/overlay.anm2", Vector(-0.5, -1.5), nil, nil, 0.5),
    StageAPI.Overlay("stageapi/floors/utero/overlay.anm2", Vector(-1, -1.5), Vector(128, 128), nil, 0.5),
    StageAPI.Overlay("stageapi/floors/utero/overlay.anm2", Vector(-2, -1.6), Vector(128, 128), nil, 0.5)
}

StageAPI.UteroOverlaysDark = {
    StageAPI.Overlay("stageapi/floors/utero/overlay.anm2", Vector(2, -1.6), nil, nil, 0.1),
    StageAPI.Overlay("stageapi/floors/utero/overlay.anm2", Vector(-0.5, -1.5), nil, nil, 0.1),
    StageAPI.Overlay("stageapi/floors/utero/overlay.anm2", Vector(-1, -1.5), Vector(128, 128), nil, 0.1),
    StageAPI.Overlay("stageapi/floors/utero/overlay.anm2", Vector(-2, -1.6), Vector(128, 128), nil, 0.1)
}

StageAPI.UteroMusicID = Isaac.GetMusicIdByName("Womb/Utero")
StageAPI.Utero = StageAPI.CustomStage("Utero", nil, true)
StageAPI.Utero:SetStageMusic(StageAPI.UteroMusicID)
StageAPI.Utero:SetBossMusic({Music.MUSIC_BOSS, Music.MUSIC_BOSS2}, Music.MUSIC_BOSS_OVER)
StageAPI.Utero.DisplayName = "Utero I"

StageAPI.UteroTwo = StageAPI.Utero("Utero 2")
StageAPI.UteroTwo.DisplayName = "Utero II"

StageAPI.UteroXL = StageAPI.Utero("Utero XL")
StageAPI.UteroXL.DisplayName = "Utero XL"
StageAPI.Utero:SetXLStage(StageAPI.UteroXL)

StageAPI.AddOverrideStage("UteroOne", LevelStage.STAGE4_1, StageType.STAGETYPE_WOTL, StageAPI.Utero)
StageAPI.AddOverrideStage("UteroTwo", LevelStage.STAGE4_2, StageType.STAGETYPE_WOTL, StageAPI.UteroTwo)

end

do -- Boss Animation Data
end

StageAPI.IntentionalError.Cause = true
