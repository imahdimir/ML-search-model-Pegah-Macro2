destring id radif, replace 

replace id=mod(id,100000000)

gen temp=1 if D31==2 | D08==1 //Not in labor force and part-time
replace temp=1 if D11==1 | D11==2 | D11==3 | D11==7 | D11==8 | D11==9 | D11==10 //self-employed

egen temp1=max(temp), by(id radif)
drop if temp1==1
drop temp temp1

//save "data.dta", replace

//use "data.dta", clear

replace D01=0 if D01==.
replace D02=0 if D02==.
replace D03=0 if D03==.
replace D04=0 if D04==.
replace D05=0 if D05==.
replace D06=0 if D06==.
gen temp=D01+D02+D03+D04+D05+D06

gen unemp=1 if temp==12
replace unemp=0 if temp==1 | temp==3 | temp==5 | temp==7 | temp==9 | temp==11
drop temp D01 D02 D03 D04 D05 D06 D07
drop if age<15

drop D08 D28 D29 D30 D31 D16SHHAMRO D16SHHAMSA
drop D1_32 D2_32 D3_32 D4_32 D5_32 D6_32 D7_32 D8_32 D9_32 D33

destring D17,replace force
gen temp=1 if D17==3 | D17==4 | D17==5
egen temp1=max(temp), by(id radif)
drop if temp1==1
drop temp temp1

drop D17 D18SHANBEH D18YEKSHAN D18DOSHANB D18SESHANB D18CHARSHA D18PANSHAN D18JOMEH D18JAM D19 D20
sort id radif year season

//save "data1.dta", replace

//use "data1.dta", clear

drop relation birthmonth birthyear D45
drop citizenship residence resduration preresidence migcause preresname abroadres
drop edufield education
drop D15MAH D15SAL age2 s2 age_s exp2 // exp: experience

destring D47 D46, replace force
gen temp=1 if D47==1 | D47==2 | D47==3 | D47==4 | D47==5 | D46==1 | D46==2 | D46==3 | D46==4 | D46==5
egen temp1=max(temp), by(id radif)
drop if temp1==1
drop temp temp1 D47 D46

destring D49, replace force
gen temp=1 if D49==1
egen temp1=max(temp), by(id radif)
drop if temp1==1
drop temp temp1 D49

drop STATUS VERSION1 VERSION2 VERSION3 VERSION4 USER1CODE USER2CODE USER3CODE USER4CODE DATAENTRYF VERIFERROR DATE1 DATE2 DATE3 DATE4 _merge w3radif w3sex w3age W1 W2_1 W2_2 W3 TABAGHEH A_STRATA AFRAD SHAGHEL BIKAR clus hhid hhid3 currnetjob_mah jobhistory_mah
drop enter unemployed searchjob_mah exit employed enter_ur enter_ur_se edugroup enter_ur_se_edu agegroup enter_ur_se_ag enter_ur_se_act
drop activity activity_rv5 activitygroup_rv5 enter_ur_se_act_rv5 activitygroup
sort id radif year season
drop status4 status5
egen co=count(radif), by(id radif) // transitions summary

destring D09 D10, replace force
drop if unemp==0 & unemp[_n+1]==0 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n] & D09[_n+1]==D09[_n] & D10[_n+1]==D10[_n]
drop co
egen co=count(radif), by(id radif)
egen num=rank(co), by(id radif) unique

destring Student, replace force
gen temp=1 if Student==1
egen temp1=max(temp), by(id radif)
drop if temp1==1
drop temp temp1 Student

drop co num
egen co=count(radif), by(id radif)
egen num=rank(co), by(id radif) unique

drop if unemp==1 & co>2 & num==2 & unemp[_n+1]==1 & unemp[_n-1]==1

drop co num
egen co=count(radif), by(id radif)
egen num=rank(co), by(id radif) unique

drop if unemp==1 & co>2 & num==2 & unemp[_n+1]==0 & unemp[_n-1]==1

drop co num
egen co=count(radif), by(id radif)
egen num=rank(co), by(id radif) unique

drop if unemp==1 & num!=1 & unemp[_n+1]==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]

drop co num
egen co=count(radif), by(id radif)
egen num=rank(co), by(id radif) unique

gen temp=1 if id[_n+1]==id[_n] & radif[_n+1]==radif[_n] & age[_n+1]-age[_n]>1  // some individuals and households may have been changed
replace temp=1 if id[_n+1]==id[_n] & radif[_n+1]==radif[_n] & sex[_n+1]!=sex[_n]
egen temp1=max(temp), by(id radif)
drop if temp1==1
drop temp temp1

drop co num
egen co=count(radif), by(id radif)
egen num=rank(co), by(id radif) unique

