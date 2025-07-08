# Ninecraft mod testing
Goal: learn ninecraft modding, document as i go and also create tool sets for building them with nix such as easily testing mods in an iscolated ninecraft instance


## building

```
nix-build
```

## testing
```
nix-build ./testNinecraftMod.nix
./result/bin/ninecraft-mod-test
```