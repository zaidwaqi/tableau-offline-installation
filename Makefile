.ONESHELL:
.PHONY: deplist

deplist:
	@dnf -q deplist tableauInstaller/tableau-server-2023-3-0.x86_64.rpm | grep provider.*x86_64$ | awk '{print $$2}' | sort | uniq > deplist.txt
	@cat deplist.txt

download-deplist:
	@echo "Download deplist packages"
	@mkdir -p deplist
	@dnf download $(shell cat deplist.txt) --downloaddir=deplist

install-deplist:
	@echo "Install downloaded deplist packages"
	@sudo dnf install -y $(shell ls deplist/*.rpm)

install-tableau:
	@echo "Install tableau"
	@sudo dnf -y update
	@sudo dnf -y install tableauInstaller/tableau-server-2023-3-0.x86_64.rpm
	@sudo dnf -y install tableauInstaller/tableau-tabcmd-2023-3-0.noarch.rpm

initialize-tsm:
	@echo "Initialize TSM"
	@echo "Pretend as Centos 8 instead of Centos 8 Stream"
	@sudo bash -c 'echo "CentOS Linux release 8.6.1234" > /etc/centos-release'
	@sudo /opt/tableau/tableau_server/packages/scripts.20233.23.1017.0948/initialize-tsm -f --accepteula --no-activation-service