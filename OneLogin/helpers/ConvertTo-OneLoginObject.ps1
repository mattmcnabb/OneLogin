function ConvertTo-OneLoginObject
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory, ValueFromPipeline)]
        $InputObject,

        [Type]
        $OutputType
    )
    
    begin
    {
        $ClassProperties = $OutputType.GetProperties().Name
    }
    
    process
    {
        $Output = @{
            AdditionalProperties = @{}
        }
        foreach ($Property in $InputObject.PSObject.Properties)
        {
            $PropertyName = $Property.Name
            $PropertyValue = $Property.Value
            if ($PropertyName -in $ClassProperties)
            {
                $Output[$PropertyName] = $PropertyValue
            }
            else
            {
                $Output['AdditionalProperties'].Add($PropertyName, $PropertyValue)
            }
        }

        $Output -as $OutputType
    }
}
