function orbital:raycast/nuke_raycast_power_3/spawn_armor_stand
item replace entity @s weapon.mainhand with minecraft:air
tag @s add replace3
execute at @s run schedule function orbital:osc_rod/nuke_aim_3_inf/replace 2t
