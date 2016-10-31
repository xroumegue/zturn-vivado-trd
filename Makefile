PROJECT:=zturn-trd
BIT_FILE:=zturn-trd.bit
HWDEF_FILE:=zturn.hdf
FSBL:=fsbl.elf
FSBL_SRCS:=fsbl

all: ${BIT_FILE} ${HWDEF_FILE} ${FSBL}

${BIT_FILE}: ${PROJECT}
	bin/make-bitfile.sh ${BIT_FILE}
	cp  ${PROJECT}/${PROJECT}.runs/impl_1/z_turn_wrapper.bit $@

${PROJECT}:
	bin/make-project.sh ${PROJECT}

${HWDEF_FILE}: ${PROJECT}
	bin/make-hwdef.sh ${HWDEF_FILE}

${FSBL_SRCS}: ${PROJECT}
	bin/make-fsbl.sh $@

${FSBL}: ${FSBL_SRCS}
	make -C ${FSBL_SRCS}/fsbl
	cp ${FSBL_SRCS}/fsbl/executable.elf $@

clean_${FSBL}:
	rm -f ${FSBL}

clean_${FSBL_SRCS}:
	rm -Rf ${FSBL_SRCS}

clean_${PROJECT}:
	rm -Rf ${PROJECT}

clean_${BIT_FILE}:
	rm -f ${BIT_FILE}

clean: clean_${FSBL} clean_${FSBL_SRCS} clean_${PROJECT}
	rm -f ${BIT_FILE} ${HWDEF_FILE} ${FSBL} 
	rm -f vivado*
	rm -f hsi*
