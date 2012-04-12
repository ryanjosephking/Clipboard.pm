package Clipboard::Xclip;
use Spiffy -Base;
sub copy {
    my $cmd = '|xclip -i -selection '. $self->favorite_selection;
    open my $exe, $cmd or die "Couldn't run $cmd: $!\n";
    print $exe $_[0];
}
sub paste {
    for ($self->all_selections) {
        my $cmd = "xclip -o -selection $_|";
        open my $exe, $cmd or die "Couldn't run $cmd: $!\n";
        my $data = join '', <$exe>;
        return $data if $data !~ /^(?:\n|)$/m;
    }
    undef
}
# This ordering isn't officially verified, but so far seems to work the best:
sub all_selections { qw(primary buffer clipboard secondary) }
sub favorite_selection { ($self->all_selections)[0] }
{
  open my $just_checking, 'xclip -o|' or die <<EPIGRAPH;

Can't find the 'xclip' script.  Clipboard.pm's X support depends on it.

Here's the project homepage: http://freshmeat.net/projects/xclip

EPIGRAPH
}
