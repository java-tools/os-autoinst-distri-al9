use base "installedtest";
use strict;
use testapi;
use utils;

# This part tests that Shortcuts can be shown.

sub run {
    my $self = shift;
    
    # Open Shortcuts.
    send_key("ctrl-?");

    # Assert the screen and move to next one
    assert_screen "gedit_shortcuts_one";
    assert_and_click "gedit_shortcuts_go_two";

    # Assert the screen and move to next one
    assert_screen "gedit_shortcuts_two";
    assert_and_click "gedit_shortcuts_go_three";

    # Assert the screen and move to next one
    assert_screen "gedit_shortcuts_three";
    assert_and_click "gedit_shortcuts_go_four";

    # Assert the screen and move to next one
    assert_screen "gedit_shortcuts_four";
}


sub test_flags {
    return { always_rollback => 1 };
}

1;

# vim: set sw=4 et:
