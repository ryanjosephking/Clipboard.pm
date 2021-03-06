use inc::Module::Install;
name('Clipboard');
author('Ryan King <rking@panoptic.com');
abstract('Cliboard - Copy and Paste with any OS');
license('perl');
version_from('lib/Clipboard.pm');
requires(qw(Spiffy 0));
# This conditional requires is kind of wacky. It works from the command-line
# "perl Makefile.PL" invocation just fine, but I am afeard that there's some
# automated script out there that won't like it - cpan/cpanp?  We'll find out.
requires('Win32::Clipboard') if $^O =~ /^win|cygwin/i;
install_script(map { "scripts/clip$_" } qw'join edit browse accumulate');
check_nmake();
WriteAll();
