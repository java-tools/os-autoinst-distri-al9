use base "installedtest";
use strict;
use testapi;
use utils;

# I as a user want to be able use the menu to enter further functions.

sub run {
    my $self = shift;

    # Click on the burger menu.
    assert_and_click("gnome_burger_menu");

    # Click on About Clocks to see the About info.
    assert_and_click("clocks_menu_about");
    assert_screen("clocks_about_displayed");
    assert_and_click("gnome_button_credits");
    assert_screen("clocks_credits_shown");
    send_key("esc");

    # Use the menu to see the shortcuts
    assert_and_click("gnome_burger_menu");
    assert_and_click("clocks_menu_shortcuts");
    assert_screen("clocks_shortcuts_shown");
    send_key("esc");

    # Use the menu to see the Help
    assert_and_click("gnome_burger_menu");
    assert_and_click("clocks_menu_help");
    assert_screen("clocks_help_shown");
}

sub test_flags {
    # Rollback after test is over.
    return {always_rollback => 1};
}

1;

# vim: set sw=4 et:
