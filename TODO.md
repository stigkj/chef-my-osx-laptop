### TODO

Look at

* http://woss.name/2011/01/23/converging-your-home-directory-with-chef/
* http://macnix.blogspot.com/2011/07/change-mac-os-x-107-lion-ical-skin-to.html
* https://github.com/pivotal/pivotal_workstation
* https://github.com/josh/osx-cookbooks
* https://github.com/philips/ghar - So dotfiles can be shared on GitHub. Integrate into chef, maybe? 


## Must include configuration for:

# Intellij
* Font (get a great programmer's font)

# Sublime Text
# For colour schemes use Solarized or GH/chriskempson/tomorrow-theme


## Network stuff

* Use dnsmasq as local caching DNS server 
  * Use ncutil for setting localhost as DNS server (works on Lion??)
  * Write DNS servers from DHCP into /usr/local/etc/resolv.conf that dnsmasq uses
    * DNS servers from ipconfig getpacket <interface, eg en0>
    * Look at crankd.py for running a script for writing DNS servers on each network change
      An example: http://glarizza.posterous.com/using-crankd-to-react-to-network-events

## Applications to install

* Slink
* Sublime Text 2 (done)
  * also include plugins
* Alfred
* GrandPerspective (disk space utility)

## Other stuff

* download Xcode command line tools from Apple using adc_download.sh
  * https://github.com/michaeltyson/adc-download
  * http://adcdownload.apple.com/Developer_Tools/command_line_tools_os_x_lion_for_xcode__july_2012/xcode44cltools_10_76938107a.dmg
  * put shell script on its own project on GitHub? Contact author, check if he has a GH-page
* Have all (active) github (and other) repos checked out in the correct place
	* Maybe use chef for updating all of them too?
* Nice OSX defaults: https://github.com/mathiasbynens/dotfiles/blob/master/.osx
* chefify all packages installed
  * brew
  * python (pip)
  * ruby (gem)
  * Scala's conscript/giter8
* Chrome stuff
  * Setup as default browser; look at duti.sf.net and default_handlers.duti in nisgits cookbook
    Also look at http://krypted.com/mac-os-x/lsregister-associating-file-types-in-mac-os-x/
  * setup plugins automatically (sync plist to Dropbox?)
  * sync open tabs through Dropbox?
  * find open tabs from Time Machine backup
* Startup locate as service
  * sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

