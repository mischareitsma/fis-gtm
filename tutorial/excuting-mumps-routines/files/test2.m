	SET A=1,B=2,C=3
	WRITE "Going to calculate the sum of 1, 2 and 3",!
	DO SUM(A,B,C)
	QUIT
SUM(I,J,K)
	WRITE I+J+K,!
	QUIT
