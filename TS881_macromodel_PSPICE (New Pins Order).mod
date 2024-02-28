****************************************************************************
* WARNING : please consider following remarks before usage
*
* 1) All models are a tradeoff between accuracy and complexity (ie. simulation
* time).
* 2) Macromodels are not a substitute to breadboarding, they rather confirm the
* validity of a design approach and help to select surrounding component values.
*
* 3) A macromodel emulates the NOMINAL performance of a TYPICAL device within
* SPECIFIED OPERATING CONDITIONS (ie. temperature, supply voltage, etc.).
* Thus the macromodel is often not as exhaustive as the datasheet, its goal
* is to illustrate the main parameters of the product.
*
* 4) Data issued from macromodels used outside of its specified conditions
* (Vcc, Temperature, etc) or even worse: outside of the device operating
* conditions (Vcc, Vicm, etc) are not reliable in any way.
*
************************************************************************************  TS881  Spice macromodel subckt***
***  November 2012
****                      
************ CONNECTIONS: 
****                 NON-INVERTING INPUT
****                  |  INVERTING INPUT
****                  |   |     POSITIVE POWER SUPPLY
****                  |   |      |      NEGATIVE POWER SUPPLY
****                  |   |      |       |     OUTPUT  
****                  |   |      |       |      |     
****                  |   |      |       |      |  
.SUBCKT TS881   VP  VM  VCCP VCCN  VS
X_C_FALL V_VALORI_C_FALL 0 VREF V_C_FALL VCCAP_PSPICE
+PARAMS: CAP_scale={CAP_SCALE} Rserie=1
X_C_VOD V_VALORI_C_VOD 0 VB_D_VOD VREF VCCAP_PSPICE 
+PARAMS: CAP_scale={CAP_SCALE} Rserie=1.0
X_C_RISE V_VALORI_C_RISE 0 V_C_RISE VREF VCCAP_PSPICE
+PARAMS: CAP_scale={CAP_SCALE} Rserie=1
X_C_VCC V_VALORI_C_VCC 0 VB_D_VOD_VCC VREF VCCAP_PSPICE 
+PARAMS: CAP_scale={CAP_SCALE} Rserie=1
    M_NMOS2 VO_DIFF_PLUS VM VEE_N VCCN_ENHANCED MOS_N L={L} W={W}
    M_NMOS1 VO_DIFF_MINUS NET385 VEE_N VCCN_ENHANCED MOS_N L={L} W={W}
    IIN_BIAS_VM VM VREF DC 1p
    IEE_N VEE_N VCCN_ENHANCED DC {IEE}
    IIN_BIAS_VP VP VREF DC 1p
    V58 NET293 NET228 DC {VD_COMPENSAZIONE}
    V59 NET256 NET325 DC {VD_COMPENSAZIONE}
    VREADIO VB_4 VS DC 0
    VVLIM_LOW_VB NET349 NET234 DC {VD_COMPENSAZIONE}
    VPROT_IN_P_VCCP NET235 NET270 DC {V_DPROT}
    V_ENHANCE_VCCN VCCN_ENHANCED VCCN DC {VCCN_ENHANCE}
    VVLIM_HIGH_VB NET262 NET333 DC {VD_COMPENSAZIONE}
    V_ENHANCE_VCCP VCCP_ENHANCED VCCP DC {VCCP_ENHANCE}
    VPROT_IN_M_VCCN NET243 NET415 DC {V_DPROT}
    VPROT_IN_P_VCCN NET245 NET246 DC {V_DPROT}
    VPROT_IN_M_VCCP NET401 NET264 DC {V_DPROT}
    D40 NET228 VB_D_VOD DIODE_NOVd
    D_ENABLE_RISE VB_D_G_RF V_C_RISE DIODE_rf
    DILIM_SINK VB_3_SINK VB_3 DIODE_ILIM
    D41 VB_D_VOD NET256 DIODE_NOVd
    D_ENABLE_FALL V_C_FALL VB_D_G_RF DIODE_rf
    DILIM_SOURCE VB_3 VB_3_SOURCE DIODE_ILIM
    D3 VB_D_G NET262 DIODE_NOVd
    DPROT_IN_M_VCCP VM NET264 DIODE_VLIM
    D4 NET234 VB_D_G DIODE_NOVd
    DPROT_IN_M_VCCN NET243 VM DIODE_VLIM
    DPROT_IN_P_VCCP NET385 NET270 DIODE_VLIM
    DPROT_IN_P_VCCN NET245 NET385 DIODE_VLIM    
    C84 VM VP 350.00f    
    E_RO_3 VB_3 VB_4 VALUE={IF( I(VreadIo)>0
+,I(VreadIo)*V(Ro_3_val_VOH),I(VreadIo)*V(Ro_3_val_VOL) )}
    E_VDEP_SOURCE_2 VAL_VDEP_SOURCE_FILTERED 0
