PROJECT:=zturn-trd
BIT_FILE:=${PROJECT}.bit
HWDEF_FILE:=${PROJECT}.hdf
FSBL_FILE:=fsbl.elf
FSBL_SRCS:=fsbl_src

all: bit fsbl

.PHONY:bit
bit:${BIT_FILE}

${BIT_FILE}: ${PROJECT}
	PROJECT=${PROJECT} HWDEF=${HWDEF_FILE} FSBL=${FSBL_SRCS}  bin/make-bitfile.sh $<
	cp  $</$<.runs/impl_1/z_turn_wrapper.bit $@

.PHONY:project
project:${PROJECT}

${PROJECT}:
	 PROJECT=${PROJECT} HWDEF=${HWDEF_FILE} FSBL=${FSBL_SRCS} bin/make-project.sh ${PROJECT}

.PHONY:hdf
hdf:${HWDEF_FILE}

${HWDEF_FILE}: ${PROJECT}
	PROJECT=${PROJECT} HWDEF=${HWDEF_FILE} FSBL=${FSBL_SRCS}  bin/make-hwdef.sh $< $@


.PHONY:fsbl
fsbl:${FSBL_FILE}

${FSBL_SRCS}: ${PROJECT}
	PROJECT=${PROJECT} HWDEF=${HWDEF_FILE} FSBL=${FSBL_SRCS} bin/make-fsbl.sh $@



${FSBL_FILE}: hdf ${FSBL_SRCS}
	make -C ${FSBL_SRCS}/fsbl CFLAGS=-DFSBL_DEBUG_INFO
	cp ${FSBL_SRCS}/fsbl/executable.elf $@

.PHONY:clean_${FSBL_SRCS}
clean_${FSBL_SRCS}:
	rm -Rf ${FSBL_SRCS}

.PHONY:clean_${PROJECT}
clean_${PROJECT}:
	rm -Rf ${PROJECT}

.PHONY:clean_logs
clean_logs:
	rm -f vivado*
	rm -f hsi*

clean: clean_${FSBL_SRCS} clean_${PROJECT} clean_logs
	rm -f ${BIT_FILE} ${HWDEF_FILE} ${FSBL_FILE}
