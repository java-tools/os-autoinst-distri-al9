use base "installedtest";
use strict;
use testapi;
use utils;

# This part tests that About can be displayed.

sub run {
    my $self = shift;
    # Open the menu.
    send_key("f10");

    # Choose the About item.
    assert_and_click "gedit_about";

    # Check that the About dialogue was opened.
    assert_screen "gedit_about_shown";

    # Click on Credits to move to another screen.
    assert_and_click "gedit_about_credits";

    # Check that Credits were shown.
    assert_screen "gedit_credits_shown";
}

sub test_flags {
    return { always_rollback => 1 };
}

1;

# vim: set sw=4 et:
