	.option nopic
	.text
	.align	3
.LC0:
	.string "%lld\n"
	.text
	.align 1
	.globl	main
	.type	main, @function
.LC1:
	.string "%lld"
	.align 3
.LC2:
	.string "%lld "
	.align 3
.LC3:
	.string "\n"
	.align 3
main:
	addi x2,x2,-32
	sd	x1,24(x2)
	sd	x8,16(x2)
	addi x8,x2,32
	
	#begin
input:
    add x11, x8, zero
    lui x15,%hi(.LC1)
    addi x10,x15,%lo(.LC1)
    call scanf

    ld x10, 0(x8)
    addi x5,x0,99
    blt x5,x10,input #input大於99需要再輸入一次

	addi x2,x2,-16
	sd x20,0(x2)
	sd x21,8(x2)
	addi x28,x10,0
	addi x7,x0,5 #x7=5
	addi x31,x0,2 #x31=2
recursive:
	addi x2,x2,-16
	sd x1,8(x2)
	sd x10,0(x2)
	addi x5,x0,20 
	blt x5,x10,return1 #when x>20, jump to return1
	addi x5,x0,10 
	blt x5,x10,return2 #when 10<x<=20, jump to return2
	addi x5,x0,1 
	blt x5,x10,return3 #when 1<x<=10, jump to return3
	beq x10,x0,return4 #when x=0, jump to return4
	beq x10,x5,return5 #when x=1, jump to return5
	#when x<0, output -1
	addi x11,x0,-1 
	addi x2,x2,16
	jal x0,output
	
return1: #x>20
	ld x10,0(x2)
	div x10,x10,x7 		#x10=x/5
	jal x1,recursive 	#F(x/5)
	addi x20,x11,0
	mul x11,x31,x28 	#x11=2*x
	add x11,x11,x20
	ld x29,0(x2)
	addi x2,x2,16
	beq x28,x29,output  #when equal input value, jump to output
	jalr x0,0(x1)
return2: #10<x<=20
	ld x10,0(x2)
	addi x10,x10,-2 	#x10=x-2
	jal x1,recursive 	#x11=F(x-2)
	addi x2,x2,-8
	sd x11,0(x2) 
	ld x10,8(x2)
	addi x10,x10,-3 	#x10=x-3
	jal x1,recursive 	#x11=F(x-3)
	ld x21,0(x2)
	add x11,x11,x21 	#F(x-2)+F(x-3)
	ld x1,16(x2)
	ld x29,8(x2)
	addi x2,x2,24
	beq x28,x29,output
	jalr x0,0(x1)
return3: #1<x<=10
	ld x10,0(x2)
	addi x10,x10,-1 	#x10=x-1
	jal x1,recursive 	#x11=F(x-1)
	addi x2,x2,-8
	sd x11,0(x2) 
	ld x10,8(x2)
	addi x10,x10,-2 	#x10=x-2
	jal x1,recursive 	#x11=F(x-2)
	ld x30,0(x2)
	add x11,x11,x30 	#F(x-1)+F(x-2)
	ld x1,16(x2)
	ld x29,8(x2)
	addi x2,x2,24
	beq x28,x29,output  #when equal input value, jump to output
	jalr x0,0(x1)
return4: #x=0
	addi x11,x0,1
	ld x29,0(x2)
	addi x2,x2,16
	beq x28,x29,output  #when equal input value, jump to output
	jalr x0,0(x1)
return5: #x=1
	addi x11,x0,5
	ld x29,0(x2)
	addi x2,x2,16
	beq x28,x29,output  #when equal input value, jump to output
	jalr x0,0(x1)

output:
    addi x11, x11, 0
    lui x15,%hi(.LC0)    
    addi x10,x15,%lo(.LC0)
    call printf
    
    addi x2,x2,16
	#end

	li	x15,0
	mv	x10,x15
	ld	x1,24(x2)
	ld	x8,16(x2)
	addi x2,x2,32
	jr	x1
	.size	main, .-main
	.ident	"GCC: (GNU) 7.2.0"
