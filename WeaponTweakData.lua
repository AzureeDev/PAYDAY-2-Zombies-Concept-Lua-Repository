Hooks:PostHook(WeaponTweakData, "_init_new_weapons", "zm_init_new_weapons", function(self, autohit_rifle_default, autohit_pistol_default, autohit_shotgun_default, autohit_lmg_default, autohit_snp_default, autohit_smg_default, autohit_minigun_default, damage_melee_default, damage_melee_effect_multiplier_default, aim_assist_rifle_default, aim_assist_pistol_default, aim_assist_shotgun_default, aim_assist_lmg_default, aim_assist_snp_default, aim_assist_smg_default, aim_assist_minigun_default)
    local autohit_snp_default = {
        INIT_RATIO = 0.05,
        MAX_RATIO = 0.4,
        far_angle = 0.2,
        far_dis = 5000,
        MIN_RATIO = 0.2,
        near_angle = 2
    }

    local aim_assist_snp_default = deep_clone(autohit_snp_default)
    aim_assist_snp_default.near_angle = 20

    local damage_melee_default = 1.5
    local damage_melee_effect_multiplier_default = 1.75

    self.nothing2_primary = deep_clone(self.m134)
    self.nothing2_primary.AMMO_PICKUP = {0, 0}
    self.nothing2_primary.timers.reload_not_empty = 0
    self.nothing2_primary.timers.reload_empty = 0
    self.nothing2_primary.timers.unequip = 0
    self.nothing2_primary.timers.equip = 0
    self.nothing2_primary.CLIP_AMMO_MAX = 0
    self.nothing2_primary.NR_CLIPS_MAX = 1
    self.nothing2_primary.fire_mode_data = {fire_rate = 10000}
    self.nothing2_primary.sounds.fire = nil
    self.nothing2_primary.sounds.fire_single = nil
    self.nothing2_primary.sounds.fire_auto = nil
    self.nothing2_primary.sounds.dryfire = nil
    self.nothing2_primary.sounds.enter_steelsight = nil
    self.nothing2_primary.sounds.leave_steelsight = nil
    self.nothing2_primary.stats = {
        zoom = 1,
		total_ammo_mod = 1,
		damage = 0,
		alert_size = 7,
		spread = 0,
		spread_moving = 0,
		recoil = 0,
		value = 1,
		extra_ammo = 51,
		reload = 11,
		suppression = 5,
		concealment = 30
    }

    self.wunderwaffe_primary = deep_clone(self.wa2000)
    self.wunderwaffe_primary.AMMO_PICKUP = {0, 0}
    self.wunderwaffe_primary.CLIP_AMMO_MAX = 3
    self.wunderwaffe_primary.NR_CLIPS_MAX = 5
    self.wunderwaffe_primary.FIRE_MODE = "single"
    self.wunderwaffe_primary.CAN_TOGGLE_FIREMODE = false
    self.wunderwaffe_primary.single = {fire_rate = 1}
    self.wunderwaffe_primary.fire_mode_data = {fire_rate = 1}
    self.wunderwaffe_primary.stats_modifiers = {damage = 1000}
    self.wunderwaffe_primary.muzzleflash = "effects/payday2/particles/electric/electric_sparks_small"
    self.wunderwaffe_primary.shell_ejection = nil
    self.wunderwaffe_primary.sounds.fire = "wunderwaffe_fire"
    self.wunderwaffe_primary.sounds.fire_single = "wunderwaffe_fire"
    self.wunderwaffe_primary.sounds.dryfire = nil
    self.wunderwaffe_primary.timers = {
		reload_not_empty = 6,
		reload_empty = 6,
		unequip = 1,
		equip = 1
	}
    self.wunderwaffe_primary.stats = {
        zoom = 1,
		total_ammo_mod = 10,
		damage = 120,
		alert_size = 7,
		spread = 24,
		spread_moving = 24,
		recoil = 2,
		value = 1,
		extra_ammo = 51,
		reload = 11,
		suppression = 5,
		concealment = 5
    }
    self.wunderwaffe_primary.animations.reload_name_id = "wa2000"
    self.wunderwaffe_primary.weapon_hold = "wa2000"
    self.wunderwaffe_primary.can_shoot_through_wall = false
    self.wunderwaffe_primary.can_shoot_through_enemy = false

    self.wunderwaffe_secondary = deep_clone(self.wunderwaffe_primary)
    self.wunderwaffe_secondary.use_data = {selection_index = 1}

    self.wunderwaffe_dg3_primary = deep_clone(self.wunderwaffe_primary)
    self.wunderwaffe_dg3_primary.CLIP_AMMO_MAX = 6
    self.wunderwaffe_dg3_primary.NR_CLIPS_MAX = 5
    self.wunderwaffe_dg3_primary.timers = {
		reload_not_empty = 4.7,
		reload_empty = 4.7,
		unequip = 1,
		equip = 1
	}
    self.wunderwaffe_dg3_primary.stats = {
        zoom = 1,
		total_ammo_mod = 20,
		damage = 120,
		alert_size = 7,
		spread = 24,
		spread_moving = 24,
		recoil = 2,
		value = 1,
		extra_ammo = 51,
		reload = 11,
		suppression = 5,
		concealment = 5
    }
    self.wunderwaffe_dg3_secondary = deep_clone(self.wunderwaffe_dg3_primary)
    self.wunderwaffe_dg3_secondary.use_data = {selection_index = 1}

    self:_init_zm_new_weapons()
end)

