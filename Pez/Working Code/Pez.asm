
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
# Parameters : $a1 - address of node to print
# Returns    : n/a
############################################################
printNode:
			
			la $a1, first
			move $s0, $ra   #move the return register to $s0
		
			jal PrintPart	#print the part specs
			
			jr		$s0	    #Return to the begininng
						
############################################################
# Prints list of items from given starting node in null 
# terminated linked list. Each node is printed via printNode
# procedure. Items separated by a comma and space.
#  
# Parameters : $a1 - address of node to start printing from
# Returns    : n/a
############################################################
printList:
			li $t7, -1	  #have $t7 as -1
			move $s3, $ra # Move the return register to $s3
			
			#print first item
			la $a1, first # saves address of first element
			
			
	Loop:
			jal PrintPart
			lw  $a1, 0($a1)	#get next item address
			beq	$a1, $t7, End
			jal PrintComma
			jal PrintSpace
			b Loop
	
	End:
			jr 		  	$s3 #return

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
			li $t7, -1					#have negative 1 on standby
	UpdateLoop:	
			lw	$t1, 4($a0)				#grab part number		
			beq $t1, $a1, AddtoQuantity #go to add to number
			lw  $a0, 0($a0) 			#get next node address
			bne $a0, $t7, UpdateLoop
			
			li $v0, -1					# in part is not found return -1
			jr			$ra				# return to update
			
AddtoQuantity:		
			lw $t2, 8($a0)	    		# get current quantity
			add $t3, $a2, $t2			# put new value into $t3
			add $v0, $0, $t3			# set return value as added value
			sw, $t3, 8($a0)				# store new value into quantity
			jr $ra 						# return to update
			
			
			

	
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

.text
#-----------------------------------------------------------
#Common Functions Used
#-----------------------------------------------------------
PrintPart: #input $a1 as the address of label
			move $s1, $ra #MOVE RETURN REGISTER TO $s1
			
			jal	PrintHash
			
			lw $a0, 4($a1)	# load part number 
			li $v0, 1
			syscall			# print part number
			
			jal PrintSpace
			
			la $a0, 12($a1) #loads value of name
			li $v0, 4
			syscall			#prints name
			
			jal PrintSpace

			jal PrintFrontPar
			
			lw $a0, 8($a1)	#load the quantity
			li $v0, 1
			syscall				#print quantity

			jal PrintBackPar
			
			jr $s1	#return
		
#-----------------------------------------------------------
# Print Common Items
#-----------------------------------------------------------
PrintHash:
			la $a0, hashtag # load a hash address into $a0
			li $v0, 4		# set syscall to print a string
			syscall			# Print a hashtag
			jr $ra
			
PrintSpace:
			la $a0, space	# loads address for a space
			li $v0, 4		# Prints a space
			syscall
			jr $ra
			
PrintFrontPar:
			la $a0, frontPar
			li $v0, 4
			syscall
			jr $ra

PrintBackPar:
			la $a0, backPar		#print the end paraenteses
			li $v0, 4
			syscall
			jr $ra
PrintLine:
			addi $a0, $0, 0xA
			li $v0, 11
			syscall
			jr $ra
			
PrintComma:
			la $a0, comma
			li $v0, 4
			syscall
			jr $ra
			
#-----------------------------------------------------------
# Common character used
#-----------------------------------------------------------	
.data
hashtag: 	.asciiz		"#"	
frontPar: 	.asciiz 	"("
backPar:	.asciiz		")"
comma: 		.asciiz		","
space:		.asciiz		" "	
		
		
