#Create Rational class in C++. It should include functions
#add_rational,
#sub_rational,
#mul_rational,
#div_rational,
#print_rational,
#Is_rational

#add_rational

.macro print_str(%str)
	.data
label: .asciiz %str
	.text
	li $v0, 4
	la $a0, label
	syscall
.end_macro
	
.macro print_reg(%reg)
	li $v0, 1
	add $a0, $zero, %reg
	syscall
.end_macro
	
.macro print_rational(%num_reg, %denom_reg) 
	print_str("rational(")
	print_reg(%num_reg)
	print_str("/")
	print_reg(%denom_reg)
	print_str(") ")
	

.end_macro 




.macro add_rational(%num1, %denom1, %num2,  %denom2, %new_num_reg, %new_denom_reg)
	li $t0, %num1 #load the first numerator
	li $t1, %denom2 #load the second denominator
	mul $t0, $t0, $t1 #get 32 bit product 
	
	li $t1, %num2	#load the second numerator
	li $t2, %denom1 #load the first denominator
	mul $t1, $t1, $t2 #get 32 bit product
	
	add %new_num_reg, $t0,$t1	#get the new numerator in new register	
	
	li $t0, %denom1
	li $t1, %denom2	#load the second denominator
	mul %new_denom_reg,$t0, $t1	#multiply the two denominaotors

	
.end_macro

.macro sub_rational(%num1, %denom1, %num2,  %denom2, %new_num_reg, %new_denom_reg)
	add_rational(%num1, %denom1, -%num2,%denom2, %new_num_reg, %new_denom_reg) #use add_rational macro with 1 negative numerator
.end_macro

.macro mul_rational(%num1, %denom1, %num2,  %denom2, %new_num_reg, %new_denom_reg)
	#multiply the numerators to get new numerator
	li $t0, %num1
	li $t1, %num2
	mul %new_num_reg, $t0, $t1
	#multiply the denominators to get new denominator
	li $t0,  %denom1
	li $t1, %denom2
	mul %new_denom_reg, $t0, $t1
.end_macro

.macro div_rational(%num1, %denom1, %num2,  %denom2, %new_num_reg, %new_denom_reg)
	#perform multiplication with one of the rational numbers flipped 
	mul_rational(%num1, %denom1, %denom2,  %num2, %new_num_reg, %new_denom_reg)
.end_macro

.macro print_arithmetic(%num1, %denom1, %num2,  %denom2, %new_num_reg, %new_denom_reg)
	li $t0,%num1
	li $t1, %num2
	print_rational($t0,$t1)
	print_str(" ")
	print_str(%op)
	print_str(" ")
	li $t0,%num2
	li $t1, %denom2
	print_rational($t0,$t1)
	print_str(" ")
	print_str(%op)
	print_str(" ")
	print_rational(%new_num_reg, %new_denom_reg)
	
	
.end_macro


.macro is_rational(%num1, %denom1)
	li $t0, %num1
	li $t1, %denom1
	print_rational($t0, $t1)
	beq $t1, $zero, not_rational
rational:
	print_str("rational :)\n")
	j end
not_rational:
	print_str("is not rational\n")
	j end
end:

.end_macro




	
	
add_rational(1,2,3,4,$s0,$s1)
print_rational(1,2)
print_str(" + ")
sub_rational(1,2,3,4,$s2,$s3)
mul_rational(1,2,3,4,$s4,$s5)
div_rational(1,2,3,4,$s6,$s7)


is_rational(3,4)
is_rational(10,8)
is_rational(1,0)
