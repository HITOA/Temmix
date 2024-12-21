nixosConfig:
{
    imports = [
        (import ./vscode nixosConfig)
    ];
}