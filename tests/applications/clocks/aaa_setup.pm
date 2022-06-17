use base "installedtest";
use strict;
use testapi;
use utils;

# This script will start the Gnome Clocks application and save the status
# for any subsequent tests.

sub run {
    my $self = shift;

    # At first, we need to set time and time zones manually. 
    $self->root_console(tty=>3);
    # Switch off automatic time.
    assert_script_run("timedatectl set-ntp 0");
    # Set the time zone
    assert_script_run("timedatectl set-timezone Europe/Prague");
    # Set the time and date
    assert_script_run("timedatectl set-time '2022-09-09 09:00:00'");
    # Return back
    desktop_vt();

    # Start the Application
    menu_launch_type("clocks");
    wait_still_screen(2);
    # Make it fill the entire window.
    send_key("super-up");
    wait_still_screen(2);
}

sub test_flags {
    # If this test fails, there is no need to continue.
    return {fatal => 1, milestone => 1};
}

1;

# vim: set sw=4 et:
