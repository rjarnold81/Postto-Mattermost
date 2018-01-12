#Set the script to use only TLS 1.2 for the duration of the script.
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

function Postto-Mattermost {
<#
.Synopsis
   Post text to a Mattermost Channel via Webhooks
.DESCRIPTION
   Long description
.EXAMPLE
   Postto-Mattermost -uri "http://mattermost.foo.com/hooks/xxxxxxxxxxxxxxxxx" -text ”New message from Powershell” -user "Powershell"
.INPUTS
   $uri,$text,$user,$channel
.NOTES
   All Inputs are Mandatory
#>
    [CmdletBinding()]Param
    (
        # Incoming Webhook
        [Parameter(Mandatory=$true
        )]
        $uri,
        # Body of message
        [Parameter(Mandatory=$true
        )]
        $text,
        # Username to post as
        [Parameter(Mandatory=$true
        )]
        $user,
        # Channel to post within
        [Parameter(Mandatory=$true
        )]
        $channel
     )
    $Payload = @{ text=$text; channel=$channel; username=$user}
    Invoke-RestMethod -Uri $uri -Method Post -ContentType 'application/json' -Body (ConvertTo-Json $Payload)
}