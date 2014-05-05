use strict;
use warnings;

my $file = shift;
die "Usage: $0 FILE" unless defined $file;
open my $fh, '<', $file
or die qq{Can't open file: "$file": $!};

# 複数のパケット情報を格納するための配列のリファリンス
my $packet_infos = [];

# パケット情報を格納するためのハッシュのリファレンス
my $packet_info;

#各行の処理
while (my $line = <$fh>){
	chomp $line;　#改行の削除

#行ごとに場合分け
if ($line =~ /^(\d{2}:\d{2}:\d{2})/){
#パケット情報の初期化
	$packet_info = {};
#時刻
	$packet_info->{time} = $1;
	}
elsif ($line =~ /^packet: (\d+)/){
#パケット数	
	$packet_info->{packet} = $1;
	}
elsif ($line =~ /^loss: (\d+)/){
#ロス数	
	$packet_info->{loss} = $1;
push @$packet_infos, $packet_info;
	}
}
close $fh;

my @headers = qw/time packet loss/;
print join("\t",@headers) . "\n";

foreach my $packet_info (@$packet_infos){

my @rec = (
	$packet_info->{time},
	$packet_info->{packet},
	$packet_info->{loss}
	);

	print join("\t", @rec) . "\n";
}
