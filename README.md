# Home-Docker-Env
Home Docker Env

# limitation : you can run programs which are not inside home directory of the user.

=> install docker rootless
	--> https://rootlesscontaine.rs/getting-started/docker/  
	--> https://docs.docker.com/engine/security/rootless/

=> install compose for rootless docker : 
	--> https://github.com/docker/compose/  
	--> https://github.com/docker/compose/releases 

	--> curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o $HOME/bin/docker-compose
		
=> run install_docker_rootless.sh script to install rootles docker and docker-compose

=> run install.sh script to setup docker environment for local user

=> pull all images needed by docker-complose.yml
 
=> copy all app image listed inside software_links file:  
	--> https://github.com/VSCodium/vscodium/releases
