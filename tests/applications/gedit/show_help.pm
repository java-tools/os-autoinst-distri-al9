use base "installedtest";
use strict;
use testapi;
use utils;

# This part tests that Help can be shown.

sub run {
    my $self = shift;
    
    # Open Help.
    send_key("f1");
    assert_screen "gedit_help_shown";

    # Navigate through several screens
    assert_and_click "gedit_help_files";
    assert_and_click "gedit_help_bread_main";
    # Another screen
    assert_and_click "gedit_help_search";
    assert_and_click "gedit_help_bread_main";
    # Move in the text
    send_key "pgdn";
    # Another screen
    assert_and_click "gedit_help_color_schemes";
    assert_screen "gedit_help_color_shown";
}


sub test_flags {
    return { always_rollback => 1 };
}

1;

# vim: set sw=4 et:
