# put N Characters procedure
# Memory mapped addresses of device fields.
.eqv kbInCtl 0xFFFF0000		# 0xFFFF0000 rcv contrl
.eqv kbInData 0xFFFF0004	# 0xFFFF0004 rcv data
.eqv dispOutCtl 0xFFFF0008	# 0xFFFF0008 tx contrl
###########################################
##	put string is used to output    ##
##	     string to Display		##
##########################################

.eqv dispOutData 0xFFFF000C	# 0xFFFF000c tx data	
.globl putNChar
putNChar:		

	la      $t1,dispOutCtl	# set up register for output control word
	la	$t5,dispOutData
	li	$t2, 0		# initialize counter
		
# loop until last character written out

loop:	lw	$t3,0($t1)	# read disp ctrl
	andi	$t3,$t3,0x0001  # extract ready bit 
	beq	$t3,$0,loop 	# poll till ready for next character
		
output:	add 	$t4, $a0, $t2	# calculate output byte address
	lbu	$t6, 0($t4)	# move byte to output field
	sw	$t6, 0($t5)     # store string
	addi 	$t2, $t2, 1	# increment counter
	bne	$t6, $zero, loop # look for null
	jr	$ra		# return
	
