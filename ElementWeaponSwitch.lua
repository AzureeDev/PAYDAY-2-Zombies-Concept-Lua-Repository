core:import("CoreMissionScriptElement")
ElementWeaponSwitch = ElementWeaponSwitch or class(CoreMissionScriptElement.MissionScriptElement)

function ElementWeaponSwitch:init(...)
	ElementWeaponSwitch.super.init(self, ...)
end

function ElementWeaponSwitch:client_on_executed(...)
    self:on_executed(...)
end

function ElementWeaponSwitch:_get_punched_weapon_by_factory(factory)
	local tbl = {
		wpn_fps_spe_wunderwaffe_primary = "wpn_fps_spe_wunderwaffe_dg3_primary",
		wpn_fps_spe_wunderwaffe_secondary = "wpn_fps_spe_wunderwaffe_dg3_secondary",
		wpn_fps_ass_m14_primary = "wpn_fps_ass_m14_upg_primary",
		wpn_fps_ass_m14_secondary = "wpn_fps_ass_m14_upg_secondary"
	}

	local punch_tbl = {}

	for k, v in pairs(tbl) do
		table.insert(punch_tbl, v)
	end

	for _, v in ipairs(punch_tbl) do -- Refill ammo on punched weapon.
		if v == factory then
			return v
		end
	end

	for k, v in pairs(tbl) do
		if k == factory then
			return v
		end
	end

	return "wpn_fps_ass_m4"
end

