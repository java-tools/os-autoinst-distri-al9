use base "installedtest";
use strict;
use testapi;
use utils;

sub run {

    my $self = shift;
    $self->root_console(tty => 3);

    # list available branches
    assert_script_run "ostree remote refs fedora-iot";

    # check arch
    my $arch = lc(get_var("ARCH"));

    # set default for rawhide or devel
    my $rebase = "stable";

    # if testing the current release, rebase to devel
    unless (script_run "rpm-ostree status -b | grep stable") {
        $rebase = "devel";
    }

    # FIXME special cases for read-only transition from 36 to 37
    # we can drop these (revert the whole relevant commit) once
    # 37 is stable
    my $orig;
    if (get_var("CURRREL") eq "36") {
        if (get_var("VERSION") eq "37") {
            # rebase to rawhide
            $rebase = "rawhide";
            $orig = "devel";
        }
        elsif (get_var("VERSION") eq "38") {
            # rebase to devel
            $rebase = "devel";
            $orig = "rawhide";
        }
    }
    # rebase to the appropriate release, arch
    validate_script_output "rpm-ostree rebase fedora/${rebase}/${arch}/iot", sub { m/systemctl reboot/ }, 300;
    script_run "systemctl reboot", 0;

    boot_to_login_screen;
    $self->root_console(tty => 3);

    # check booted branch to make sure successful rebase
    validate_script_output "rpm-ostree status -b", sub { m/$rebase/ }, 300;

    # rollback and reboot
    validate_script_output "rpm-ostree rollback", sub { m/systemctl reboot/ }, 300;
    script_run "systemctl reboot", 0;

    boot_to_login_screen;
    $self->root_console(tty => 3);

    # check to make sure rollback successful, also account for branched (devel)
    if ($orig) {
        validate_script_output "rpm-ostree status -b", sub { m/$orig/ }, 300;
    }
    elsif ($rebase eq "devel") {
        validate_script_output "rpm-ostree status -b", sub { m/stable/ }, 300;
    }
    elsif ($rebase eq "stable") {
        validate_script_output "rpm-ostree status -b", sub { m/rawhide|devel/ }, 300;
    }
}

sub test_flags {
    return {fatal => 1};
}

1;

# vim: set sw=4 et:
