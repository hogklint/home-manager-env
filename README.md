# Setup

```sh
mkdir -p ${HOME}/.config/nix
echo 'experimental-features = nix-command flakes' >> ${HOME}/.config/nix/nix.conf
git clone git@github.com:hogklintte/nix.git ${HOME}/.config/home-manager
home-manager switch --flake ${HOME}/.config/home-manager/#hogklint
```
