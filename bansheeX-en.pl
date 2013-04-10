#!/usr/bin/perl -w

# BansheeX - Simple script for using Banshee in Xchat
# Copyright (C) 2013  Auze <twitter: @Auze_>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

use strict;
use Xchat qw( :all);

# Register plugin in Xchat
register('BansheeX', '0.5', 'Simple Script for using Banshee in Xchat');

# Welcome Message
command("echo ###########");
command("echo BansheeX Script 0.5");
command("echo Simple Script for using Banshee in Xchat");
command("echo Author : Auze @ Absylonia");
command("echo /bhelp for help");
command("echo ###########");

# Command list and function
hook_command('bcur', \&bcur);
hook_command('bplay',\&bplay);
hook_command('bpause',\&bpause);
hook_command('bnext', \&bnext);
hook_command('bvers',\&bvers);
hook_command('bprev',\&bprev);
hook_command('brate',\&brate);
hook_command('babout',\&babout);
hook_command('btest',\&btest);
hook_command('bhelp', \&help);
 
 # Display current track if running
sub bcur {
	
	my $run = &btest();
	
	if ($run == 0) {
	
		my $rawtitle = substr(`banshee --query-title`, 7);
		my $title = substr($rawtitle,0, length($rawtitle) -1);
		
		my $rawartist = substr(`banshee --query-artist`, 8);
		my $artist = substr($rawartist,0,length($rawartist) -1);
		
		my $rawalbum = substr(`banshee --query-album`, 7);
		my $album= substr($rawalbum,0,length($rawalbum) -1);
		
		my $rawversion = `banshee --version`;
		my $version = substr($rawversion,0,11);
		
		my $rawstatus = substr(`banshee --query-current-state`, 15);
		my $status = substr($rawstatus,0,length($rawstatus) -1);
		
		my $score = &starScore();
		
		my $listening ="\cC24[\cC20$version : \cC18$status\cC24] \cC25$title"." \cC20by \cC25$artist"." \cC20on \cC25$album "."\cC24(\cC25$score\cC24)";
		command("me  $listening");
	}
}

# Display stars for score instead of number
sub starScore() {
	
	my $rawscore = substr(`banshee --query-rating`, 8);
	my $score =substr($rawscore,0,length($rawscore)-1);
	
	if ($score == 1) {
		my $starscore = "★☆☆☆☆";
		return $starscore;
	}
	if($score == 2) {
		 my $starscore="★★☆☆☆";
		 return $starscore;
	}
	if($score == 3) {
	 	my $starscore ="★★★☆☆";
	 	return $starscore;
	 }
	 if ($score == 4) {
	 	my $starscore ="★★★★☆";
	 	return $starscore;
	 }
	 if ($score == 5) {
	 	my $starscore ="★★★★★";
	 	return  $starscore;
	 }
	 else {
	 	my $starscore = "☆☆☆☆☆";
	 	return $starscore;
	 }
}


# Play the current track
sub bplay {
	`banshee --play`;
	command ("echo Show must go on !");
}

# Pause Banshee
sub bpause {
	`banshee --pause`;
	command("echo Banshee is pausing");
}

# Next track
sub bnext {
	`banshee --next`;
	command("echo Next Track");
}

# Previous track
sub bprev {
	`banshee --previous`;
	command("echo Previous Track")
}

# Rating current track ( USAGE : /brate [rating] )
sub brate {
	my $score = -1;
	my $score=$_[0][1];
	
	my $rawtitle = substr(`banshee --query-title`, 7);
	my $title = substr($rawtitle,0, length($rawtitle) -1);
	
	my $rawartist = substr(`banshee --query-artist`, 8);
	my $artist = substr($rawartist,0,length($rawartist) -1);
	
	if ($score eq 0) {
		`banshee --set-rating=$score`;
		command("echo $title of $artist has now a rating of $score");
		return;
	}
	
	if ($score == 1) {
		`banshee --set-rating=$score`;
		command("echo $title of $artist has now a rating of $score");
		return;
	}
	
	if ($score == 2) {
		`banshee --set-rating=$score`;
		command("echo $title of $artist has now a rating of $score");
		return;
	}
	
	if ($score == 3) {
		`banshee --set-rating=$score`;
		command("echo $title of $artist has now a rating of $score");
		return;
	}
	
	if ($score == 4) {
		`banshee --set-rating=$score`;
		command("echo $title of $artist has now a rating of $score");
		return;
	}
	
	if ($score == 5) {
		`banshee --set-rating=$score`;
		command("echo $title of $artist has now a rating of $score");
		return;
	}
	# | $score != 2 || $score != 3 || $score != 4 || $score != 5 || $score != 0
	if ($score eq undef || $score != 1 .. 5) {
		command("echo brate usage : /brate [rating]; Rating = [0 - 5]");
		return;
	}
	
	else {
		command("echo brate usage :  /brate [rating]; Rating = [0 - 5]");
		return;
	}
}


# Display Banshee version
sub bvers {
	my $rawversion = `banshee --version`;
	my $version = substr($rawversion,0,11);
	command("echo $version");
}

# Test if Banshee currently running
sub btest {
	`pidof banshee`;
	my $btest = $?;
	if ($btest == 0) { 
		return 0;
	}
	else {
		command("echo Banshee is not currently running  !");
		return 1;
	}
}

# The About function ;) 
sub babout {
	command("me BansheeX 0.5 - A simple perl script for using Banshee in Xchat - Auze ")
}

# Display list of BansheeX command
sub help {
	command("echo List of available commands :");
	command("echo bhelp - Display this help");
	command("echo bcur - Display the song currently played");
	command("echo bplay - Play the song");
	command("echo bpause - Pause the song");
	command("echo bnext - Play next song");
	command("echo bprev - play previous song");
	command("echo brate [rate] - Rate the current song of [rate]");
	command("echo bvers - Display Banshee version");
	command("echo babout - Display script version");
	command("echo btest - Test if banshee is running (0 if running)");
}