local PRIMARY = 2
local SECONDARY = 1

function WeaponTweakData:_init_zm_new_weapons()
    self.colt_1911_primary = deep_clone(self.colt_1911)
    self.colt_1911_primary.animations.reload_name_id = "colt_1911"
    self.colt_1911_primary.weapon_hold = "colt_1911"
    self.colt_1911_primary.use_data = {selection_index = PRIMARY}
    self.colt_1911_secondary = deep_clone(self.colt_1911_primary)
    self.colt_1911_secondary.use_data = {selection_index = SECONDARY}

    self.new_m14_primary = deep_clone(self.new_m14)
    self.new_m14_primary.animations.reload_name_id = "new_m14"
    self.new_m14_primary.weapon_hold = "new_m14"
    self.new_m14_secondary = deep_clone(self.new_m14_primary)
    self.new_m14_secondary.use_data = {selection_index = SECONDARY}

    self.b682_primary = deep_clone(self.b682)
    self.b682_primary.animations.reload_name_id = "b682"
    self.b682_primary.weapon_hold = "b682"
    self.b682_secondary = deep_clone(self.b682_primary)
    self.b682_secondary.use_data = {selection_index = SECONDARY, align_place = "right_hand"}

    self.mp9_primary = deep_clone(self.mp9)
    self.mp9_primary.animations.reload_name_id = "mp9"
    self.mp9_primary.weapon_hold = "mp9"
    self.mp9_primary.use_data = {selection_index = PRIMARY}
    self.mp9_secondary = deep_clone(self.mp9_primary)
    self.mp9_secondary.use_data = {selection_index = SECONDARY}

    self.m95_primary = deep_clone(self.m95)
    self.m95_primary.animations.reload_name_id = "m95"
    self.m95_primary.weapon_hold = "m95"
    self.m95_primary.stats_modifiers = {damage = 50}
    self.m95_secondary = deep_clone(self.m95_primary)
    self.m95_secondary.use_data = {selection_index = SECONDARY}    

    self:_init_upgraded_zm_weapons()
end

function WeaponTweakData:_init_upgraded_zm_weapons()
    self.new_m14_upg_primary = deep_clone(self.new_m14_primary)
    self.new_m14_upg_primary.stats_modifiers = {damage = 8}
    self.new_m14_upg_primary.stats = {
        zoom = 1,
		total_ammo_mod = 70,
		damage = 200,
		alert_size = 7,
		spread = 24,
		spread_moving = 24,
		recoil = 2,
		value = 1,
		extra_ammo = 51,
		reload = 11,
		suppression = 5,
		concealment = 5
    }
    self.new_m14_upg_secondary = deep_clone(self.new_m14_upg_primary)
    self.new_m14_upg_secondary.use_data = {selection_index = SECONDARY}
end