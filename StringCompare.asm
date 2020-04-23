		#########################################
		##  String compare is used to compare  ##
		##  input against command constants    ##			   
		#########################################

.text
.globl StringCompare
StringCompare:
compareloop:
    lb      $t6,($a0)                    # get character from input
    lb      $t3,($a1)                    # get next character from commmand
    bne     $t6,$t3, compareNotEqual     # are the strings different? 

    beq     $t6,$zero, compareEqual      # if at end of string

    addi    $a0,$a0, 1                   # get next char
    addi    $a1,$a1, 1                   # get next char
    j       compareloop			 
   
   
 compareNotEqual:
    lb $t3, -1($a1) 	# "backspace" in memory
    beq	$t3, 32, compareEqual # does $t3 hold 32 bits (echo)
    
    li $v0, 0    #return false
    jr $ra
    
 compareEqual:
    li $v0, 1	#return true
    jr $ra
    
