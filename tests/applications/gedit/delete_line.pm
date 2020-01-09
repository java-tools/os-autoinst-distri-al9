use base "installedtest";
use strict;
use testapi;
use utils;

# This part tests that a line of text can be deleted 
# and the deletion reverted.

sub run {
    my $self = shift;
    #  Click on a word on the line.
    assert_and_click "gedit_line_word";
    # Delete the line
    send_key("ctrl-d");
    # Move cursor out of the way.
    send_key("ctrl-end");
    # Check that the line was deleted.
    assert_screen "gedit_line_deleted";

    # Use combo to revert the action.
    send_key "ctrl-z";
    # Move cursor out of the way.
    send_key "ctrl-end";
    # Check that the line was re-added.
    assert_screen "gedit_text_added";
}

sub test_flags {
    return { always_rollback => 1 };
}

1;

# vim: set sw=4 et:
