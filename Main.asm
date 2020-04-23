	 ################################################
	 ##    This program simulates a command prompt ##
	 ##    using the MMIO Keyboard with commands   ##
	 ##            echo, help, and, exit	       ##
	 ################################################
# Data area
.globl main
.data
buffer:	.space	80
Prompt:     		.asciiz     "Enter a command."
Command1:		.asciiz      "help"
Command2:		.asciiz	     "echo "
Command3:		.asciiz	     "exit"
typeCommandPrompt: 	.asciiz "Type a command or help for a list of command options: "
errorHelp:		.asciiz "Command not found\n"
helpMessage:		.asciiz "help, echo, exit\n"
echoMessage:		.asciiz "echoing: "
newline:		.asciiz "\n"
	.text
main:	
	la	$a0, typeCommandPrompt 	#load first prompt
	jal	putNChar

	la	$a0, buffer            #load buffer
	li	$a1, '\n'	       #load new line character
	jal	getNChar
	
	## The following lines check if the input 
	## is equal to a command using StringCompare
	## if the result of StringCompare is not false it calls 
	## the commands method
	
	la	$a0, buffer
	la	$a1, Command1
	jal	StringCompare
	bne	$v0, $0, helpCommand	
	
	la	$a0, buffer
	la	$a1, Command2
	jal	StringCompare
	bne	$v0, $0, echoCommand

	la	$a0, buffer
	la	$a1, Command3
	jal	StringCompare
	bne	$v0, $0, exitCommand
	
	la 	$a0, errorHelp
	jal	putNChar
	j	main

#prints commands
helpCommand:
	la	$a0, helpMessage
	jal	putNChar
	j	main


#prints word typed after echo to display 	
echoCommand:
	la	$a0, echoMessage
	jal	putNChar
	la	$a0, buffer+5     #advance 5 in buffer to skip over "echo "  
	jal	putNChar
	la	$a0, newline
	jal	putNChar
	j	main	
		

#exits
exitCommand:
	li      $v0, 10		
	syscall			


