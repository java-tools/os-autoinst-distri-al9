use base "installedtest";
use strict;
use testapi;
use utils;

# This part tests that we can create a new file that
# opens in a new panel, that we can add text, display
# text statistics and highlight code and save the file.

sub run {
    my $self = shift;
    
    # First we will use key combo to open the new document window.
    sleep 2;
    send_key("ctrl-t");
    assert_screen "gedit_new_document_opened";

    # Now let us produce some text
    type_safely "# My shopping list.\n\n";
    type_safely "* Milk\n* Apples\n* Bananas\n* Bread\n* Butter\n* Cheese\n\n";
    type_safely "Happy shopping.";
    
    # Display text stats
    send_key("f10");
    assert_and_click "gedit_submenu_tools";
    assert_and_click "gedit_tools_stats";
    assert_screen "gedit_stats_shown";
    send_key "esc";
    # Floating windows do not return focus to the text field, tab does.
    send_key "tab";

    # Switch on Markdown Highlighting.
    assert_and_click "gedit_select_highlighting";
    type_very_safely "markdown";
    send_key "ret";
    assert_screen "gedit_code_highlighted";

    # Save the newly created file.
    send_key("ctrl-s");
    type_very_safely "list.md";
    send_key("ret");
    # Check that the file has been created
    $self->root_console(tty=>3);
    assert_script_run "ls /home/test/Documents/list.md";
}


sub test_flags {
    return { always_rollback => 1 };
}

1;

# vim: set sw=4 et:
