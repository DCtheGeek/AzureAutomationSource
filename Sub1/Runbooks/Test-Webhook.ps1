workflow Test-Webhook
{
    #This is a bogus edit to trigger a GitHub push webhook call
    param ( 
        [object]$WebhookData
    )

    # If runbook was called from Webhook, WebhookData will not be null.
    if ($WebhookData -ne $null) {   
        # Collect properties of WebhookData
        $WebhookName    =   $WebhookData.WebhookName
        $WebhookHeaders =   $WebhookData.RequestHeader
        $WebhookBody    =   $WebhookData.RequestBody

        # Collect individual headers. VMList converted from JSON.
        $From = $WebhookHeaders.From
        $VMList = (ConvertFrom-Json -InputObject $WebhookBody).VirtualMachines
        Write-Output "Runbook started from webhook $WebhookName by $From."
    }
    else {
        Write-Error "Runbook meant to be started only from webhook." 
    } 
}