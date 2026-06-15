execute as @a unless score @s a_son_kit matches 0.. run scoreboard players set @s a_son_kit 0

execute as @a[scores={a_son_kit=0}] run give @s red_shulker_box 1
execute as @a[scores={a_son_kit=0}] run give @s blue_shulker_box 1
execute as @a[scores={a_son_kit=0}] run give @s lime_shulker_box 1
execute as @a[scores={a_son_kit=0}] run give @s yellow_shulker_box 1
execute as @a[scores={a_son_kit=0}] run give @s purple_shulker_box 1

execute as @a[scores={a_son_kit=0}] run scoreboard players set @s a_son_kit 1


execute as @a unless score @s shulker_timer matches -1000000.. run scoreboard players set @s shulker_timer 120000

execute as @a[scores={shulker_timer=120001..}] run scoreboard players set @s shulker_timer 120000

execute as @a[scores={shulker_timer=-19..}] run scoreboard players remove @s shulker_timer 1


execute as @a[scores={shulker_timer=24000}] run tellraw @s {"text":"⚠️ Il ne vous reste plus que 1 jour avant de devoir déménager !","color":"yellow"}

execute as @a[scores={shulker_timer=200}] run title @s title {"text":"⚠️ PARTEZ VITE ! ⚠️","color":"red"}
execute as @a[scores={shulker_timer=200}] run title @s subtitle {"text":"Plus que 10 secondes !","color":"gold"}


execute as @a[scores={shulker_timer=..0}] run effect give @s minecraft:hunger 10 2
execute as @a[scores={shulker_timer=..0}] run effect give @s minecraft:slowness 10 1

execute as @a[scores={shulker_timer=1..}] run effect clear @s minecraft:hunger
execute as @a[scores={shulker_timer=1..}] run effect clear @s minecraft:slowness

execute as @a[scores={shulker_timer=0}] run tellraw @s {"text":"❌ Vous avez passé plus de 5 jours au même endroit ! Le malus s'active !","color":"red"}

execute as @a[scores={shulker_timer=..-20}] run scoreboard players set @s shulker_timer 0


execute as @a at @s unless entity @e[tag=campement] run summon interaction ~ ~ ~ {Tags:["campement"]}

execute as @a at @s unless entity @e[tag=campement,distance=..150] run tag @s add demenagement

execute as @a[tag=demenagement,scores={shulker_timer=..0}] run advancement grant @s only shulker_challenge:demenagement_survie
execute as @a[tag=demenagement] run tellraw @s {"text":"✨ Nouveau territoire découvert ! Votre chrono est réinitialisé.","color":"green"}
execute as @a[tag=demenagement] run scoreboard players set @s shulker_timer 120000

execute as @e[tag=campement] at @s unless entity @a[distance=..150] run kill @s

execute as @a[tag=demenagement] at @s run summon interaction ~ ~ ~ {Tags:["campement"]}

execute as @a[tag=demenagement] run effect clear @s minecraft:hunger
execute as @a[tag=demenagement] run effect clear @s minecraft:slowness

execute as @a[tag=demenagement] run tag @s remove demenagement