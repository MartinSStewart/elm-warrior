module Warrior.Maps exposing (..)

import Warrior.Map as Map exposing (Map)
import Warrior.Npc.Dummy as Dummy
import Warrior.Npc.StationaryAttacker as StationaryAttacker
import Warrior.Player as Player


all : List Map
all =
    List.concat
        [ movement
        , fighting
        ]


movement : List Map
movement =
    [ straight
    , inverseL
    , loop
    , withDeadEndLeft
    , withDeadEndRight
    , openSpace
    , openSpaceReverse
    ]


fighting : List Map
fighting =
    [ straightGuard
    , straightPowerfulGuard
    , straightGuardPickupSword
    ]



-- MOVEMENT TESTS


straight : Map
straight =
    Map.init { rows = 1, columns = 5 }
        |> Map.withSpawnPoint { x = 0, y = 0 }
        |> Map.withExitPoint { x = 4, y = 0 }


inverseL : Map
inverseL =
    Map.init { rows = 5, columns = 5 }
        |> Map.withWalledArea { x = 0, y = 1 } { x = 3, y = 4 }
        |> Map.withSpawnPoint { x = 0, y = 0 }
        |> Map.withExitPoint { x = 4, y = 4 }


loop : Map
loop =
    Map.init { rows = 7, columns = 7 }
        |> Map.withSpawnPoint { x = 0, y = 0 }
        |> Map.withExitPoint { x = 3, y = 3 }
        |> Map.withWalledArea { x = 0, y = 1 } { x = 5, y = 1 }
        |> Map.withWalledArea { x = 5, y = 1 } { x = 5, y = 5 }
        |> Map.withWalledArea { x = 5, y = 5 } { x = 1, y = 5 }
        |> Map.withWalledArea { x = 1, y = 5 } { x = 1, y = 3 }


withDeadEndLeft : Map
withDeadEndLeft =
    Map.init { rows = 7, columns = 7 }
        |> Map.withSpawnPoint { x = 3, y = 0 }
        |> Map.withExitPoint { x = 6, y = 1 }
        |> Map.withWalledArea { x = 0, y = 0 } { x = 1, y = 0 }
        |> Map.withWalledArea { x = 5, y = 0 } { x = 6, y = 0 }
        |> Map.withWalledArea { x = 0, y = 1 } { x = 2, y = 2 }
        |> Map.withWalledArea { x = 1, y = 4 } { x = 2, y = 6 }
        |> Map.withWalledArea { x = 4, y = 1 } { x = 5, y = 2 }
        |> Map.withWalledArea { x = 4, y = 4 } { x = 6, y = 6 }
        |> Map.withWalledArea { x = 0, y = 6 } { x = 0, y = 6 }


withDeadEndRight : Map
withDeadEndRight =
    Map.init { rows = 7, columns = 7 }
        |> Map.withSpawnPoint { x = 3, y = 0 }
        |> Map.withExitPoint { x = 0, y = 5 }
        |> Map.withWalledArea { x = 0, y = 0 } { x = 1, y = 0 }
        |> Map.withWalledArea { x = 5, y = 0 } { x = 6, y = 0 }
        |> Map.withWalledArea { x = 0, y = 1 } { x = 2, y = 2 }
        |> Map.withWalledArea { x = 1, y = 4 } { x = 2, y = 6 }
        |> Map.withWalledArea { x = 4, y = 1 } { x = 5, y = 2 }
        |> Map.withWalledArea { x = 4, y = 4 } { x = 6, y = 6 }
        |> Map.withWalledArea { x = 0, y = 6 } { x = 0, y = 6 }


openSpace : Map
openSpace =
    Map.init { rows = 7, columns = 7 }
        |> Map.withSpawnPoint { x = 1, y = 1 }
        |> Map.withExitPoint { x = 5, y = 5 }


openSpaceReverse : Map
openSpaceReverse =
    Map.init { rows = 7, columns = 7 }
        |> Map.withSpawnPoint { x = 5, y = 5 }
        |> Map.withExitPoint { x = 1, y = 1 }



-- FIGHTING TESTS


straightGuard : Map
straightGuard =
    Map.init { rows = 1, columns = 7 }
        |> Map.withSpawnPoint { x = 0, y = 0 }
        |> Map.withExitPoint { x = 6, y = 0 }
        |> Map.withNPC { x = 3, y = 0 } Dummy.takeTurn


straightPowerfulGuard : Map
straightPowerfulGuard =
    Map.init { rows = 1, columns = 7 }
        |> Map.withSpawnPoint { x = 0, y = 0 }
        |> Map.withExitPoint { x = 6, y = 0 }
        |> Map.withNPC { x = 3, y = 0 } StationaryAttacker.takeTurn
        |> Map.armLastNpc Player.Sword


straightGuardPickupSword : Map
straightGuardPickupSword =
    Map.init { rows = 1, columns = 7 }
        |> Map.withSpawnPoint { x = 0, y = 0 }
        |> Map.withExitPoint { x = 6, y = 0 }
        |> Map.withNPC { x = 4, y = 0 } StationaryAttacker.takeTurn
        |> Map.withItem { x = 2, y = 0 } Player.Sword