function ElementWeaponSwitch:_get_random_weapon()
	--[[local table_available_weapons_mystery_box = {
		"wpn_fps_spe_wunderwaffe",
		"wpn_fps_ass_fal",
		"wpn_fps_shot_b682",
		"wpn_fps_ass_m14",
		"wpn_fps_smg_mp9",
		"wpn_fps_snp_m95",
		"wpn_fps_pis_deagle",
		"wpn_fps_ass_aug",
		"wpn_fps_smg_p90",
		"wpn_fps_sho_striker",
		"wpn_fps_ass_amcar",
		"wpn_fps_ass_m16",
		"wpn_fps_ass_scar",
		"wpn_fps_pis_judge",
		"wpn_fps_smg_thompson",
		"wpn_fps_lmg_hk21",
		"wpn_fps_lmg_m249",
		"wpn_fps_pis_rage",
		"wpn_fps_pis_peacemaker",
		"wpn_fps_ass_flint",
		"wpn_fps_pis_breech"
	}--]]

	local table_available_weapons_mystery_box = {
		"wpn_fps_spe_wunderwaffe",
		"wpn_fps_ass_m14",
		"wpn_fps_shot_b682",
		"wpn_fps_smg_mp9"
	}

	if managers.player._wunderwaffe_unlocked then
		table.remove(table_available_weapons_mystery_box, 1)
	end

	local random_entry = table_available_weapons_mystery_box[math.random(#table_available_weapons_mystery_box)]

	return random_entry
end

function ElementWeaponSwitch:on_executed(instigator)

	if not self._values.enabled then
		self._mission_script:debug_output("Element '" .. self._editor_name .. "' not enabled. Skip.", Color(1, 1, 0, 0))
		return
	end

	if self._values.instigator_only then

		local slot = self._values.is_secondary and "secondaries" or "primaries"
		local factory_id = self._values.weapon_id or "wpn_fps_ass_m4"

		if self._values.is_mystery_box then
			factory_id = self:_get_random_weapon()
		end
		
		if not self._values.force_classic_id then
			local current_index_equipped = managers.player:player_unit():inventory():equipped_selection()
			local endfix = ""

			if current_index_equipped == 1 then
				endfix = "_secondary"
			else
				endfix = "_primary"
			end
		
			factory_id = factory_id .. endfix
		end

		if self._values.is_pap_engine then
			local current_peer_weapon = instigator:inventory():equipped_unit():base()._factory_id
	        local clbk_gpwbf = self:_get_punched_weapon_by_factory(current_peer_weapon)

	        if clbk_gpwbf then
	            factory_id = clbk_gpwbf
	        end
		end

		local blueprint_fucking_ovk
		local blueprint_table = managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id)
		local blueprint_to_string = managers.weapon_factory:blueprint_to_string(factory_id, blueprint_table)

		if instigator ~= managers.player:player_unit() then
			blueprint_fucking_ovk = blueprint_to_string
		else
			blueprint_fucking_ovk = blueprint_table
		end

		local primary = {
			equipped = true,
			factory_id = factory_id,
			blueprint = blueprint_fucking_ovk,
			weapon_id = managers.weapon_factory:get_weapon_id_by_factory_id(factory_id),
			global_values = {}
		}

		--local primary_slot = managers.blackmarket:equipped_weapon_slot(slot)
		--local texture_switches = managers.blackmarket:get_weapon_texture_switches(slot, primary_slot, primary)

		local cosmetics = nil
		local cosmetics_string = self._values.skin_id or "nil" .. "-1-0"
		local cosmetics_data = string.split(cosmetics_string, "-")
		local weapon_skin_id = cosmetics_data[1] or "nil"
		local quality_index_s = cosmetics_data[2] or "1"
		local bonus_id_s = cosmetics_data[3] or "0"
		if weapon_skin_id ~= "nil" then
			local quality = tweak_data.economy:get_entry_from_index("qualities", tonumber(quality_index_s))
			local bonus = bonus_id_s == "1" and true or false
			cosmetics = "pap-1-0"

			if instigator == managers.player:player_unit() then
				cosmetics = {
					id = weapon_skin_id,
					quality = quality,
					bonus = bonus
				}
			end
		end

		local params = {
			weapon_id = primary.factory_id,
			equip = primary.equipped,
			instant = false,
			blueprint = primary.blueprint,
			cosmetics = cosmetics or "nil-1-0"--,
			--texture_switch = texture_switches
		}

		instigator:inventory():add_unit_by_factory_name(params.weapon_id, params.equip, params.instant, params.blueprint, params.cosmetics)
		
		if instigator:movement().sync_equip_weapon then
			instigator:movement():sync_equip_weapon()
		end

		if instigator:inventory().equip_selection then
			instigator:inventory():equip_selection(current_index_equipped, false)
		end
		
		ElementWeaponSwitch.super.on_executed(self, instigator)
		return
	end

	local slot = self._values.is_secondary and "secondaries" or "primaries"
	local factory_id = self._values.weapon_id or "wpn_fps_ass_m4"

	if self._values.is_mystery_box then
		factory_id = self:_get_random_weapon()
	end

	if not self._values.force_classic_id then
		local current_index_equipped = managers.player:player_unit():inventory():equipped_selection()
		local endfix = ""

		if current_index_equipped == 1 then
			endfix = "_secondary"
		else
			endfix = "_primary"
		end
		
		factory_id = factory_id .. endfix
	end

	if self._values.is_pap_engine then
		factory_id = self:_get_punched_weapon_by_factory(managers.player:player_unit():inventory():equipped_unit():base()._factory_id)
	end

	local primary = {
		equipped = true,
		factory_id = factory_id,
		blueprint = managers.weapon_factory:get_default_blueprint_by_factory_id(factory_id),
		weapon_id = managers.weapon_factory:get_weapon_id_by_factory_id(factory_id),
		global_values = {}
	}

	--local primary_slot = managers.blackmarket:equipped_weapon_slot(slot)
	--local texture_switches = managers.blackmarket:get_weapon_texture_switches(slot, primary_slot, primary)

	local cosmetics = nil
	local cosmetics_string = self._values.skin_id or "nil" .. "-1-0"
	local cosmetics_data = string.split(cosmetics_string, "-")
	local weapon_skin_id = cosmetics_data[1] or "nil"
	local quality_index_s = cosmetics_data[2] or "1"
	local bonus_id_s = cosmetics_data[3] or "0"
	if weapon_skin_id ~= "nil" then
		local quality = tweak_data.economy:get_entry_from_index("qualities", tonumber(quality_index_s))
		local bonus = bonus_id_s == "1" and true or false
		cosmetics = {
			id = weapon_skin_id,
			quality = quality,
			bonus = bonus
		}
	end

	local params = {
		weapon_id = primary.factory_id,
		equip = primary.equipped,
		instant = false,
		blueprint = primary.blueprint,
		cosmetics = cosmetics or "nil-1-0"--,
		--texture_switch = texture_switches
	}
	
	managers.player:player_unit():inventory():add_unit_by_factory_name(params.weapon_id, params.equip, params.instant, params.blueprint, params.cosmetics)
	
	if managers.player:player_unit():movement().sync_equip_weapon then
		managers.player:player_unit():movement():sync_equip_weapon()
	end

	if  managers.player:player_unit():inventory().equip_selection then
		managers.player:player_unit():inventory():equip_selection(current_index_equipped, false)
	end

	local fm_1 = managers.player:player_unit():inventory():unit_by_selection(1):base():fire_mode()
	local fm_2 = managers.player:player_unit():inventory():unit_by_selection(2):base():fire_mode()

	ElementWeaponSwitch.super.on_executed(self, instigator)
end

function ElementWeaponSwitch:on_script_activated()
    self._mission_script:add_save_state_cb(self._id)
end

function ElementWeaponSwitch:save(data)
    data.save_me = true
    data.enabled = self._values.enabled
end

function ElementWeaponSwitch:load(data)
    self:set_enabled(data.enabled)
end
