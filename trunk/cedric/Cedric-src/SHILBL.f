      SUBROUTINE SHILBL(NAME,NNAM)
C
C     SHIFT DATA 16 PLACES LEFT AND ZERO FILL
C
      INCLUDE 'CEDRIC.INC'
      DIMENSION NAME(NNAM)
      NUMSHFT=WORDSZ-16
      DO 100 I=1,NNAM
         NAME(I)=ICEDSHFT(NAME(I),NUMSHFT)
C         NAME(I)=RSHIFT(NAME(I),NUMSHFT)
 100  CONTINUE
      RETURN
      END
      