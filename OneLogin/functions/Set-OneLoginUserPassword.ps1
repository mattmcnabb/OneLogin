function Set-OneLoginUserPassword
{
     [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "Medium")]
     param
     (
          [Parameter(Mandatory = $true, ValueFromPipeline)]
          [ValidateNotNullOrEmpty()]
          [OneLogin.User]
          $Identity,

          [Parameter(Mandatory = $true)]
          [ValidateNotNullOrEmpty()]
          [SecureString]
          $Password,

          [Parameter(Mandatory = $true)]
          [ValidateNotNullOrEmpty()]
          [SecureString]
          $ConfirmPassword,

          [string]
          $validate_policy = $false
     )

     begin
     {
          $Body = @{}
          $Body.password = $((New-Object PSCredential "user",$Password).GetNetworkCredential().Password)
          $Body.password_confirmation = $((New-Object PSCredential "user",$ConfirmPassword).GetNetworkCredential().Password)
          $Body.validate_policy = $validate_policy

          $Splat = @{
               Method = "Put"
               Body   = $Body
          }
     }

     process
     {
          $Splat["Endpoint"] = "api/1/users/set_password_clear_text/$($Identity.Id)"
          if ($PSCmdlet.ShouldProcess($Identity, $MyInvocation.MyCommand.Name))
          {
               Invoke-OneLoginRestMethod @Splat
          }
     }
}
