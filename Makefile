
FILES := count.html data1.html env.sh example_form.sh get_data.html hello.sh network_control.sh params.sh simple.html test.html timer.html timer.sh upnp.txt uptime.sh
INSTALL_DEST := /opt/www
TARGETS := install update-repo
.PHONY: $(TARGETS) help
help:
	@echo "Choose a target from $(TARGETS)"

install:
	cp $(FILES) $(INSTALL_DEST)

update-repo:
	cp $(addprefix $(INSTALL_DEST)/,$(FILES)) .


