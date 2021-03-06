# IntegerSequence 
# Jake Muller
# Jemuller@mtu.edu
# 9/13/19
# Program takes inputs from user untill a negitive number is given then list
# off a multitude of statistics based on the number entered into the program

#---------------------------------------
# Initialize Varables
#---------------------------------------
	li $s0, 0		# $s0 = minimum 
	li $s1, 0 		# $s1 = Maximum
	li $s2, 0 		# $s2 = number of even numbers
	li $s3, 0		# $s3 = number of odd numbers 
	li $s4, 0 		# $s4 = sum of all numbers entered
	li $t1, 0		# $t1 = Input value
#---------------------------------------
# Begin function
#---------------------------------------
	# Get First Input from the user
	li $v0, 5
	syscall
	move $t1, $v0
	blt $t1, 0, EndProgram
	move $s0, $t1 # makes first input the minimum
	b FirstLoop

loop:
	#---------------------------
	# Get input from user
	#---------------------------
	li  $v0, 5	
	syscall			# syscall reads number from user
	move $t1, $v0 	# move inputed value  
FirstLoop:	
	#---------------------------
	# Check if input is negative
	#---------------------------
	blt $t1, 0, PrintOut	#it input is less than 0 go to printout
	
	#---------------------------
	# Check if input is minimum 
	#---------------------------
	blt $t1, $s0, SETMIN 	#if input is less than minimum set new min

AfterMin:			

	#---------------------------
	# Check if input is maximum
	#---------------------------
	bgt $t1, $s1, SETMAX	#if input is greater than max then set new max

AfterMax:
	#---------------------------
	# Check if input Even 
	#---------------------------
	li $t7, 2 		#create reference to divide by 2
	div $t1, $t7		#divides input by two 
	mfhi $t2		#grabs remained 
	beq	$t2, 0, INCREMENTEVEN	# if remainder is equal to 0 then go to increment even
	add $s3, $s3, 1		# When not even odds are incremented

AfterEven:
	
	#---------------------------
	# add the squared values
	#---------------------------
	# reference $t2 is now input square
	mult $t1, $t1	#square input
	mflo $t3		#grab the output
	add  $s4, $s4, $t3 # add to sum 

	b loop
#--------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------
# 							FUNCTIONS
#--------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------
SETMIN:
	move $s0, $t1 # make new input new min
	b AfterMin
	
SETMAX:
	move $s1, $t1 # make input new max
	b AfterMax
	
INCREMENTEVEN:
	add $s2, $s2, 1
	b AfterEven
	
#-------------------------------------------------------------------------------------------
# END Printout Part
#-------------------------------------------------------------------------------------------	
	
PrintOut:

	li $v0, 1
	move $a0, $s0 # set print item to minimum
	syscall
	
	# Print a line feed
    li 	      $v0, 11 	     # syscall 11 prints chracter stored in $a0
    addi      $a0, $0, 0xA   # ASCII code 10 is a line feed
    syscall
    
     # Print Max
    li $v0, 1
	move $a0, $s1 # set print item to max
	syscall
	
	# Print a line feed
    li 	      $v0, 11 	     # syscall 11 prints chracter stored in $a0
    addi      $a0, $0, 0xA   # ASCII code 10 is a line feed
    syscall
    
    #Print Even
    li $v0, 1
	move $a0, $s2 # set print item to even
	syscall
	
	# Print a line feed
    li 	      $v0, 11 	     # syscall 11 prints chracter stored in $a0
    addi      $a0, $0, 0xA   # ASCII code 10 is a line feed
    syscall
    
    #Print Odd
    li $v0, 1
	move $a0, $s3 # set print item to odd
	syscall
	
	# Print a line feed
    li 	      $v0, 11 	     # syscall 11 prints chracter stored in $a0
    addi      $a0, $0, 0xA   # ASCII code 10 is a line feed
    syscall
    
    #Print Sum
    li $v0, 1
	move $a0, $s4 # print out sum of squares
	syscall
	
EndProgram:
	li $v0, 10 # end program
	syscall

	
	
