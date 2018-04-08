Hooks:PostHook(PlayerStandard, "init", "Railgun_SteelsightColor_PlayerStandard__init", function(self)
	self._in_steelsight_last = false
	self._in_steelsight_delault_color = managers.user:get_setting("video_color_grading")
	self._in_steelsight_use_color = "color_heat"
end)

Hooks:PostHook(PlayerStandard, "_check_action_steelsight", "Railgun_SteelsightColor_PlayerStandard__check_action_steelsight", function(self)
	if self._in_steelsight_last ~= self:in_steelsight() then
		self._in_steelsight_last = self:in_steelsight()
		local _blueprint = self._ext_inventory:equipped_unit():base()._blueprint
		if not table.contains(_blueprint, "wpn_fps_special_roach_irons") then
			return
		end
		if not self._in_steelsight_last then
			managers.user:set_setting("video_color_grading", self._in_steelsight_delault_color)
		else
			managers.user:set_setting("video_color_grading", self._in_steelsight_use_color)
		end
		if managers.environment_controller then
			managers.environment_controller:refresh_render_settings()
		end
	end
end)