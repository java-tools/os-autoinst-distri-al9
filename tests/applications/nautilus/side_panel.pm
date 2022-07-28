use base "installedtest";
use strict;
use testapi;
use utils;

# Toggle and untoggle the side panel.

sub run {
    my $self = shift;

    # It seems that the following checks run so quickly that the tested
    # virtual machine is unable to properly reload from the previous test
    # and it keeps failing.
    # Let's give it some time to settle.
    sleep(5);

    my $side_panel = 0;
    if (check_screen("nautilus_side_panel")) {
        $side_panel = 1;
    }

    # Switch off the side panel
    send_key("f9");
    wait_still_screen(2);

    # Recheck if side panel is visible
    my $off_panel = 0;
    if (check_screen("nautilus_side_panel")) {
        $off_panel = 1;
    }

    # Compare the results, they should be different.
    if ($off_panel == $side_panel) {
        die("The side panel visibility should have been toggled and it is not. That indicates that the keyboard shortcut to toggle it does not work properly.");
    }

    # Use menu to toggle the side panel back.
    assert_and_click("gnome_burger_menu");
    wait_still_screen(2);
    assert_and_click("nautilus_show_sidebar");
    wait_still_screen(2);

    # Recheck if side panel is visible
    if (check_screen("nautilus_side_panel")) {
        $off_panel = 1;
    }

    # Compare the results. If everything has been ok until now, the values should not be different.
    if ($off_panel != $side_panel) {
        die("The side panel visibility should have been toggled back, but it has not been. That indicates that the menu item to toggle it does not work properly.");
    }

}

sub test_flags {
    # Rollback to the previous state to make space for other parts.
    return {always_rollback => 1};
}

1;


