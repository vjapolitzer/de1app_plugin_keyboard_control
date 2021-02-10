package require de1_machine

set plugin_name "keyboard_control"

set ::plugins::${plugin_name}::author "Vincent Politzer"
set ::plugins::${plugin_name}::contact "redfoxdude@gmail.com"
set ::plugins::${plugin_name}::version 1.1
set ::plugins::${plugin_name}::description "Control your non-GHC DE1 with a keyboard"

proc single_letter {newstr} {
    if {[string length $newstr] > 1} {
        return 0
    }
    if {[string is lower $newstr] || [string is upper $newstr]} {
        return 1
    }
    borg toast [translate "Letter keys only!"]
    return 0
}

proc kbc_convert_key_and_save {configkey} {
    if {$configkey == "Espresso"} {
        set espresso_key [string tolower $::plugins::keyboard_control::settings(espresso_key)]

        # convert to ASCII
        scan $espresso_key %c espresso_keycode

        # convert ASCII keycode to Android keycode
        set espresso_droid_keycode [expr $espresso_keycode - 93]
        
        set ::plugins::keyboard_control::settings(espresso_key) $espresso_key
        set ::plugins::keyboard_control::settings(espresso_keycode) $espresso_keycode
        set ::plugins::keyboard_control::settings(espresso_droid_keycode) $espresso_droid_keycode

    } elseif {$configkey == "Steam"} {
        set steam_key [string tolower $::plugins::keyboard_control::settings(steam_key)]

        # convert to ASCII
        scan $steam_key %c steam_keycode

        # convert ASCII keycode to Android keycode
        set steam_droid_keycode [expr $steam_keycode - 93]

        set ::plugins::keyboard_control::settings(steam_key) $steam_key
        set ::plugins::keyboard_control::settings(steam_keycode) $steam_keycode
        set ::plugins::keyboard_control::settings(steam_droid_keycode) $steam_droid_keycode
        
    } elseif {$configkey == "HotWater"} {
        set water_key [string tolower $::plugins::keyboard_control::settings(water_key)]

        # convert to ASCII
        scan $water_key %c water_keycode

        # convert ASCII keycode to Android keycode
        set water_droid_keycode [expr $water_keycode - 93]

        set ::plugins::keyboard_control::settings(water_key) $water_key
        set ::plugins::keyboard_control::settings(water_keycode) $water_keycode
        set ::plugins::keyboard_control::settings(water_droid_keycode) $water_droid_keycode

    } elseif {$configkey == "HotWaterRinse"} {
        set flush_key [string tolower $::plugins::keyboard_control::settings(flush_key)]

        # convert to ASCII
        scan $flush_key %c flush_keycode

        # convert ASCII keycode to Android keycode
        set flush_droid_keycode [expr $flush_keycode - 93]
        
        set ::plugins::keyboard_control::settings(flush_key) $flush_key
        set ::plugins::keyboard_control::settings(flush_keycode) $flush_keycode
        set ::plugins::keyboard_control::settings(flush_droid_keycode) $flush_droid_keycode
    }

    msg "Saving keyboard_control settings"
    save_plugin_settings "keyboard_control"
}

proc ::plugins::${plugin_name}::preload {} {

    # Unique name per page
    set page_name "plugin_keyboard_control_page_default"

    # Background image and "Done" button
    add_de1_page "$page_name" "settings_message.png" "default"
    add_de1_text $page_name 1280 1310 -text [translate "Done"] -font Helv_10_bold -fill "#fAfBff" -anchor "center"
    add_de1_button $page_name {say [translate {Done}] $::settings(sound_button_in); save_plugin_settings visualizer_upload;  fill_extensions_listbox; page_to_show_when_off extensions; set_extensions_scrollbar_dimensions}  980 1210 1580 1410 ""

    # Headline
    add_de1_text $page_name 1280 300 -text [translate "Keyboard Control"] -font Helv_20_bold -width 1200 -fill "#444444" -anchor "center" -justify "center"

    # Espresso Key Setting
    add_de1_text $page_name 280 480 -text [translate "Espresso Key"] -font Helv_8 -width 300 -fill "#444444" -anchor "nw" -justify "center"
    add_de1_widget "$page_name" entry 280 540  {
        set ::globals(widget_profile_name_to_save) $widget
        bind $widget <Return> { say [translate {save}] $::settings(sound_button_in); borg toast [translate "Saved"]; kbc_convert_key_and_save "Espresso"; hide_android_keyboard}
        bind $widget <Leave> hide_android_keyboard
    } -width [expr {int(2 * $::globals(entry_length_multiplier))}] -validate all -validatecommand {single_letter %P} -font Helv_8  -borderwidth 1 -bg #fbfaff  -foreground #4e85f4 -textvariable ::plugins::keyboard_control::settings(espresso_key) -relief flat  -highlightthickness 1 -highlightcolor #000000

    # Steam Key Setting
    add_de1_text $page_name 280 660 -text [translate "Steam Key"] -font Helv_8 -width 300 -fill "#444444" -anchor "nw" -justify "center"
    add_de1_widget "$page_name" entry 280 720  {
        set ::globals(widget_profile_name_to_save) $widget
        bind $widget <Return> { say [translate {save}] $::settings(sound_button_in); borg toast [translate "Saved"]; kbc_convert_key_and_save "Steam"; hide_android_keyboard}
        bind $widget <Leave> hide_android_keyboard
    } -width [expr {int(2 * $::globals(entry_length_multiplier))}] -validate all -validatecommand {single_letter %P} -font Helv_8  -borderwidth 1 -bg #fbfaff  -foreground #4e85f4 -textvariable ::plugins::keyboard_control::settings(steam_key) -relief flat  -highlightthickness 1 -highlightcolor #000000

    # Hot Water Key Setting
    add_de1_text $page_name 280 840 -text [translate "Hot Water Key"] -font Helv_8 -width 300 -fill "#444444" -anchor "nw" -justify "center"
    add_de1_widget "$page_name" entry 280 900  {
        set ::globals(widget_profile_name_to_save) $widget
        bind $widget <Return> { say [translate {save}] $::settings(sound_button_in); borg toast [translate "Saved"]; kbc_convert_key_and_save "HotWater"; hide_android_keyboard}
        bind $widget <Leave> hide_android_keyboard
    } -width [expr {int(2 * $::globals(entry_length_multiplier))}] -validate all -validatecommand {single_letter %P} -font Helv_8  -borderwidth 1 -bg #fbfaff  -foreground #4e85f4 -textvariable ::plugins::keyboard_control::settings(water_key) -relief flat  -highlightthickness 1 -highlightcolor #000000

   # Flush Key Setting
    add_de1_text $page_name 280 1020 -text [translate "Flush Key"] -font Helv_8 -width 300 -fill "#444444" -anchor "nw" -justify "center"
    add_de1_widget "$page_name" entry 280 1080  {
        set ::globals(widget_profile_name_to_save) $widget
        bind $widget <Return> { say [translate {save}] $::settings(sound_button_in); borg toast [translate "Saved"]; kbc_convert_key_and_save "HotWaterRinse"; hide_android_keyboard}
        bind $widget <Leave> hide_android_keyboard
    } -width [expr {int(2 * $::globals(entry_length_multiplier))}] -validate all -validatecommand {single_letter %P} -font Helv_8  -borderwidth 1 -bg #fbfaff  -foreground #4e85f4 -textvariable ::plugins::keyboard_control::settings(flush_key) -relief flat  -highlightthickness 1 -highlightcolor #000000

    return $page_name
}

