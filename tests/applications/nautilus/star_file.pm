use base "installedtest";
use strict;
use testapi;
use utils;

# Star a file and check it is displayed in the Starred folder.

sub run {
    my $self = shift;
    
    #  Enter the Documents directory to get to the test data. 
    assert_and_dclick("nautilus_directory_documents");
    
    #  Right click onto a file to select it to see the
    #  context menu.
    assert_and_click("nautilus_test_file", button => "right");
    wait_still_screen(2);
    
    # Click to Star it.
    assert_and_click("nautilus_context_star");
    
    # Check that a star gets solid on the right part of the selected file
    assert_screen("nautilus_star_confirm");
    
    # Click on Starred to see all the starred files in a new view.
    assert_and_click("nautilus_directory_starred");
    wait_still_screen(2);
    
    # Check that the view switched to Starred
    assert_screen("nautilus_starred_selected");
    
    # Check that the file has appeared.
    assert_screen("nautilus_test_file");
}

sub test_flags {
    # Rollback to the previous state to make space for other parts.
    return {always_rollback => 1};
}

1;



