.data
m1: .asciiz "Enter the number of process : \n"
m2: .asciiz "\n"
arrival: .asciiz "\nEnter the arrival time\n"
burst: .asciiz "Enter the burst time\n"
m3: .asciiz "Average Turnaroundtime is   "
m5: .asciiz "Average waiting time is  "
fcfs: .asciiz"\nFCFS\n"
sjf: .asciiz"\nSJF Non-preemptive\n"
arr1: .word 0:100
arr2: .word 0:100
arr3: .word 0:100
.text
la $a0,m1
li $v0,4
syscall
li $v0,5
syscall
move $t0,$v0
mul $t1,$t0,4
li $t2,0
li $t3,0

li $v0,4
la $a0,arrival
syscall

array:
beq $t2,$t1,array1
li $v0,5
syscall
sw $v0,arr1($t2)
addi $t2,$t2,4
j array

array1:
#la $a0,m1
#li $v0,4
#syscall
#li $v0,5
#syscall
#move $t0,$v0
#mul $t5,$t0,4
li $t2,0
li $t3,0
li $t4,0
li $t6,0
li $v0,4
la $a0,burst
syscall

j array2

array2:
beq $t2,$t1,set
li $v0,5
syscall
move $s1,$v0
sw $s1,arr2($t2)
add $t6,$t6,$s1
sw $t6,arr3($t2)
addi $t2,$t2,4
j array2

print1:
beq $t3,$t1,array1
lw $a0,arr1($t3)
li $v0,1
syscall
addi $t3,$t3,4
j print1

print2:
beq $t4,$t5,set
lw $a0,arr3($t4)
li $v0,1
syscall
addi $t4,$t4,4
j print2

set:
li $t2,0
li $t3,0
li $t4,0
li $t6,0
j tat

tat:
beq $t2,$t1,print3
lw $s0,arr3($t2)
lw $s1,arr1($t2)
lw $s3,arr2($t2)
sub $t3,$s0,$s1
add $t4,$t4,$t3
sub $t3,$t3,$s3
add $t6,$t6,$t3
addi $t2,$t2,4
j tat

print3:
mtc1 $t4,$f0
mtc1 $t0,$f1

li $v0,4
la $a0,m3
syscall
div.s $f12,$f0,$f1
li $v0,2
syscall

li $v0,4
la $a0,m2
syscall

mtc1 $t6,$f0
mtc1 $t0,$f1
li $v0,4
la $a0,m5
syscall
div.s $f12,$f0,$f1
li $v0,2
syscall
j set1
set1:
li $t2,0
li $t6,0
li $t7,0
li $t8,0
li $t9,0
move $t0,$t1
li $t1,0
li $t4,0
j while1

while1:
   beq $t2,$t0,printt
   lw $t6,arr2($t2)
   lw $t1,arr1($t2)
   move $s1,$t2
   li $t3,0
   addi $t2,$t2,4
   j while2  
   
 while2:
   beq $t3,$t0,while1
   lw $t8,arr2($t3)
   lw $t9,arr1($t3)
   move $s2,$t3
   addi $t3,$t3,4
   bgt $t6,$t8,while2
   add $t7,$zero,$t6
   add $t6,$zero,$t8
   add $t8,$zero,$t7
   sw $t6,arr2($s1)
   sw $t8,arr2($s2)
   add $t7,$zero,$t1
   add $t1,$zero,$t9
   add $t9,$zero,$t7
   sw $t1,arr1($s1)
   sw $t9,arr1($s2)
   j while2

printt:
li $v0,4
la $a0,m2
syscall
 beq $t4,$t0,printt1
lw $a0,arr2($t4)
li $v0,1
syscall
addi $t4,$t4,4
li $t2,0
j printt

printt1:
li $v0,4
la $a0,m2
syscall
 beq $t2,$t0,tatt
lw $a0,arr1($t2)
li $v0,1
syscall
addi $t2,$t2,4
j printt1

tatt:
li $s0,0
li $s1,0
li $s3,0
li $s2,0
li $t3,0
li $t4,0
li $t6,0
li $t2,0
j tatt1
tatt1:
beq $t2,$t0,pt2
lw $s2,arr3($t2)
lw $s1,arr1($t2)
lw $s3,arr2($t2)
sub $t3,$s2,$s1
add $t4,$t4,$t3
sub $t3,$t3,$s3
add $t6,$t6,$t3
addi $t2,$t2,4
j tatt1
pt2:
li $v0,4
la $a0,fcfs
syscall

printt2:
mtc1 $t4,$f0
mtc1 $t0,$f1

li $v0,4
la $a0,m3
syscall
div.s $f12,$f0,$f1
li $v0,2
syscall

li $v0,4
la $a0,m2
syscall

mtc1 $t6,$f0
mtc1 $t0,$f1
li $v0,4
la $a0,m5
syscall
div.s $f12,$f0,$f1
li $v0,2
syscall
j exit

exit:
li $v0,10
syscall

