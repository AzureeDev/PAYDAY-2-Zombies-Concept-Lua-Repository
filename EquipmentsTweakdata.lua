Hooks:PostHook(EquipmentsTweakData, "init", "init_zm_perks", function(self)
    self.specials.perk_juggernog = {
        sync_possession = true,
		icon = "perk_juggernog",
		text_id = "hud_perk_juggernog"
    }

    self.specials.perk_speedcola = {
        sync_possession = true,
		icon = "perk_speedcola",
		text_id = "hud_perk_speedcola"
    }
end)