+VALUE={IF(V(val_vdep_source)>=0, 0, V(val_vdep_source))}

*    E_RO_3_VAL_VOL RO_3_VAL_VOL 0 PWL(1) VCCP VCCN ( 1.2 , 177.5 ) ( 2.7 ,
*+49.5 ) ( 5.0 , 26.3 )
    E_RO_3_VAL_VOL RO_3_VAL_VOL 0 VALUE={TABLE( V(VCCP,VCCN) , 1.2 , 177.5 , 2.7 ,
+49.5 , 5.0 , 26.3 )}

    E65 NET293 0 VCCN 0 1.0
    E_VDEP_SOURCE_1 VAL_VDEP_SOURCE 0 VALUE={( -28.95537757437066 +
+26.974065598779536*V(Vccp,Vccn) +
+2.14340198321892*V(Vccp,Vccn)*V(Vccp,Vccn))  -5000*I(VreadIo) }
    E_VDEP_SINK_3 VDEP_SINK 0 VALUE={IF( abs(I(VreadIo))<1m , 0 ,
+V(val_vdep_sink_filtered))}
    E_ICCSAT_LOW ICC_OUT_LOW 0 POLY(1) VCCP VCCN 2.661441647597253E-7
+-4.340198321891652E-9 2.822273073989316E-9
    C_VOD_FIXED VB_D_VOD VREF 86p
    
*    E_C_VOD V_VALORI_C_VOD 0 PWL(1) VP VM ( -100m , {0.01p/CAP_SCALE} ) (
*+-75m , {0.1p/CAP_SCALE} ) ( -50m , {45p/CAP_SCALE} ) ( -30m ,
*+{20p/CAP_SCALE} ) ( -10m , {2.5p/CAP_SCALE} ) ( -5m , {0.5p/CAP_SCALE} ) (
*++5m , {0.5p/CAP_SCALE} ) ( +10m , {13p/CAP_SCALE} ) ( +30m ,
*+{80p/CAP_SCALE} ) ( +50m , {150p/CAP_SCALE} ) ( +70m , {25p/CAP_SCALE}
*+) ( +100m , {1f/CAP_SCALE} )
    E_C_VOD V_VALORI_C_VOD 0 VALUE={TABLE( V(VP,VM) , -100m , 0.01p ,
+ -75m , 0.1p , -50m , 45p , -30m , 20p , -10m , 2.5p , -5m , 0.5p ,
+ +5m , 0.5p , +10m , 13p , +30m , 80p , +50m , 150p , +70m , 25p ,
+ +100m , 1f)/CAP_SCALE}

    E_VDEP_SINK_2 VAL_VDEP_SINK_FILTERED 0
+VALUE={IF(V(val_vdep_sink)<=0 , 0 , V(val_vdep_sink))}
    E_ICCSAT_HIGH ICC_OUT_HIGH 0 POLY(1) VCCP VCCN 1.72437070938215E-7
+1.2204424103740944E-10 1.678108314263917E-9