proc kbc_keycode_to_cmd {keycode} {
    if {$::some_droid != 1} {
        if {$keycode == $::plugins::keyboard_control::settings(espresso_keycode)} {
            return "Espresso"
        } elseif {$keycode == $::plugins::keyboard_control::settings(steam_keycode)} {
            return "Steam"
        } elseif {$keycode == $::plugins::keyboard_control::settings(water_keycode)} {
            return "HotWater"
        } elseif {$keycode == $::plugins::keyboard_control::settings(flush_keycode)} {
            return "HotWaterRinse"
        }
    } elseif {$::some_droid == 1} {
        if {$keycode == $::plugins::keyboard_control::settings(espresso_droid_keycode)} {
            return "Espresso"
        } elseif {$keycode == $::plugins::keyboard_control::settings(steam_droid_keycode)} {
            return "Steam"
        } elseif {$keycode == $::plugins::keyboard_control::settings(water_droid_keycode)} {
            return "HotWater"
        } elseif {$keycode == $::plugins::keyboard_control::settings(flush_droid_keycode)} {
            return "HotWaterRinse"
        }
    }
    return -1
}

proc kbc_handle_keypress {keycode} {
	msg "Keypress detected: $keycode / $::some_droid"
    set textstate $::de1_num_state($::de1(state))
    set kbc_cmd [kbc_keycode_to_cmd $keycode]

    if {$textstate == "Idle"} {
        if {$kbc_cmd == "Espresso"} {
            borg toast [translate "Starting espresso"]
            start_espresso
        } elseif {$kbc_cmd == "Steam"} {
            borg toast [translate "Starting steam"]
            start_steam
        } elseif {$kbc_cmd == "HotWater"} {
            borg toast [translate "Starting hot water"]
            start_water
        } elseif {$kbc_cmd == "HotWaterRinse"} {
            borg toast [translate "Starting flush"]
            start_flush
        }
    } elseif {$textstate == "Espresso"} {
        if {($kbc_cmd == "Espresso") || ($kbc_cmd == "Steam")} {
            # stop espresso
            borg toast [translate "Stopping espresso"]
            start_idle
        } elseif {($kbc_cmd == "HotWater") || ($kbc_cmd == "HotWaterRinse")} {
            # next_espresso_step not yet implemented
            # borg toast [translate "Next espresso step"]
            # next_espresso_step
            borg toast [translate "Stopping espresso"]
            start_idle
        }
    } elseif {$textstate == "Steam"} {
        if {($kbc_cmd == "Espresso") || ($kbc_cmd == "Steam") || ($kbc_cmd == "HotWater") || ($kbc_cmd == "HotWaterRinse")} {
            # stop steam
            borg toast [translate "Stopping steam"]
            start_idle
        }
    } elseif {$textstate == "HotWater"} {
        if {($kbc_cmd == "Espresso") || ($kbc_cmd == "Steam") || ($kbc_cmd == "HotWater") || ($kbc_cmd == "HotWaterRinse")} {
            # stop water
            borg toast [translate "Stopping hot water"]
            start_idle
        }
    } elseif {$textstate == "HotWaterRinse"} {
        if {($kbc_cmd == "Espresso") || ($kbc_cmd == "Steam") || ($kbc_cmd == "HotWater") || ($kbc_cmd == "HotWaterRinse")} {
            # stop flush
            borg toast [translate "Stopping flush"]
            start_idle
        }
    }
}

proc ::plugins::${plugin_name}::main {} {
    msg "keyboard_control plugin enabled"
    focus .can
    bind Canvas <KeyPress> {kbc_handle_keypress %k}
}