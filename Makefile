
FILES := count.html data1.html env.sh example_form.sh get_data.html hello.sh network_control.sh params.sh simple.html test.html timer.html timer.sh upnp.txt uptime.sh
INSTALL_DEST := /opt/www
TARGETS := install update-repo check
.PHONY: $(TARGETS) help
help:
	@echo
	@echo "Choose a target from $(TARGETS)"
	@echo "  install: copy files from this repo to the deployment area."
	@echo "  update-repo: copy files from the deployment area to this repo."
	@echo "  check: diff the repo and deployment area."
	@echo

install:
	cp $(FILES) $(INSTALL_DEST)

update-repo:
	cp $(addprefix $(INSTALL_DEST)/,$(FILES)) .

check:
	-diff $(INSTALL_DEST) . 
