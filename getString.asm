			####################################################
			## GetString is used to get input from            ##	
			##    KeyBoard Simulator                          ##
			####################################################
			
.eqv kbInCtl 0xFFFF0000		# 0xFFFF0000 rcv contrl
.eqv kbInData 0xFFFF0004	# 0xFFFF0004 rcv data
.eqv dispOutCtl 0xFFFF0008	# 0xFFFF0008 tx contrl
.eqv dispOutData 0xFFFF000c	# 0xFFFF000c tx data


.globl getNChar
.text			
getNChar:		
	 
	la     $t1,kbInCtl		# set up register for input control word
	li	$t2, 0			# initialize counter
	
loop:
	lw	$t3,0($t1)	        # read rcv ctrl
	andi	$t3,$t3,0x0001		# extract ready bit
	beq	$t3,$0,loop		# keep polling till ready
	
# move character	
	lb	$t4, kbInData		# read string into temporary register
	add	$t5, $a0, $t2		# calculate store address a+i
	sb 	$t4, 0($t5)             # store calculated address a[i] = ?
	
loop2:
	lw	$t6, dispOutCtl		# is ready to accept a data byte?
	andi	$t6, $t6, 0x1
	beq	$t6, $0,  loop2
	
	sw	$t4, dispOutData
	
	addi	$t2, $t2, 1		# increment counter		
	bne	$t4, $a1, loop  	# if newline not found loop again'			    	  
	sb      $0, 0($t5)              # overlay newline with null in t4 
	jr	$ra			# if end do return
