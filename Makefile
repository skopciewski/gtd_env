LOCAL_DIR := $(HOME)/opt

USER_BIN_DIR := $(HOME)/sbin
TODO_BIN := $(USER_BIN_DIR)/todo.sh

TODO_CONF_DIR := $(HOME)/.todo
TODO_CONF_DEFAULT := $(TODO_CONF_DIR)/config
TODO_CONF_CONKY := $(TODO_CONF_DIR)/conky-config

TODO_ACTIONS_DIR := $(HOME)/.todo.actions.d
TODO_ACTIONS_ADD := $(TODO_ACTIONS_DIR)/add
TODO_ACTIONS_WIN := $(TODO_ACTIONS_DIR)/win

WHEN_CONF_DIR := $(HOME)/.when
WHEN_CONF_DEFAULT := $(WHEN_CONF_DIR)/preferences

all: prepare_todo prepare_when

#for todo.txt
prepare_todo: $(TODO_BIN) $(TODO_CONF_DEFAULT) $(TODO_CONF_CONKY) \
	$(TODO_ACTIONS_ADD) $(TODO_ACTIONS_WIN)

$(TODO_BIN):  | $(USER_BIN_DIR)
	git clone https://github.com/ginatrapani/todo.txt-cli.git $(LOCAL_DIR)/todo.txt-cli
	ln -s $(LOCAL_DIR)/todo.txt-cli/todo.sh $(TODO_BIN)

$(USER_BIN_DIR):
	mkdir -p $(USER_BIN_DIR)

$(TODO_CONF_DEFAULT): | $(TODO_CONF_DIR)
	ln -s $(PWD)/todotxt/config $(TODO_CONF_DEFAULT)

$(TODO_CONF_CONKY): | $(TODO_CONF_DIR)
	ln -s $(PWD)/todotxt/conky-config $(TODO_CONF_CONKY)

$(TODO_CONF_DIR):
	mkdir -p $(TODO_CONF_DIR)

$(TODO_ACTIONS_ADD): | $(TODO_ACTIONS_DIR)
	wget -O $(TODO_ACTIONS_ADD) http://github.com/doegox/todo.txt-cli/raw/extras/todo.actions.d/add 
	chmod 750 $(TODO_ACTIONS_ADD)

$(TODO_ACTIONS_WIN): | $(TODO_ACTIONS_DIR)
	git clone https://github.com/skopciewski/todo.txt-when_integrator.git $(LOCAL_DIR)/todo.txt-when_integrator
	ln -s $(LOCAL_DIR)/todo.txt-when_integrator/win $(TODO_ACTIONS_WIN)

$(TODO_ACTIONS_DIR):
	mkdir -p $(TODO_ACTIONS_DIR)

#for when
prepare_when: $(WHEN_CONF_DEFAULT)

$(WHEN_CONF_DEFAULT): | $(WHEN_CONF_DIR)
	ln -s $(PWD)/when/preferences $(WHEN_CONF_DEFAULT)

$(WHEN_CONF_DIR):
	mkdir -p $(WHEN_CONF_DIR)
