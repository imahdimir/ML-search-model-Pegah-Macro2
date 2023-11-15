* master do file for the project of Van den berg
* Author:	Pegah Rahmani
* Date:		08/02/2020
* Update:	V1
/********************************************************************************
										GLOBALS
********************************************************************************/

clear all
set more off
set scheme s1color

global ML "C:\Users\Pegah\Desktop\ML Search Model"
global Dofiles "${ML}\code"
global RawData "${ML}\rawdata"
global Data "${ML}\data"
 
* HJ PC
global ML "C:\Users\Hossein Joshaghani\Dropbox (Personal)\Economics\Research\ML Search Model"
global Dofiles "${ML}\code"
global RawData "C:\Data\Search ML"
global Data "${ML}\data"

/********************************************************************************
										DO FILES
********************************************************************************
use "${RawData}\93.dta", clear
append using "${RawData}\92.dta"

do "${Dofiles}\clean.do"				// data cleaning

save "${Data}\MLE.dta", replace
*******************************************MLE**********************************/
use "${Data}\MLE.dta", clear

// MLE code for each parameter separately (landa0 landa1 delta), see args:
do "${Dofiles}\MLE1.do"

//Parenthesis in 'ml model' command define linear equations for parameters in 'args' respectively, except 'lnf'
//'Equ's are landa0, landa1, and delta, resoectively
do "${Dofiles}\MLE.do"
