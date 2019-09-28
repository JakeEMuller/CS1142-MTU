
### START MAIN, DO NOT MODIFY ###
			.text
mainLoop:			
			li			$v0, 5						# Read integer command from user
			syscall

			bltz		$v0, mainDone				# Negative number ends program
			beq 		$v0, $0, mainFirst			# Command 0 = print first node 	
			addi		$v0, $v0, -1
			beq 		$v0, $0, mainList			# Command 1 = print entire list
			addi		$v0, $v0, -1
			beq 		$v0, $0, mainUpdate			# Command 2 = update item
			
			la			$a0, strInvalid				# Print linked list from first node
			li			$v0, 4
			syscall		
			
mainEnd:
			li      	$v0, 11      				# Print a linefeed
			addi    	$a0, $0, 10 
			syscall
			
			b			mainLoop

mainFirst:
			# Print just the first node
			la			$a0, strFirst				
			li			$v0, 4
			syscall		
			
			la			$a0, first					
			jal			printNode
			b			mainEnd
									
mainList:
			# Print linked list from the first node
			la			$a0, strList				
			li			$v0, 4
			syscall		
			
			la			$a0, first					
			jal			printList
			b			mainEnd
			
mainUpdate:
			# Update a specific item
			li			$v0, 5						# Read part number
			syscall
			move		$a1, $v0					
			
			li			$v0, 5						# Read quantity delta
			syscall
			move		$a2, $v0
			
			la			$a0, strUpdate				
			li			$v0, 4
			syscall		

			la			$a0, first
			jal			updateItem
			
			move		$a0, $v0					# Print result from update procedure
			li			$v0, 1
			syscall
			
			b			mainEnd

mainDone:
			# Terminate execution
			li			$v0, 10						
			syscall
			
			.data
strInvalid:	.asciiz "Invalid command!"
strFirst:   .asciiz "First  : "
strList:    .asciiz "Items  : "
strUpdate:	.asciiz "Update : "
			
			.text
### END MAIN ###

############################################################
# Prints the part number, description, and quantity
# of a given node in the list. Example output: 
#  "#955288 Buzz Lightyear (21)"
# Parameters : $a0 - address of node to print
# Returns    : n/a
############################################################
printNode:
			jr			$ra
						
############################################################
# Prints list of items from given starting node in null 
# terminated linked list. Each node is printed via printNode
# procedure. Items separated by a comma and space.
#  
# Parameters : $a0 - address of node to start printing from
# Returns    : n/a
############################################################
printList:
			jr 		  	$ra	

############################################################
# Finds the first item in the list matching a part  
# number and changes its quanity by a certain amount.
# Quantity is not allowed to go below 0.
#
# Parameters : $a0 - address of first node in list
#              $a1 - part number to match
#              $a2 - delta to apply to quantity
# Returns    : $v0 - new quantity, -1 if item not found
############################################################
updateItem:
			li			$v0, -1
			jr			$ra
											
### START DATA ###
# You can (and should!) modify the linked list in order to test your procedures.
# However, the first node should retain the label first.
.data
first:  	.word     	node2       				# Next pointer
			.word     	955288	     				# Part number
			.word     	21							# Quantity
        	.asciiz   	"Buzz Lightyear" 			# Description
        
node2:		.word     	node3
			.word     	955285
			.word     	2
        	.asciiz   	"Genie"

node3:  	.word     	-1
			.word     	951275
			.word     	5
        	.asciiz   	"Chick-Fil-A Cow"
### END DATA ###
		
		
