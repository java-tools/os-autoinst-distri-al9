use base "installedtest";
use strict;
use testapi;
use utils;

# This part of the suite prepares downloads the test data and sets up the environment.

sub run {
    my $self = shift;
    
    # Go to the root console to set up the test data and necessary stuff.
    $self->root_console(tty=>3);

    # Get the test data from the test data repository.
    check_and_install_git();
    download_testdata("gedit", "Documents");
    # Return to Desktop
    desktop_vt();

    # Start the application
    menu_launch_type("gedit");
    # Check that it started
    assert_screen("apps_run_texteditor");

    # Open the test file
    send_key("ctrl-o");

    # Open the documents location
    assert_and_click("gnome_open_location_documents");

    # Choose the file
    assert_and_click("gedit_txt_file");

    # Open it
    send_key("ret");
    
    # Make the application fullscreen
    send_key("super-up");

    # Check that the document has been opened
    assert_screen("gedit_text_file_opened");
}

sub test_flags {
    return { fatal => 1, milestone => 1 };
}

1;

# vim: set sw=4 et:
