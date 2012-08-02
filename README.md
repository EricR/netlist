# NetList

NetList is a small networking and security aduting script I wrote in Ruby. Given a search term, it will query
the ARIN database for an organization and all of its related networks. This can assist a pen tester in finding out
which networks are owned by the target, and noting them for a later scan and aduit.

## Example

    $ ruby netlist.rb facebook
    [!] Starting NetList script...
    [!] Found 3 organizations matching your query, "facebook".
    [!] Starting network lookup queries...

    ----- FACEBOOK (FACEB) -----

    * UU-65-201-208-24-D7
      65.201.208.24 - 65.201.208.31

    ----- Facebook Inc (FACEB-1) -----

    * FACEBOOK-CORP
      2620:10D:C000:: - 2620:10D:C0FF:FFFF:FFFF:FFFF:FFFF:FFFF

    ----- Facebook, Inc. (THEFA-3) -----

    * TFBNET3
      66.220.144.0 - 66.220.159.255

    * TFBNET4
      74.119.76.0 - 74.119.79.255

    * TFBNET1
      204.15.20.0 - 204.15.23.255

    * TFBNET2
      69.63.176.0 - 69.63.191.255

    * FACEBOOK-IPV6-BLOCK-1
      2620:0:1C00:: - 2620:0:1CFF:FFFF:FFFF:FFFF:FFFF:FFFF

    * FACEBOOK-INC
      173.252.64.0 - 173.252.127.255

    [!] Done. Enjoy!
