use base "installedtest";
use strict;
use testapi;
use utils;

# This part tests if the application can put an image as a wallpaper.

sub run {
    my $self = shift;
    sleep 2;

    # Go to the menu
    assert_and_click("gnome_burger_menu");
    # Set as background
    assert_and_click("eog_set_wallpaper");
    # Confirm
    send_key("tab");
    send_key("ret");
    # Close the application
    send_key("ctrl-q");
    # Check that the wallpaper was set
    assert_screen("eog_image_background");

}

sub test_flags {
    return {always_rollback => 1};
}

1;

# vim: set sw=4 et:
