Hooks:PreHook(PlayerManager, "init", "zm_init_perk", function(self)
    self._has_perk_juggernog = false
    self._wunderwaffe_unlocked = false
    self._roach_unlocked = false
end)

Hooks:PostHook(PlayerManager, "update", "zm_upd_perk", function(self, t, dt)

    --[[
        Perks : Effects

        - Juggernog                     2,500 Points
        // First use only of this perk with restore health, shield, and downs.
        MAIN: Current Health x2
        ID  : perk_juggernog

        - Speed Cola                    4,000 Points
        MAIN: You reload your weapons 100% faster.
        ID  : perk_speedcola

        - Quick Revive                  2,000 Points
        MAIN: (Solo)  Auto-revive when downed.
              (Multi) Next time downed will not count on the total downs value.
              ID  : perk_quickrevive

        - Double Tap                    3,000 Points
        MAIN: Increase the rate of fire of all weapons by 50%.
        ID  : perk_doubletap

        - Deadshot Daiquiri             2,500 Points
        MAIN: Headshot multiplier of all enemies increased by 3.
        ID  : perk_deadshot

    ]]

    local player = self:player_unit()

    if self:has_special_equipment("perk_juggernog") then
        if not self._has_perk_juggernog then
            player:character_damage():replenish()
            local new_health = tonumber(player:character_damage():_max_health()) * 2
            player:character_damage():change_health(new_health)
            self._has_perk_juggernog = true
        end
    end

    if not self._wunderwaffe_unlocked then
        local current_state = self:get_current_state()
        if current_state then
            local current_weapon = current_state:get_equipped_weapon()
            if current_weapon.name_id == "wunderwaffe_primary" or current_weapon.name_id == "wunderwaffe_secondary" then
                local lip = SoundDevice:create_source("lip")
                lip:post_event("zm_announcer_wunder")
                LuaNetworking:SendToPeers( "ZMWunderwaffeUnlocked", "1" )
                self._wunderwaffe_unlocked = true
            end
        end
    end

    if not self._roach_unlocked then
        local current_state = self:get_current_state()
        if current_state then
            local current_weapon = current_state:get_equipped_weapon()
            if current_weapon.name_id == "roach_primary" or current_weapon.name_id == "roach_secondary" then
                local lip = SoundDevice:create_source("lip")
                lip:post_event("zm_announcer_roach")
                LuaNetworking:SendToPeers( "ZMRoachUnlocked", "1" )
                self._roach_unlocked = true
            end
        end
    end

end)

Hooks:PostHook(PlayerManager, "check_skills", "zm_check_skills", function(self)
    self:register_message(Message.OnWeaponFired, "wunderwaffe_shot", callback(SniperGrazeDamage, SniperGrazeDamage, "on_wunderwaffe_fired"))
end)

Hooks:Add("NetworkReceivedData", "NetworkReceivedData_Wunderwaffe_unlock", function(sender, id, data)
    if id == "ZMWunderwaffeUnlocked" then
        local lip = SoundDevice:create_source("lip")
        lip:post_event("zm_announcer_wunder")
        managers.player._wunderwaffe_unlocked = true
    end

    if id == "ZMRoachUnlocked" then
        local lip = SoundDevice:create_source("lip")
        lip:post_event("zm_announcer_roach")
        managers.player._roach_unlocked = true
    end
end)