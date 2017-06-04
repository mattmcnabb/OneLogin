function Invoke-OneLoginRestMethod
{
    [CmdletBinding()]
    param
    (
        [string]
        $Method = "Get",
        
        [Parameter(Mandatory)]
        [string]
        $Endpoint,

        [hashtable]
        $Body
    )
    
    $Uri = "$($Token.ApiBase)/$Endpoint"

    $Splat = @{
        Method      = $Method
        Uri         = $Uri
        ContentType = "application/json"
        Headers     = @{authorization = "bearer:$($Token.access_token)"}
    }
    
    do
    {
        try
        {
            if ($Body)
            {
                switch -Regex ($Method)
                {
                    "Get"          { $Splat["Body"] = $Body }
                    "Put|Post|Del" { $Splat["Body"] = $Body | ConvertTo-Json }
                }

                $Body["after_cursor"] = $Response.Pagination.after_cursor
            }
            else { $Body = @{} }


            $Response = Invoke-RestMethod @Splat -ErrorAction Stop 
            $Response.Data
        }
        catch
        {
            throw $_
        }
        
    }
    while ($Response.Pagination.after_cursor -and $Response.data.count -eq 50)
}
