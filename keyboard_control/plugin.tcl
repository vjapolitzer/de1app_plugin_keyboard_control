package require de1_machine

set plugin_name "keyboard_control"

set ::plugins::${plugin_name}::author "Vincent Politzer"
set ::plugins::${plugin_name}::contact "redfoxdude@gmail.com"
set ::plugins::${plugin_name}::version 1.0
set ::plugins::${plugin_name}::description "Control your non-GHC DE1 with a keyboard"

proc kbc_keycode_to_cmd {keycode} {
    if {($::some_droid != 1 && $keycode == 101) || ($::some_droid == 1 && $keycode == 8)} {
        # e
        return 0
    } elseif {($::some_droid != 1 && $keycode == 115) || ($::some_droid == 1 && $keycode == 22)} {
        # s
        return 1
    } elseif {($::some_droid != 1 && $keycode == 119) || ($::some_droid == 1 && $keycode == 26)} {
        # w
        return 2
    } elseif {($::some_droid != 1 && $keycode == 102) || ($::some_droid == 1 && $keycode == 9)} {
        # f
        return 3
    }
    return -1
}

proc kbc_handle_keypress {keycode} {
	msg "Keypress detected: $keycode / $::some_droid"
    set textstate $::de1_num_state($::de1(state))
    set kbc_cmd [kbc_keycode_to_cmd $keycode]

    if {$textstate == "Idle"} {
        if {$kbc_cmd == 0} {
            borg toast [translate "Starting espresso"]
            start_espresso
        } elseif {$kbc_cmd == 1} {
            borg toast [translate "Starting steam"]
            start_steam
        } elseif {$kbc_cmd == 2} {
            borg toast [translate "Starting hot water"]
            start_water
        } elseif {$kbc_cmd == 3} {
            borg toast [translate "Starting flush"]
            start_flush
        }
    } elseif {$textstate == "Espresso"} {
        if {($kbc_cmd == 0) || ($kbc_cmd == 1)} {
            # stop espresso
            borg toast [translate "Stopping espresso"]
            start_idle
        } elseif {($kbc_cmd == 2) || ($kbc_cmd == 3)} {
            # next_espresso_step not yet implemented
            # borg toast [translate "Next espresso step"]
            # next_espresso_step
            borg toast [translate "Stopping espresso"]
            start_idle
        }
    } elseif {$textstate == "Steam"} {
        if {($kbc_cmd == 0) || ($kbc_cmd == 1) || ($kbc_cmd == 2) || ($kbc_cmd == 3)} {
            # stop steam
            borg toast [translate "Stopping steam"]
            start_idle
        }
    } elseif {$textstate == "HotWater"} {
        if {($kbc_cmd == 0) || ($kbc_cmd == 1) || ($kbc_cmd == 2) || ($kbc_cmd == 3)} {
            # stop water
            borg toast [translate "Stopping hot water"]
            start_idle
        }
    } elseif {$textstate == "HotWaterRinse"} {
        if {($kbc_cmd == 0) || ($kbc_cmd == 1) || ($kbc_cmd == 2) || ($kbc_cmd == 3)} {
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