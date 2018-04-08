function NewRaycastWeaponBase:reload_speed_multiplier()
	if self._current_reload_speed_multiplier then
		return self._current_reload_speed_multiplier
	end

	local multiplier = 1

	for _, category in ipairs(self:weapon_tweak_data().categories) do
		multiplier = multiplier + 1 - managers.player:upgrade_value(category, "reload_speed_multiplier", 1)
	end

	multiplier = multiplier + 1 - managers.player:upgrade_value("weapon", "passive_reload_speed_multiplier", 1)
	multiplier = multiplier + 1 - managers.player:upgrade_value(self._name_id, "reload_speed_multiplier", 1)

	if self._setup and alive(self._setup.user_unit) and self._setup.user_unit:movement() then
		local morale_boost_bonus = self._setup.user_unit:movement():morale_boost()

		if morale_boost_bonus then
			multiplier = multiplier + 1 - morale_boost_bonus.reload_speed_bonus
		end

		if self._setup.user_unit:movement():next_reload_speed_multiplier() then
			multiplier = multiplier + 1 - self._setup.user_unit:movement():next_reload_speed_multiplier()
		end
	end

	if managers.player:has_activate_temporary_upgrade("temporary", "reload_weapon_faster") then
		multiplier = multiplier + 1 - managers.player:temporary_upgrade_value("temporary", "reload_weapon_faster", 1)
	end

	if managers.player:has_activate_temporary_upgrade("temporary", "single_shot_fast_reload") then
		multiplier = multiplier + 1 - managers.player:temporary_upgrade_value("temporary", "single_shot_fast_reload", 1)
	end

	multiplier = multiplier + 1 - managers.player:get_property("shock_and_awe_reload_multiplier", 1)
	multiplier = multiplier + 1 - managers.player:get_temporary_property("bloodthirst_reload_speed", 1)
	multiplier = multiplier + 1 - managers.player:upgrade_value("team", "crew_faster_reload", 1)
	multiplier = self:_convert_add_to_mul(multiplier)
	multiplier = multiplier * self:reload_speed_stat()
    multiplier = managers.crime_spree:modify_value("WeaponBase:GetReloadSpeedMultiplier", multiplier)
    multiplier = multiplier * (managers.player:has_special_equipment("perk_speedcola") and 2 or 1)

	return multiplier
end

_G.AddBulletTrail = _G.AddBulletTrail or {}

local HookAddBulletTrail = NewRaycastWeaponBase.fire
local idstr_trail = Idstring("trail")
local idstr_simulator_length = Idstring("simulator_length")
local idstr_size = Idstring("size")

function NewRaycastWeaponBase:fire(from_pos, direction, ...)
	 if self._name_id == "roach_primary" or self._name_id == "roach_secondary" or self._name_id == "roach_upg_primary" or self._name_id == "roach_upg_secondary" then
		self.TRAIL_EFFECT = Idstring("effects/particles/weapons/sniper_trail")
		self._trail_effect_table = {
			effect = self.TRAIL_EFFECT,
			position = Vector3(),
			normal = Vector3()
		}
		self._trail_length = World:effect_manager():get_initial_simulator_var_vector2(self.TRAIL_EFFECT, idstr_trail, idstr_simulator_length, idstr_size)
		local col_ray = {
			distance = 9999
		}
		NPCSniperRifleBase._spawn_trail_effect(self, direction, col_ray)
		World:effect_manager():set_remaining_lifetime(trail, 5000)
	end

	if self._name_id == "wunderwaffe_primary" or self._name_id == "wunderwaffe_secondary" or self._name_id == "wunderwaffe_upg_primary" or self._name_id == "wunderwaffe_upg_secondary" then
		self.TRAIL_EFFECT = Idstring("effects/particles/weapons/sniper_trail")
		self._trail_effect_table = {
			effect = self.TRAIL_EFFECT,
			position = Vector3(),
			normal = Vector3()
		}
		self._trail_length = World:effect_manager():get_initial_simulator_var_vector2(self.TRAIL_EFFECT, idstr_trail, idstr_simulator_length, idstr_size)
		local col_ray = {
			distance = 9999
		}
		NPCSniperRifleBase._spawn_trail_effect(self, direction, col_ray)
		World:effect_manager():set_remaining_lifetime(trail, 5000)
	end

	return HookAddBulletTrail(self, from_pos, direction, ...)
end