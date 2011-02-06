package Hiredis::Async;
use strict;
use warnings;

sub new {
    my ($class, @connect_args) = @_;
    my $self = bless {}, $class;
    $self->Connect(@connect_args);
    return $self;
}

sub DESTROY {
    my $self = shift;
    $self->Free;
}

1;
