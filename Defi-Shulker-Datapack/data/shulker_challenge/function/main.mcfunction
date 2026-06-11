# ==========================================================
# 1. KIT DE DÉPART (LES 5 SHULKER BOXES)
# ==========================================================
execute as @a unless score @s a_son_kit matches 0.. run scoreboard players set @s a_son_kit 0

execute as @a[scores={a_son_kit=0}] run give @s red_shulker_box 1
execute as @a[scores={a_son_kit=0}] run give @s blue_shulker_box 1
execute as @a[scores={a_son_kit=0}] run give @s lime_shulker_box 1
execute as @a[scores={a_son_kit=0}] run give @s yellow_shulker_box 1
execute as @a[scores={a_son_kit=0}] run give @s purple_shulker_box 1

execute as @a[scores={a_son_kit=0}] run scoreboard players set @s a_son_kit 1


# ==========================================================
# 2. LE CHRONO DES 5 JOURS & SÉCURITÉS
# ==========================================================
# Si pas de chrono, on l'initialise au max
execute as @a unless score @s shulker_timer matches -1000000.. run scoreboard players set @s shulker_timer 120000

# ANTI-CHEATS LOGIQUES : On bloque le score entre 0 et 120 000 max
execute as @a[scores={shulker_timer=120001..}] run scoreboard players set @s shulker_timer 120000

# On fait baisser le chrono (on s'arrête à -1 pour la logique du message)
execute as @a[scores={shulker_timer=-19..}] run scoreboard players remove @s shulker_timer 1


# ==========================================================
# 3. LES ALERTES VISUELLES
# ==========================================================
execute as @a[scores={shulker_timer=24000}] run tellraw @s {"text":"⚠️ Il ne vous reste plus que 1 jour avant de devoir déménager !","color":"yellow"}

execute as @a[scores={shulker_timer=200}] run title @s title {"text":"⚠️ PARTEZ VITE ! ⚠️","color":"red"}
execute as @a[scores={shulker_timer=200}] run title @s subtitle {"text":"Plus que 10 secondes !","color":"gold"}


# ==========================================================
# 4. LA PUNITION (Version sans entité buggée !)
# ==========================================================
# Si le chrono est à 0 ou en dessous, on donne les malus
execute as @a[scores={shulker_timer=..0}] run effect give @s minecraft:hunger 10 2
execute as @a[scores={shulker_timer=..0}] run effect give @s minecraft:slowness 10 1

# Le message s'affiche pile au moment où ça tombe à 0
execute as @a[scores={shulker_timer=0}] run tellraw @s {"text":"❌ Vous avez passé plus de 5 jours au même endroit ! Le malus s'active !","color":"red"}

# Si le joueur reste sur place, le chrono descend dans le négatif. Dès qu'il atteint -20 (1 seconde après), on le remet à 0.
# Comme ça, le chrono boucle entre 0 et -20, et le message s'affiche toutes les secondes au lieu de spammer 20 fois par seconde !
execute as @a[scores={shulker_timer=..-20}] run scoreboard players set @s shulker_timer 0


# ==========================================================
# 5. SYSTÈME DE RADAR ET DÉTECTION DE ZONE
# ==========================================================
execute as @a unless entity @e[tag=campement] at @s run summon interaction ~ ~ ~ {Tags:["campement"]}

# Déclenchement du déménagement (si loin de la balise)
execute as @a at @s unless entity @e[tag=campement,distance=..150] run tellraw @s {"text":"✨ Nouveau territoire découvert ! Votre chrono est réinitialisé.","color":"green"}
execute as @a at @s unless entity @e[tag=campement,distance=..150] run kill @e[tag=campement,limit=1,sort=nearest]
execute as @a at @s unless entity @e[tag=campement,distance=..150] run summon interaction ~ ~ ~ {Tags:["campement"]}
execute as @a at @s unless entity @e[tag=campement,distance=..150] run scoreboard players set @s shulker_timer 120000