*    E_HYST_VAL HYST_VAL 0 PWL(1) VCCP VCCN ( 1.2 , 2.4m ) ( 2.7 , 2.7m ) (
*+5.0 , 3.1m )
    E_HYST_VAL HYST_VAL 0 VALUE={TABLE( V(VCCP,VCCN) , 1.2 , 2.4m , 2.7 , 2.7m ,
+5.0 , 3.1m )}

    E66 NET325 0 VCCP 0 1.0
    
*   E_RO_3_VAL_VOH RO_3_VAL_VOH 0 PWL(1) VCCP VCCN ( 1.2 , 228 ) ( 2.7 ,
*+74.5 ) ( 5.0 , 29 )
    E_RO_3_VAL_VOH RO_3_VAL_VOH 0 VALUE={TABLE( V(VCCP,VCCN) ,  1.2 , 228 , 2.7 ,
+74.5 , 5.0 , 29 )}

    EVLIM_HIGH_VB NET333 0 VCCP 0 1.0
    

*   E_C_VCC V_VALORI_C_VCC 0 TABLE {IF(V(VP,VM)>0,V(Vccp,Vccn),
*+-V(Vccp,Vccn))}=(-5 {18p/CAP_scale}) (-2.7 {7p/CAP_scale}) (-1.2
*+{1f/CAP_scale}) (1.2 {1f/CAP_scale}) (2.7 {8p/CAP_scale}) (5
*+{14p/CAP_scale})
    E_C_VCC  V_VALORI_C_VCC 0  VALUE={IF( V(VP,VM)>0, 
    +TABLE( V(VCCP,VCCN), 1.2 , 1f , 2.7 , 8p , 5 , 14p),
    +TABLE( V(VCCP,VCCN), 1.2 , 1f , 2.7 , 7p , 5 , 18p))/CAP_scale}  

    EILIM_SOURCE VB_3_SOURCE VDEP_SOURCE VB_3 0 1.0
    
*    E_C_FALL V_VALORI_C_FALL 0 PWL(1) VCCP VCCN ( 1.2 , {70.8p/CAP_SCALE}
*+) ( 2.7 , {82p/CAP_SCALE} ) ( 5.0 , {93.8p/CAP_SCALE} )
    E_C_FALL V_VALORI_C_FALL 0 VALUE={TABLE( V(VCCP,VCCN) , 1.2 , 70.8p ,
+ 2.7 , 82p , 5.0 , 93.8p)/CAP_SCALE}

    EVLIM_LOW_VB NET349 0 VCCN 0 1.0
    E2_REF NET417 0 VCCN 0 1.0
    
*    E_VIO VP NET358 PWL(1) VCCP VCCN ( 1.2 , 1m ) ( 2.7 , 1m ) ( 5.0 , 1m
*+)
    E_VIO VP NET358 VALUE={1m}
    
    EILIM_SINK VB_3_SINK VDEP_SINK VB_3 0 1.0
    E_VREF VREF 0 NET411 0 1.0
    E_VDEP_SOURCE_3 VDEP_SOURCE 0 VALUE={IF( abs(I(VreadIo))<1m , 0 ,
+V(val_vdep_source_filtered))}
    E1_REF NET373 0 VCCP 0 1.0
    
