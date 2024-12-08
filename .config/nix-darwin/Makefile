deploy:
	nix build .#darwinConfigurations.Yushi-MBA.system\
	   --extra-experimental-features 'nix-command flakes'

	./result/sw/bin/darwin-rebuild switch --flake .#Yushi-MBA
