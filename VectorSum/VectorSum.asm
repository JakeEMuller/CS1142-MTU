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
	mflo $t1  #temparaly use $t1 to store value
	bgt $t1, 1000, EndProgram # if products of inputs is greater than 1000 then program is terminated
	
	
	
	
	#crazy check
	li $v0, 1
	li $a0, 9999
	syscall
 

 
 
EndProgram:
 	li $v0, 10
 	syscall
 	
 .data
 