*    E_C_RISE V_VALORI_C_RISE 0 PWL(1) VCCP VCCN ( 1.2 , {62.2p/CAP_SCALE}
*+) ( 2.7 , {75p/CAP_SCALE} ) ( 5.0 , {100p/CAP_SCALE} )
    E_C_RISE V_VALORI_C_RISE 0 VALUE={TABLE( V(VCCP,VCCN) , 1.2 , 62.2p ,
+ 2.7 , 75p , 5.0 , 100p)/CAP_SCALE} 

    E_VDEP_SINK_1 VAL_VDEP_SINK 0 VALUE={(8.886727688787182
+-2.780320366132732*V(Vccp,Vccn)
+-6.979405034324943*V(Vccp,Vccn)*V(Vccp,Vccn) ) -5000*I(VreadIo) }
    E_HYST NET385 NET358 VALUE={IF( V(Vccp,Vccn)>=VCCMIN ,
++V(VS,Vref)/( V(Vccp,Vccn)/V(Hyst_val)) , 0 )}
    R_RISE_FALL VREF VB_D_G_RF {R_RISE_FALL}
    R_DELAY_VOD VREF VB_D_VOD {R_DELAY}
    R_ICCSAT_HIGH ICC_OUT_HIGH 0 1K
    RO_2 VB_3 VB_2 1m
    RO_1 VREF VB_2 {RO_1}
    RPROT_IN_P_VCCP NET235 VCCP 15K
    RPROT_IN_M_VCCP VCCP NET401 15K
    R_ICCSAT_LOW ICC_OUT_LOW 0 1K
    RD1 VCCP_ENHANCED VO_DIFF_MINUS {RD}
    RD2 VCCP_ENHANCED VO_DIFF_PLUS {RD}
    R_DELAY_VCC VREF VB_D_VOD_VCC {R_DELAY}
    R1_REF NET373 NET411 1Meg
    R_GAIN VB_D_G VREF {R1}
    RPROT_IN_M_VCCN VCCN NET415 15K
    R2_REF NET411 NET417 1Meg
    RPROT_IN_P_VCCN NET246 VCCN 15K
    G_IOUT_SOURCED VCCP 0 VALUE={IF(I(VreadIo)>0, I(VreadIo),0)}
    G_ICCSAT VCCP VCCN VALUE={IF( V(VS)>V(Vccp,Vccn)/2 ,
+V(Icc_out_high), V(Icc_out_low) ) }
    G_RISE_FALL VREF VB_D_G_RF VB_D_G VREF {1/R_RISE_FALL}
    G_GAIN VREF VB_D_G VB_D_VOD_VCC VREF 1
    G_DELAY_VOD VB_D_VOD VREF VO_DIFF_MINUS VO_DIFF_PLUS {1/R_DELAY}
    G_OUT VREF VB_2 VB_D_G_RF VREF {1/RO_1}
    G_IOUT_SINKED VCCN 0 VALUE={IF(I(VreadIo)>0, 0, I(VreadIo))}
    G_DELAY_VCC VB_D_VOD_VCC VREF VREF VB_D_VOD {1/R_DELAY}

*******************************************************************************
*
.PARAM CAP_scale=1e-15
.PARAM VCCMIN=1.0
.PARAM A0=10E+06 
.PARAM IEE=35n
.PARAM W=0.2u
.PARAM L=1u
.PARAM gm_mos=8.3763E-07
.PARAM RD=35k
.PARAM R_delay={RD}
.PARAM R1={A0/(gm_mos*RD)}
.PARAM Ro_1=20
.PARAM R_rise_fall=1000
.PARAM VCCP_enhance=150m
.PARAM VCCN_enhance=-1100m 
.PARAM V_DPROT=0
.PARAM Vd_compensazione=-788.4u
.MODEL MOS_N  NMOS LEVEL=1 VTO=+0.65  KP=100E-6
.MODEL DIODE_rf D LEVEL=1 IS=10E-15 N=0.1 CJO=10f 
.MODEL DIODE_NOVd D LEVEL=1 IS=10E-15 N=0.001
.MODEL DIODE_VLIM D LEVEL=1 IS=0.8E-15   
.MODEL DIODE_ILIM D LEVEL=1 IS=0.8E-15  
*
*******************************************************************************

.ENDS TS881



*******************************************************
******* SUBCKT VOLTAGE CONTROLLED CAPACITOR for SPICE
*******************************************************
.SUBCKT VCCAP_PSPICE Vctrl_plus Vctrl_minus Vout_plus Vout_minus  
+ PARAMS: CAP_scale=1u  Rserie=1
EVin 2 0 VALUE={1/V(Vctrl_plus,Vctrl_minus)}
EV2 8 Vout_plus POLY(2) 6 0 2 0 0 0 0 0 1 0 0 0 0 0
RR1 8 Vout_minus {Rserie}
GI1 0 6 Vout_minus 8 {1/Rserie}
RR2 0 6 100G 
CC1 6 0 {CAP_scale}  
.ENDS VCCAP_PSPICE
*********************************************************


