use base "installedtest";
use strict;
use testapi;
use utils;

# This part tests that a piece of test can be found, that highlighting can be removed again,
# that search and replace can be used, that misspelt words can be highlighted, and
# that spelling control can be used to find and replace spelling mistakes.

sub run {
    my $self = shift;
    # Search the text for specific string.
    # At first, Wait 1 second for the test to get ready, as the control character was not properly recognized
    # when the test started immediately after the rollback.
    sleep 1;
    # Invoke the Find dialogue
    send_key "ctrl-f";
    # Type string
    type_safely "sweetest";
    # Confirm
    send_key "ret";
    # The found item is blue at first and after any action it changes to yellow. Let's move the cursor to 
    # change it into yellow for better assertion.
    send_key "left";
    # Check that correct word is highlighted.
    assert_screen "gedit_found_text";
    
    # This tests that a highlight can be removed from a search result.
    # Use combo for removing the highlighting.
    send_key("shift-ctrl-k");
    # Move cursor out of text.
    send_key "ctrl-end";
    # Check that the highlighting was removed.
    assert_screen "gedit_text_added";
    
    # We will continue to search and replace a piece of text.
    # Open Switch and replace
    send_key "ctrl-h";
    # Type string.
    type_safely "Gale";
    # And click to replace it.
    assert_and_click "gedit_replace_nothing";
    # Type replacement string. We purposefully produce a typo.
    type_safely "Wiend"; 
    # Click to find the string
    assert_and_click "gedit_find";
    # and replace it.
    assert_and_click "gedit_replace";
    # Get rid of the screen.
    send_key("esc");
    # Check that the string was replaced.
    assert_screen "gedit_text_replaced";

    # Now, let us try highlighting the misspelt words.
    # Go to Menu
    send_key("f10");
    # Go to Tools submenu
    assert_and_click "gedit_submenu_tools";
    # Click to make typos highlighted
    assert_and_click "gedit_highlight_misspelt";
    # Use Esc to clear the dialogue
    send_key "esc";
    # Check that the word has been highlighted.
    assert_and_click "gedit_spelling_highlighted";

    # Check spelling and use a suggestion to correct the text
    # Go to Menu
    send_key("shift-f7");
    # Choose a suitable suggestion
    assert_and_click "gedit_spelling_suggestion";
    # Correct the text.
    assert_and_click "gedit_spelling_change";
    # Clear the dialogue.
    send_key "esc";
    # Check that the typo has been corrected.
    assert_and_click "gedit_spelling_changed";
}

sub test_flags {
    return { always_rollback => 1 };
}

1;

# vim: set sw=4 et:
