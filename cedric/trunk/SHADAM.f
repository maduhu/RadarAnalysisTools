      SUBROUTINE SHADAM (XCS,YCS,NCS,IAI,IAG,NAI)
C
C     DOES SHADING BY CHECKING THAT THE GROUP # IS THREE (FROM CONTOURS)
C     AND THE AREA IDENT. # IS BETWEEN 1 AND 61(THE MAX # OF LEVELS)

      PARAMETER (MAXLEV=61)
      COMMON /COLORS/ ICOL(MAXLEV),IAIM
      DIMENSION XCS(*),YCS(*),IAI(*),IAG(*)
      DIMENSION DST(8000),IND(9000),IPAT(4)
      DATA IPAT/12,16,20,7/
C
C     IPAT SPECIFIES THE THREE DOT DENSITIES THAT WILL BE USED FOR THE PLOTS
C

      ISH=0

      DO 101 I=1,NAI
         IF (IAG(I).EQ.3.AND.IAI(I).GT.IAIM.AND.IAI(I).LE.MAXLEV) 
     X        ISH=IAI(I)
 101  CONTINUE
      
      IF (ISH.NE.0) CALL SFSGFA (XCS,YCS,NCS,DST,8000,IND,9000,
     X                           IPAT(ICOL(ISH-1)))


      RETURN

      END
