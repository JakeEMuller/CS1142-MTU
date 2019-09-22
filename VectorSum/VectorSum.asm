#------------------------------------------------------
# Jake Muller
# Jemller
# Vector Sum 
# 9/20/19
# Takes in a number of vectors and adds them together
# using arrays and incrementing through specific bytes
#------------------------------------------------------
.text
#------------------------------------------------------
# Initialize Varables
#------------------------------------------------------

	li $s0, 0 #$s0 is D (Dimensionality of each vector "amount of numbers each vector holds" )
	li $s1, 0 #$s1 is N (Number of Vectors)
	li $t1, 0 #$t1 is number words needed then converted to number of bytes needed
 
#-----------------------------------------------------
# Get Initial Inputs
#-----------------------------------------------------
 
# Get D
	li $v0, 5 #reads first integer
	syscall
	move $s0, $v0 # moves dimensions to saved register
	ble $s0, $0, EndProgram # Check Dimensions arent negative
	bgt $s0, 1000, EndProgram # if initial value is greater than 1000 terminate
	
# Get N
	li $v0, 5 
	syscall
	move $s1, $v0 # moves Number of varables to saved register
	ble $s1, $0, EndProgram # Check Number of vectors arent negative
	bgt $s1, 1000, EndProgram # in second value is greater than 1000 terminate
	
#------------------------------------------------------
# Check to make sure initial values are safe
#------------------------------------------------------
	# Make sure product of the two are not 1000
	mult $s0, $s1
	mflo $t1  #temparaly use $t1 to store value for words needed
	bgt $t1, 1000, EndProgram # if products of inputs is greater than 1000 then program is terminated
	
#------------------------------------------------------
# get all data from user
#------------------------------------------------------
	li $t2, 0 # initialize $t2 as counter varable

# Loop through input to get all data
loop:

	bge $t2, $t1, done # if all words are filled then go to done
	li $v0, 5	#read input from the user
	syscall
	add $t3, $t2, $t2 # $t3 <- i + i
	add $t3, $t3, $t3 # $t3 <- 2i + 2i
	sw $v0, nums($t3) #store word in nums
	addi $t2, $t2, 1  #increment counter
	b loop

done:

TimeToAdd:
#-------------------------------------------------------
# Find what vectors the user wants to add together
#-------------------------------------------------------
	li $s3, 0  # index value of the first vector
	li $s4, 0  # index value of the second vector

	li $v0 ,5 # Get first index value from user
	syscall
	move $s3, $v0 # move value from abritray register to initialized one
	sw $s3, vectors
	
	# Check if index values are within bounds 
	blt $s3, $0, EndProgram # test index one is less than 0
	bge $s3, $s1, EndProgram # test index 1 is more then number of vectors
	
	
	li $v0, 5  #get second index value from the user
	syscall
	move $s4, $v0 # move value from abritray register to initialized one
	sw $s4, vectors+4
	
	# Check if index values are within bounds 
	blt $s4, $0, EndProgram # test index two is less than 0
	bge $s4, $s1, EndProgram # test index two is more than number of vectors
	

	
#-------------------------------------------------------
# Add vectors together
#-------------------------------------------------------
	li $s5, 0  # $s5 is the sum for each vector component 
	li $t4, 0  # $t4 is the counter for vector summing
	li $t5, 0 
	li $s7, 4  # use this as a multiply by 4
# add Vectors together
SumLoop:
	
	bge $t4, $s0, SumComplete # If counter is greater than dementions then end loop
	
	mult $s0, $s3 # multipy index by the demention
	mflo $t5
	add $t5, $t5, $t4 # add the offset for element in array
	mult $t5, $s7 # multiply $t5 by 4
	mflo $t5
	
	lw $s5, nums($t5) # load element of vector into sum
	
	mult $s0, $s4 # multipy index by the demention
	mflo $t6
	add $t6, $t6, $t4 #add the offset for element in array
	mult $t6, $s7 # multipy $t6 by 4
	mflo $t6	
	
	lw $t7, nums($t6) # load element of vector into arbitary value
	add $s5, $s5, $t7
	
	# print element of array
	li $v0, 1 
	move $a0, $s5 # move sum to syscall print register
	syscall 		# print 
	
	#print space in array
	li $v0, 11
	addi $a0, $0, 32
	syscall
	
	addi $t4, $t4, 1 # increment counter 
	
	b SumLoop
	
SumComplete:

	#print line Feed	
	li      $v0, 11      # syscall 11 prints character in $a0
    addi    $a0, $0, 10  # ASCII code 10 is a line feed
    syscall
    
#-----------------------------
# go back to adding vectors
#-----------------------------
	b TimeToAdd
	
	#crazy check
#	li $v0, 1
#	li $a0, 9999
#	syscall
 

 
 
EndProgram:
 	li $v0, 10
 	syscall
 	
 	   .data
 	   .align 2 # 2^2=4 word alignment
 nums: .space 4000 # array of 1000 ( 4 bytes/word ) 
 vectors: .word 0, 0
