
I was recently tasked in finding a solution for resetting root passwords for 800+ VMWare ESXi hosts and if Passwordstate would be able to facilitate this. 

I initially started looking at the built-in Linux scripts which utilises SSH connections, something we have disabled for our ESXi hosts for security.

Searching through these forums I found a post where someone used PowerCLI to do the heavy lifting, but I found the post didnt quite give me everything I needed to complete the project.

 

Here is my attempt at demonstrating my solution, in hopes it will help someone out in the future.

 

Password reset and password validation scripts:

We need to talk about these custom scripts first, as we need the IDs of the script to fill in the JSON data for scripted host ingest

 

 

This utilises Set-VMHostAccount Powercli command which is  baked into an ESXi host and only requires powershell to be open from the Passwordstate webserver to the host (port 443).

The success criteria simply looks for the word root in the output, this may be foolish of me, but there isn't much of a result from the command to parse for a successful result

If the command fails it should be captured by my catch commands

 


 

Simple script with attempts to connect to a host via powercli, if there is a connection then output success.

 

 

Host/Password Entry:

All of our hosts are domain joined so host discovery was rather straightforward enough by using the built in utility in Passwordstate. Unfortunately there was no easy way to automatically discover host accounts, but since we are only dealing with Root here we can script adding of password entries.  You'll need to get your custom script IDs from the ones you created above. This is a one off script and took around one minute to add 800 hosts



