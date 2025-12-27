function orbital:raycast/nuke_raycast_power_2/spawn_armor_stand
item replace entity @s weapon.mainhand with minecraft:air
tag @s add replace2
execute at @s run schedule function orbital:osc_rod/nuke_aim_2_inf/replace 2t
