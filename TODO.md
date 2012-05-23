### TODO

Look at

* http://woss.name/2011/01/23/converging-your-home-directory-with-chef/
* http://macnix.blogspot.com/2011/07/change-mac-os-x-107-lion-ical-skin-to.html
* https://github.com/pivotal/pivotal_workstation
* https://github.com/josh/osx-cookbooks
* https://github.com/philips/ghar - So dotfiles can be shared on GitHub. Integrate into chef, maybe? 


## Must include configuration for:

# Intellij

* Colours (use Solarized)
* Font (get a great programmer's font)

# Sublime Text

* Colours (use Solarized)


## Network stuff

* Use dnsmasq as local caching DNS server 
  * Use ncutil for setting localhost as DNS server (works on Lion??)
  * Write DNS servers from DHCP into /usr/local/etc/resolv.conf that dnsmasq uses
    * DNS servers from ipconfig getpacket <interface, eg en0>
    * Look at crankd.py for running a script for writing DNS servers on each network change
      An example: http://glarizza.posterous.com/using-crankd-to-react-to-network-events


## Other stuff

* Have all (active) github (and other) repos checked out in the correct place
	* Maybe use chef for updating all of them too?
* Nice OSX defaults: https://github.com/mathiasbynens/dotfiles/blob/master/.osx
* chefify all packages installed
  * brew
  * python (pip)
  * ruby (gem)
