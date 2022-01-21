use base "installedtest";
use strict;
use testapi;
use utils;

sub run {
    my $self = shift;
    # Prepare the environment for the test.
    #
    # Some actions need a root account, so become root.
    $self->root_console(tty=>3);

    # Create a text file, put content to it to prepare it for later printing.
    script_run  "cd /home/test/";
    assert_script_run  "echo 'A quick brown fox jumps over a lazy dog.' > testfile.txt";
    # Make the file readable and for everybody.
    script_run "chmod 666 testfile.txt";
    # Install the Cups-PDF package to use the Cups-PDF printer
    assert_script_run "dnf -y install cups-pdf", 180;

    # Here, we were doing a version logic. This is no longer needed, because
    # we now use a different approach to getting the resulting file name:
    # We will list the directory where the printed file is put and we will
    # take the file name that will be returned. To make it work, the directory
    # must be empty, which it normally is, but to make sure let's delete everything.
    script_run("rm /home/test/Desktop/*");
    # Verification commands need serial console to be writable and readable for
    # normal users, let's make it writable then.
    script_run("chmod 666 /dev/ttyS0");
    # Leave the root terminal and switch back to desktop for the rest of the test.
    desktop_vt();

    my $desktop = get_var("DESKTOP");
    # Set up some variables to make the test compatible with different desktops.
    # Defaults are for the Gnome desktop.
    my $version = get_var("VERSION");
    # FIXME: When we entirely move to version 36 with all the tests
    # we will get rid of gedit (which ceased to exist on 36).
    my $editor = "gnome-text-editor";
    if ($version <= 35 and $version ne "Rawhide") {
        $editor = "gedit";
    }
    my $viewer = "evince";
    my $maximize = "super-up";
    my $term = "gnome-terminal";
    if ($desktop eq "kde") {
        $editor = "kwrite";
        $viewer = "okular";
        $maximize = "super-pgup";
        $term = "konsole";
    }

    # Let's open the terminal. We will use it to start the applications 
    # as well as to check for the name of the printed file.
    menu_launch_type($term);
    wait_still_screen(2);

    # Open the text editor and print the file.
    type_very_safely "$editor /home/test/testfile.txt &\n";
    wait_still_screen(stilltime=>3, similarity_level=>45);
    # Print the file using the Cups-PDF printer
    send_key "ctrl-p";
    wait_still_screen(stilltime=>3, similarity_level=>45);
    # In Gnome, we need to select the Cups-PDF printer first
    if ($desktop eq 'gnome') {
        assert_and_click "printing_select_pdfprinter";
    }
    else {
        # It seems that on newly installed KDE systems with no
        # printer,  the Cups-PDF printer is already pre-selected.
        # We only check that it is correct.
        assert_screen "printing_pdfprinter_ready";
    }
    assert_and_click "printing_print";
    # Exit the application
    send_key "alt-f4";
    wait_still_screen(stilltime=>3, similarity_level=>45);
    # The CLI might be blocked by some application output. Pressing the
    # Enter key will dismiss them and return the CLI to the ready status.
    send_key("ret");

    # Get the name of the printed file. Both Gnome and KDE place 
    # that file in the /home/$user/Desktop directory.
    my $filename = script_output("ls /home/test/Desktop/");
    # Echo that filename to the terminal for troubleshooting purposes
    diag("The filename of the printed out file is: $filename");

    # Open the pdf file in a Document readier and check that it is correctly printed.
    type_safely("$viewer /home/test/Desktop/$filename &\n");
    wait_still_screen(stilltime=>3, similarity_level=>45);
    # Resize the window, so that the size of the document fits the bigger space
    # and gets more readable.
    send_key $maximize;
    wait_still_screen(stilltime=>2, similarity_level=>45);
    # in KDE, make sure we're at the start of the document
    send_key "ctrl-home" if ($desktop eq "kde");
    # Check the printed pdf.
    assert_screen "printing_check_sentence";
}


sub test_flags {
    return { fatal => 1 };
}

1;

# vim: set sw=4 et:
