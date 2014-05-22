use 5.010_001;
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'PriorityEyes',
  VERSION_FROM => 'lib/PriorityEyes.pm',
  ABSTRACT     => 'Project management',
  AUTHOR       => 'Nic Sandfield <niczero@cpan.org>',
  LICENSE      => 'artistic_2',
  META_MERGE   => {
    requires  => {perl => 5.010001},
    resources => {
      homepage    => 'http://niczero.github.com/priorityeyes',
      license     => 'http://www.opensource.org/licenses/artistic-license-2.0',
      repository  => 'http://github.com/niczero/priorityeyes',
      bugtracker  => 'http://github.com/niczero/priorityeyes/issues'
    },
    no_index => {directory => [qw(cfg data test)]}
  },
  BUILD_REQUIRES => {'Test::More' => 0},
  CONFIGURE_REQUIRES => {'ExtUtils::MakeMaker' => '6.30'},
  PREREQ_PM => {
    Mojolicious => '5.00',
    Mojar => 2.001,
    Mojar::Cron => 0.121,
    Minion => 0.09
  },
  EXE_FILES => [],
  test => {TESTS => 'test/*.t'}
);
