Function Reset-OneLoginUserPassword {
    [cmdletbinding(SupportsShouldProcess,ConfirmImpact = "Medium")]
    Param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [OneLogin.User]
        $Identity,

        [securestring]$Password,# = (ConvertTo-SecureString -AsPlainText -Force 'ThisIsAPassword'),

        [string]$Salt = (New-Guid).Guid
    )

    begin
    {
        Function Get-StringHash {
            [cmdletbinding()]
            [OutputType([String])]
            param(
                [parameter(ValueFromPipeline, Mandatory = $true, Position = 0)][String]$String,
                [parameter(ValueFromPipelineByPropertyName, Mandatory = $true, Position = 1)]
                [ValidateSet("MD5", "RIPEMD160", "SHA1", "SHA256", "SHA384", "SHA512")][String]$HashName
            )
            begin {
        
            }
            Process {
                $StringBuilder = New-Object System.Text.StringBuilder
                [System.Security.Cryptography.HashAlgorithm]::Create($HashName).ComputeHash([System.Text.Encoding]::UTF8.GetBytes($String))| foreach-object {
                    [Void]$StringBuilder.Append($_.ToString("x2"))
                }
                $output = $StringBuilder.ToString()
            }
            end {
                return $output
            }
        }

        $hashString = Get-StringHash -String ($Salt + [pscredential]::New('user',$Password).GetNetworkCredential().Password) -HashName SHA256

        $body = @{
            password = $hashString
            password_confirmation = $hashString
            password_algorithm = 'salt+sha256'
            password_salt = $Salt
        }

        $Splat = @{
            Method = "Put"
            Body   = $Body
        }
    }
    
    process
    {
        $Splat["Endpoint"] = "api/1/users/set_password_using_salt/$($Identity.Id)"
        if ($PSCmdlet.ShouldProcess($Identity, $MyInvocation.MyCommand.Name))
        {
            Invoke-OneLoginRestMethod @Splat
        }
    }
}