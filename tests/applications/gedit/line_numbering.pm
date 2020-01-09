use base "installedtest";
use strict;
use testapi;
use utils;

# This part tests that we can do line numbering,
# line navigation, line highlighting and show side and bottom panels.

sub run {
    my $self = shift;
    
    # Switches on line numbering.
    assert_and_click "gedit_line_options";
    assert_and_click "gedit_display_linenumbers";
    send_key "esc";
    # By default the lines are numbered, so we need to check 
    # that now they are not.
    assert_screen "gedit_lines_not_numbered";

    # Uses the menu to go to a specific line.
    send_key("ctrl-i");
    type_safely "8\n";
    assert_screen "gedit_line_reached";

    # Highlights the current line.
    assert_and_click "gedit_line_options";
    assert_and_click "gedit_highlight_current";
    send_key "esc";
    # By default, the lines are highlighted so we check
    # that they are not highlighted at the moment.
    assert_screen "gedit_line_not_highlighted";

    # Displays the right margin.
    assert_and_click "gedit_line_options";
    assert_and_click "gedit_display_margin";
    send_key "esc";
    assert_screen "gedit_margin_displayed";

    # Display the side panel.
    send_key("f9");
    assert_screen "gedit_side_on";

    # Display the bottom panel.
    # Currently the bottom panel does not work 
    # when invoked with the key combination. 
    # Issuse reported as https://gitlab.gnome.org/GNOME/gedit/-/issues/456
    # So if this fails, we only softfail here.
    send_key("ctrl-f9");
    unless (check_screen("gedit_bottompanel_on")) {
        record_soft_failure("Issue 456: https://gitlab.gnome.org/GNOME/gedit/-/issues/456");
    }
}


sub test_flags {
    return { always_rollback => 1 };
}

1;

# vim: set sw=4 et:
