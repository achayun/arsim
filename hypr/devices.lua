-- Configuration for `hyprctl devices` - https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/


-- REALFORCE R2TLS-JP4-BK / 91-key Japanese JIS layout

hl.device({
    name = "topre-realforce-91-jp",
    kb_layout = "jp",
    kb_model = "jp106",
    kb_variant = "",
    kb_options = "",
    kb_rules = "",
})

hl.device({
    name = "topre-realforce-91-jp-keyboard",
    kb_layout = "jp",
    kb_model = "jp106",
    kb_variant = "",
    kb_options = "",
    kb_rules = "",
})

hl.device({
    name = "topre-realforce-91-jp-consumer-control",
    kb_layout = "jp",
    kb_model = "jp106",
    kb_variant = "",
    kb_options = "",
    kb_rules = "",
})

-- HHKB Lite 2
-- ## Remap Muhenkan to SUPER.
-- Make sure to:
-- mkdir -p ~/.config/xkb/{symbols,rules}
-- cat > "~/.config/xkb/symbols/hhkb" << 'EOF'
-- default partial modifier_keys
-- xkb_symbols "muhenkan_super" {
--     replace key <TLDE> {
--         type[Group1] = "ONE_LEVEL",
--         symbols[Group1] = [ Super_L ]
--     };
--     modifier_map Mod4 { <TLDE> };
-- };
-- EOF
-- Add to ~/.config/xkb/rules/evdev
-- ! include %S/evdev
-- ! option = symbols
--   hhkb:muhenkan_super = +hhkb(muhenkan_super)
-- Check the mapping with:
-- xkbcli compile-keymap \
--     --rules evdev \
--     --model jp100 \
--     --layout jp \
--     --options hhkb:muhenkan_super |
--     grep -A4 'key <TLDE>'
hl.device({
    name = "chicony-pfu-68-usb-keyboard",
    kb_layout = "jp",
    kb_model = "jp100",
    kb_variant = "",
    kb_options = "hhkb:muhenkan_super",
    kb_rules = "",
})
