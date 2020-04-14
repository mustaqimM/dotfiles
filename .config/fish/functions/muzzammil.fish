#!/usr/bin/env fish

complete --exclusive --no-files --command muzzammil --arguments 'disable' --description 'Disable'
#complete --exclusive --no-files --command plain --arguments 'enable' --description 'Enable'

function muzzammil
    if test (count $argv) -lt 1
        nmcli con down id (nmcli con | rg -i "vpn   wlp2s0" | cut --delimiter=' ' -f1)
        sudo systemctl stop dnscrypt-proxy.service
        sudo chattr -i /etc/resolv.conf 
        sudo sed -i 's|127.0.0.1|192.168.0.1|g' /etc/resolv.conf
        sudo chattr +i /etc/resolv.conf 
    else
        set option $argv[1]
        switch $option
            case disable
                sudo systemctl start dnscrypt-proxy.service
                sudo chattr -i /etc/resolv.conf 
                sudo sed -i 's|192.168.0.1|127.0.0.1|g' /etc/resolv.conf
                sudo chattr +i /etc/resolv.conf 
        end
    end
end
