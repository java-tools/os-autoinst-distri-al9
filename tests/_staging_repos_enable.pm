use base "installedtest";
use strict;
use testapi;
use utils;

sub run {
    my $self = shift;
    $self->root_console(tty=>4);
    # Point at staging repositories by modifying contentdir
    if (get_version_major() < 9) {
        script_run "sed -i 's/^mirrorlist/#mirrorlist/g' /etc/yum.repos.d/AlmaLinux-*";
        script_run "sed -i 's,^#\(baseurl=http[s]*://\),\1,g' /etc/yum.repos.d/AlmaLinux-*";
    } else {
      script_run "sed -i 's/^mirrorlist/#mirrorlist/g' /etc/yum.repos.d/almalinux*";
      script_run "sed -i 's,^#\(baseurl=http[s]*://\),\1,g' /etc/yum.repos.d/almalinux*";
    }
    script_run 'printf "stg/almalinux\n" > /etc/dnf/vars/contentdir';
    script_run 'dnf clean all';
    script_run 'dnf repoinfo';
}

sub test_flags {
    return { fatal => 1 };
}

1;

# vim: set sw=4 et:
