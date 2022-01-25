use base "installedtest";
use strict;
use testapi;
use utils;

# This part tests if the application can show the image gallery.

sub run {
    my $self = shift;
    sleep 2;

    # Show the image gallery.
    send_key("ctrl-f9");
    unless (check_screen("eog_gallery_shown")) {
        record_soft_failure("Key combo does not work, issue https://gitlab.gnome.org/GNOME/gtk/-/issues/4171");
        # Open the menu
        send_key("gnome_burger_menu");
        # Open Submenu Show
        assert_and_click("eog_submenu_show");
        # Toggle gallery
        assert_and_click("eog_gallery_show");
        
    }
    assert_screen("eog_gallery_shown");
}

sub test_flags {
    return {always_rollback => 1};
}

1;

# vim: set sw=4 et:
