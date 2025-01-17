# Linux Script

When the order of steps does not matter, bullet points have been used instead of ordinals.

To edit files, run `gedit`, a graphical editor akin to notepad; `nano`, a simple command-line editor; or `vim`, a powerful  but less intuitive command-line editor. Note that vim may need to be installed with `apt-get install vim`.

## Checklist

1. Read the readme
	
	Note down which ports/users are allowed.

1. **Do Forensics Questions**
	
	You may destroy the requisite information if you work on the checklist!


	1. Open up `/etc/passwd` and check which users
		* Are uid 0
		* Can login
		* Are allowed in the readme
	1. Delete unauthorized users:
		
		`sudo userdel -r $user`

		`sudo groupdel $user`
	1. Check `/etc/sudoers.d` and make sure only members of group sudo can sudo.
	1. Check `/etc/group` and remove non-admins from sudo and admin groups.
	1. Check user directories.
		1. cd `/home`
		1. `sudo ls -Ra *`
		1. Look in any directories which show up for media files/tools and/or "hacking tools."

	1. Add a minimum password length, password history, and add complexity requirements.
			1. Locate the line that has 'pam.cracklib.so' in it. If you cannot find that line, install cracklib with `sudo apt-get install libpam-cracklib`.
			1. Add `ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-` to the end of that line.
		3. Implement an account lockout policy.
			1. Open `/etc/pam.d/common-auth`.
			2. Add `deny=5 unlock_time=1800` to the end of the line with `pam_tally2.so` in it.
		4. Change all passwords to satisfy these requirements.
			
			`chpasswd` is very useful for this purpose.

1. Enable automatic updates
	
	In the GUI set Update Manager->Settings->Updates->Check for updates:->Daily.

1. Secure ports
	1. `sudo ss -ln`
	1. If a port has `127.0.0.1:$port` in its line, that means it's connected to loopback and isn't exposed. Otherwise, there should only be ports which are specified in the readme open (but there probably will be tons more).
	1. For each open port which should be closed:
		1. `sudo lsof -i :$port`
		1. Copy the program which is listening on the port.
		`whereis $program`
		1. Copy where the program is (if there is more than one location, just copy the first one).
		`dpkg -S $location`
		1. This shows which package provides the file (If there is no package, that means you can probably delete it with `rm $location; killall -9 $program`).
		`sudo apt-get purge $package`
		1. Check to make sure you aren't accidentally removing critical packages before hitting "y".
		1. `sudo ss -l` to make sure the port actually closed.

1. Secure network
	1. Enable the firewall
	
		`sudo ufw enable`
	1. Enable syn cookie protection
	
		`sysctl -n net.ipv4.tcp_syncookies`
	1. Disable IPv6 (Potentially harmful)
	
		`echo "net.ipv6.conf.all.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf`
	1. Disable IP Forwarding
		
		`echo 0 | sudo tee /proc/sys/net/ipv4/ip_forward`
	1. Prevent IP Spoofing
	
		`echo "nospoof on" | sudo tee -a /etc/host.conf`

1. Install Updates

	Start this before half-way.

	* Update services specified in readme.
		1. Google to find what the latest stable version is.
		1. Google "ubuntu install service version".
		1. Follow the instructions.
	
	* Ensure that you have points for upgrading the kernel, each service specified in the readme, and bash if it is [vulnerable to shellshock](https://en.wikipedia.org/wiki/Shellshock_%28software_bug%29).
	

1. Configure services
	1. Check service configuration files for required services.
		Usually a wrong setting in a config file for sql, apache, etc. will be a point.
	1. Ensure all services are legitimate.
		
		`service --status-all`

1. Check the installed packages for "hacking tools," such as password crackers.

1. Run other (more comprehensive) checklists. This is checklist designed to get most of the common points, but it may not catch everything.

1. Check Browser settings (block redirects and popups)
 
## Tips

* Netcat is installed by default in ubuntu. You will most likely not get points for removing this version.
* Some services (such as `ssh`) may be required even if they are not mentioned in the readme. Others may be points even if they are explicitly mentioned in the readme
