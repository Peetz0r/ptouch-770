#!/usr/bin/perl -w
use strict;
use autodie;
use File::Temp qw(tempfile);

my $usb_id = 0;

my @bitmaps;

while (@ARGV) {
    my ($fh, $fn) = tempfile;

    my $data = shift;

    open my $pipe_zint, "-|", qw[zint --barcode 20 --notext --height 50 --scale 0.5 --direct --data], $data;
    open my $pipe_convert, "|-", qw[convert mch-logo-12mm.png PNG:- +append +antialias -gravity center -font DejaVu-Sans-Mono-Bold -pointsize 20], "label:$data", qw[-append -gravity west -extent x128 pbm:], "pbm:$fn";
    local $/ = \8192;
    print $pipe_convert $_ while defined($_ = readline $pipe_zint);
    close $pipe_convert;

    push @bitmaps, $fn;
}

#system file => @bitmaps;
#system qiv => @bitmaps;
system "ptouch-770-old/ptouch-770-write", $usb_id, @bitmaps;

unlink @bitmaps;