//save "MLEData1.dta", replace

//use "MLEData1.dta", clear

gen interview_unemp=0 if num==1
replace interview_unemp=1 if num==1 & unemp==1
tabulate co interview_unemp

drop PKEY
//replace wage=0 if wage<0
drop if wage<=0

gen D09_2=D09[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D10_2=D10[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D11_2=D11[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D12_2=D12[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D13_2=D13[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D14SAL_2=D14SAL[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D14MAH_2=D14MAH[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D16SHASLIR_2=D16SHASLIR[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D16SHASLIS_2=D16SHASLIS[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D21_2=D21[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D22_2=D22[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D23_2=D23[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D24_2=D24[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D25_2=D25[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D26_2=D26[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D27ROZ_2=D27ROZ[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D27SAAT_2=D27SAAT[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D34_2=D34[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D35SAL_2=D35SAL[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D35MAH_2=D35MAH[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D36_2=D36[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D37SAL_2=D37SAL[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D37MAH_2=D37MAH[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D38_2=D38[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D39_2=D39[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D40SAL_2=D40SAL[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D40MAH_2=D40MAH[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D41_2=D41[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D42_2=D42[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D43_2=D43[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D44_2=D44[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D48SAAT_2=D48SAAT[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D48ROZ_2=D48ROZ[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen D50_2=D50[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen year_2=year[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen season_2=season[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen prov_2=prov[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen schooling_2=schooling[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen exp_2=exp[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen wage_2=wage[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]
gen unemp_2=unemp[_n+1] if num==1 & id[_n+1]==id[_n] & radif[_n+1]==radif[_n]

gen D09_3=D09[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D10_3=D10[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D11_3=D11[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D12_3=D12[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D13_3=D13[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D14SAL_3=D14SAL[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D14MAH_3=D14MAH[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D16SHASLIR_3=D16SHASLIR[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D16SHASLIS_3=D16SHASLIS[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D21_3=D21[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D22_3=D22[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D23_3=D23[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D24_3=D24[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D25_3=D25[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D26_3=D26[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D27ROZ_3=D27ROZ[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D27SAAT_3=D27SAAT[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D34_3=D34[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D35SAL_3=D35SAL[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D35MAH_3=D35MAH[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D36_3=D36[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D37SAL_3=D37SAL[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D37MAH_3=D37MAH[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D38_3=D38[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D39_3=D39[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D40SAL_3=D40SAL[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D40MAH_3=D40MAH[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D41_3=D41[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D42_3=D42[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D43_3=D43[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D44_3=D44[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D48SAAT_3=D48SAAT[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D48ROZ_3=D48ROZ[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen D50_3=D50[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen year_3=year[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen season_3=season[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen prov_3=prov[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen schooling_3=schooling[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen exp_3=exp[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen wage_3=wage[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]
gen unemp_3=unemp[_n+2] if num==1 & id[_n+2]==id[_n] & radif[_n+2]==radif[_n]

drop if num==2 | num==3 | num==4
drop num

gen private=0
replace private=1 if D11==4
gen public=0
replace public=1 if D11==5

gen t0b=D35SAL*12+D35MAH
drop if t0b==. & unemp==1
replace t0b=0 if t0b==.
gen d0b=0

gen t0f=0 if unemp==1 & co==1
gen d0f=1 if unemp==1 & co==1
replace t0f= 12 * year_2 + 3 * season_2 - 12 * year - 3 * season if unemp==1 & unemp_2==1 & co==2
replace d0f=1 if unemp==1 & unemp_2==1 & co==2
replace t0f=12*year_2+3*season_2-12*year-3*season-12*(D14SAL_2-1)-D14MAH_2 if unemp==1 & unemp_2==0
replace t0f=0 if t0f<0 &unemp==1 & unemp_2==0
replace d0f=0 if unemp==1 & unemp_2==0
drop if t0f==. & unemp==1
drop if d0f==. & unemp==1
replace t0f=0 if t0f==.
replace d0f=1 if d0f==.

gen d1=1
replace d1=0 if wage_2!=.

gen t1=12*D14SAL_2+D14MAH_2 if unemp==1 & unemp_2==0 & co==2
gen d2=1 if unemp==1 & unemp_2==0 & co==2
gen d3=1 if unemp==1 & unemp_2==0 & co==2
replace t1=12*D14SAL_2+D14MAH_2+12*year_3+3*season_3-12*year_2-3*season_2-D35SAL_3*12-D35MAH_3 if unemp==1 & unemp_2==0 & co>2 & unemp_3==1
replace d2=0 if unemp==1 & unemp_2==0 & co>2 & unemp_3==1
replace d3=0 if unemp==1 & unemp_2==0 & co>2 & unemp_3==1
gen d4=0 if unemp==1 & unemp_2==0 & co>2 & unemp_3==1
replace t1=12*D14SAL_2+D14MAH_2+12*year_3+3*season_3-12*year_2-3*season_2-12*(D14SAL_3-1)-D14MAH_3 if unemp==1 & unemp_2==0 & co>2 & unemp_3==0
replace t1=0 if t1<0
replace d2=0 if unemp==1 & unemp_2==0 & co>2 & unemp_3==0
replace d3=0 if unemp==1 & unemp_2==0 & co>2 & unemp_3==0
replace d4=1 if unemp==1 & unemp_2==0 & co>2 & unemp_3==0

replace t1=0 if t1==.
replace d2=1 if d2==.
replace d3=1 if d3==.
replace d4=0 if d4==.

gen t1b=12*D14SAL+D14MAH if unemp==0
gen d6b=0
drop if t1b==. & unemp==0
replace t1b=0 if t1b==.

gen t1f=0 if unemp==0 & co==1
gen d6f=1 if unemp==0 & co==1
replace t1f=12*year_2+3*season_2-12*year-3*season-D35SAL_2*12-D35MAH_2 if unemp==0 & unemp_2==1
replace d6f=0 if unemp==0 & unemp_2==1
replace t1f=12*year_2+3*season_2-12*year-3*season-12*(D14SAL_2-1)-D14MAH_2 if unemp==0 & unemp_2==0
replace d6f=0 if unemp==0 & unemp_2==0
drop if t1f==. & unemp==0
replace t1f=0 if t1f==.
replace d6f=1 if d6f==.
replace t1f=0 if t1f<0

gen d7=1
replace d7=0 if unemp==0 & co>1

gen d8=0
replace d8=1 if unemp==0 & unemp_2==0

gen t0=D35SAL_2*12+D35MAH_2 if unemp==0 & unemp_2==1 & co==2
gen d9=1 if unemp==0 & unemp_2==1 & co==2
replace t0=D35SAL_2*12+D35MAH_2+12*year_3+3*season_3-12*year_2-3*season_2-(D14SAL_3-1)*12-D14MAH_3 if unemp==0 & unemp_2==1 & co>2
replace d9=0 if unemp==0 & unemp_2==1 & co>2
drop if t0==. & unemp==0 & unemp_2==1
replace t0=0 if t0==.
replace d9=1 if d9==.
replace t0=0 if t0<0

gen d10=0
replace d10=1 if wage_2==.

gen t2=D14SAL_2*12+D14MAH_2 if unemp==0 & unemp_2==0 & co==2
gen d11=1 if unemp==0 & unemp_2==0 & co==2
gen d12=1 if unemp==0 & unemp_2==0 & co==2
gen d13=0 if unemp==0 & unemp_2==0 & co==2

replace t2=12*year_3+3*season_3-12*year_2-3*season_2+D14SAL_2*12+D14MAH_2-D35SAL_3*12-D35MAH_3 if unemp==0 & unemp_2==0 & co>2 & unemp_3==1
replace d11=0 if unemp==0 & unemp_2==0 & co>2 & unemp_3==1
replace d12=0 if unemp==0 & unemp_2==0 & co>2 & unemp_3==1
replace d13=0 if unemp==0 & unemp_2==0 & co>2 & unemp_3==1

replace t2=12*year_3+3*season_3-12*year_2-3*season_2+D14SAL_2*12+D14MAH_2-(D14SAL_3-1)*12-D14MAH_3 if unemp==0 & unemp_2==0 & co>2 & unemp_3==0
replace d11=0 if unemp==0 & unemp_2==0 & co>2 & unemp_3==0
replace d12=0 if unemp==0 & unemp_2==0 & co>2 & unemp_3==0
replace d13=1 if unemp==0 & unemp_2==0 & co>2 & unemp_3==0
drop if t2==. & unemp==0 & unemp_2==0
replace t2=0 if t2==.
replace d11=1 if d11==.
replace d12=1 if d12==.
replace d13=0 if d13==.
replace t2=0 if t2<0


gen test=1 if wage==. & unemp==0
gen test1=1 if wage_2==. & unemp_2==0
drop if test==1 | test1==1
drop test test1
replace wage=0 if wage==.
replace wage_2=0 if wage_2==.

drop if schooling==.

keep id radif sex age literate maritalstatus schooling exp unemp wage unemp_2 wage_2 interview_unemp private public t0b d0b t0f d0f d1 t1 d2 d3 d4 t1b d6b t1f d6f d7 d8 t0 d9 d10 t2 d11 d12 d13

