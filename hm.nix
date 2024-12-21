nixosConfig: 
{
    imports = [ 
        (import ./modules nixosConfig)
    ];
}