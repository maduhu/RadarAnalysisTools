      SUBROUTINE GET3D(IEDFL,IBUF,OBUF,NX,NY,NZ,IFLD,JFLD,
     X                 NEWJ,MISV,A,IWIND,NST)
C
C        BUILDS A 3-D DATASET OF A SINGLE FIELD INTO THE WINDOWED REGION.
C               INVERSE OPERATION OF PUT3D.
C
C       IEDFL- LOGICAL UNIT NUMBER OF THE EDIT FILE
C        IBUF- SCRATCH BUFFER FOR I/O TRANSFER
C        OBUF- 2-D ARRAY USED TO TRANSFER THE DATA FROM INDIVIDUAL PLANES
C          NX- NUMBER OF POINTS ALONG THE X-AXIS (FULL VOLUME)
C          NY- NUMBER OF POINTS ALONG THE Y-AXIS (FULL VOLUME)
C          NZ- NUMBER OF POINTS ALONG THE Z-AXIS (FULL VOLUME)
C        IFLD- INDEX OF THE  INPUT FIELD IN THE ID HEADER
C        JFLD- INDEX OF THE OUTPUT FIELD IN THE ID HEADER
C        NEWJ- LOGICAL FLAG THAT IS SET TRUE WHENEVER JFLD IS NEWLY CREATED
C        MISV- LOGICAL FLAG SET TO TRUE IF OUTPUT FIELD IS TO HAVE
C              MISSING VALUES AT SAME LOCATION OF THE INPUT FIELD.
C              (INACTIVE IN THIS ROUTINE --HERE FOR COMPATIBILITY)
C           A- BUFFER CONTAINING DATA FROM THE 3-D WINDOWED REGION
C       IWIND- INDICES OF THE WINDOWED REGION IN CONTEXT OF THE FULL VOLUME
C         NST- STATUS FLAG; =0 OK, =1 I/O TRANSFER PROBLEMS.
C
C
      INCLUDE 'CEDRIC.INC'
      DIMENSION A(1),IBUF(1),OBUF(NX,NY),IWIND(2,3)
      COMMON /VOLUME/ INPID(NID),ID(NID),NAMF(4,NFMAX),SCLFLD(NFMAX),
     X                IRCP(NFMAX),MAPVID(NFMAX,2),CSP(3,3),NCX(3),
     X                NCXORD(3),NFL,NPLANE,BAD
      CHARACTER*2 NAMF
      LOGICAL NEWJ,MISV
C
C        GET INDICES OF THE WINDOWED REGION
C
      I1=IWIND(1,1)
      I2=IWIND(2,1)
      J1=IWIND(1,2)
      J2=IWIND(2,2)
      K1=IWIND(1,3)
      K2=IWIND(2,3)
C
C        LOAD IN THE (X,Y,Z) ARRAY
C
      L=0
      DO 30 K=K1,K2
         CALL FETCHD(IEDFL,ID,K,IFLD,IBUF,OBUF,NIX,NIY,
     X               3,BAD,ZLEV,NST)
         IF(NST.NE.0) GO TO 90
         DO 20 J=J1,J2
            DO 15 I=I1,I2
               L=L+1
               A(L)=OBUF(I,J)
   15       CONTINUE
   20    CONTINUE
   30 CONTINUE
C
C        RETURN BRANCH
C
   90 CONTINUE
      RETURN
      END