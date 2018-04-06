Hooks:PostHook(GroupAITweakData, "_init_unit_categories", "zm_allow_clk_dozers", function(self, difficulty_index)
    self.special_unit_spawn_limits = {
        shield = 6,
        medic = 6,
        taser = 6,
        tank = 6,
        spooc = 6
    }
end)