CC                = /opt/freeware/bin/gcc
BUILD_DIR         = ./build
BUILD_OBJ_DIR     = $(BUILD_DIR)/AIX/obj
BUILD_BIN_DIR     = $(BUILD_DIR)/AIX/bin
BIN               = xo
CFLAGS            = -O2 -g -mtune=native -Wpedantic -Wall -Wno-unknown-pragmas -I src/i18n/${ISO} -I .libs/libbsd/include -D Linux -D ALLOCALIGN=16 -D LIBBSD -D CTRLANG=${ISO} -D INCLUDETESTS
LDFLAGS           = -g -lm -lbsd -L.libs/libbsd/lib
CSRCS             = $(shell find ./src/* -prune -type f -name '*.c')
COBJS             = $(patsubst ./src/%.c, $(BUILD_OBJ_DIR)/%.o, $(CSRCS))
TARGET            = $(COBJS)

all: xo

xo: $(TARGET)
	$(CC) $(TARGET) $(LDFLAGS) -o $(BUILD_BIN_DIR)/$(BIN)

$(BUILD_OBJ_DIR)/%.o: ./src/%.c
	@mkdir -p $(BUILD_OBJ_DIR)
	$(CC) $(CFLAGS) $(EXTRACFLAGS) -c $< -o $@

clean:
	rm $(BUILD_OBJ_DIR)/* $(BUILD_BIN_DIR)/$(BIN)

plugin:
	cd src/plugins/${PACKAGE} && gmake all

plugin-clean:
	cd src/plugins/${PACKAGE} && gmake clean

