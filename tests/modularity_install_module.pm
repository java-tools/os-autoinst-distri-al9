use base "installedtest";
use strict;
use testapi;
use utils;
sub run {
    my $self=shift;
    # switch to tty and login as root
    $self->root_console(tty=>3);

    # Download the testing script
    download_modularity_tests();

    # Check that modularity works and that a particular module is available in the system.
    assert_script_run('/root/test.py -m nodejs -s 12 -a list');

    # Check that module can be enabled and removed.
    assert_script_run('/root/test.py -m nodejs -s 12 -p default -a install,remove,reset -f hard', 120);
    
    # Upload modular logs
    upload_logs '/root/modular.log', failok=>1;
}

1;

# vim: set sw=4 et:
