#------------------------------------------------------
# Jake Muller
# Vector Sum 
# 9/20/19
# Takes in a number of vectors and adds them together
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

# Get C
	li $v0, 5 
	syscall
	move $s1, $v0 # moves Number of varables to saved register

#------------------------------------------------------
# Check to make sure initial values are safe
#------------------------------------------------------
	blt $s0, 0, EndProgram # Check Dimensions arent negative
	blt $s1, 0, EndProgram # Check Number of vectors arent negative
	
	# Make sure product of the two are not 1000
	mult $s0, $s1
	mflo $t1  #temparaly use $t1 to store value for words needed
	bgt $t1, 1000, EndProgram # if products of inputs is greater than 1000 then program is terminated
	
#------------------------------------------------------
# get all data from user
#------------------------------------------------------
	li $t2, 0 # initialize $t2 as counter varable
#	li $t7, 4 # get 4 to multipy 
# 	mult $t1, $t7 # multiply words needed by 4 to get bytes needed
# 	mflo $t1  # make $t1 bytes needed

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


#-------------------------------------------------------
# Add vectors together
#-------------------------------------------------------
	li $t2 , 0
 


	#crazy check
	li $v0, 1
	li $a0, 9999
	syscall
 

 
 
EndProgram:
 	li $v0, 10
 	syscall
 	
 	   .data
 	   .align 2 # 2^2=4 word alignment
 nums: .space 4000 # array of 1000 ( 4 bytes/word ) 
