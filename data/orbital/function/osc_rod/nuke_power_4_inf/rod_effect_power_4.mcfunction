execute at @s run function orbital:nuke_power_4
item replace entity @s weapon.mainhand with minecraft:air
tag @s add replace4
execute at @s run schedule function orbital:osc_rod/nuke_power_4_inf/replace 2t
