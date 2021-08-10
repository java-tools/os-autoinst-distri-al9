use base "installedtest";
use strict;
use testapi;
use utils;

# This part tests if EoG can show the About window.

sub run {
    my $self = shift;
    
    # Open the menu
    send_key("f10");
    # Click on the About item
    assert_and_click("eog_menu_about");
    assert_screen("eog_about_shown");
    # Click on Credits
    assert_and_click("eog_about_credits");
    assert_screen("eog_credits_shown");
}

sub test_flags {
    return {always_rollback => 1};
}

1;

# vim: set sw=4 et:
