program define myml22
	version 1.1
	args lnf landa0 landa1 delta
	tempvar wup1 wlow1 wup2 wlow2 prod1 prod2 Fw1 Fw2 fw2 gw1 uprob eprob
	//quietly gen double `landa0' = 0.04
	//quietly gen double `landa1' = 0.05
	quietly gen double `wup1' = 62846960+1
	quietly gen double `wlow1' = 20020.51-1
	quietly gen double `wup2' = 59253436+1
	quietly gen double `wlow2' = 7322.637-1
	quietly gen double `prod1' = (`wup1'-`wlow1'*((`delta'/(`delta'+`landa1'))^2))/(1-(`delta'/(`delta'+`landa1'))^2)
	quietly gen double `prod2' = (`wup2'-`wlow2'*((`delta'/(`delta'+`landa1'))^2))/(1-(`delta'/(`delta'+`landa1'))^2)
	quietly gen double `Fw1' =(`delta'+`landa1')*(1-((`prod1'-wage)/`prod1')^0.5)/`landa1'	
	quietly gen double `Fw2' =(`delta'+`landa1')*(1-((`prod2'-wage_2)/`prod2')^0.5)/`landa1'
	quietly gen double `fw2' =(`delta'+`landa1')/(2*`landa1'*((abs(`prod2'-wage_2))^0.5)*(`prod2'^0.5))	
	quietly gen double `gw1' =(`delta'*(`prod1'^0.5))/(2*`landa1'*((`prod1'-wage)^1.5))	
	quietly gen double `uprob' =`delta'/(`delta'+`landa0')
	quietly gen double `eprob' =`landa0'/(`delta'+`landa0')
	//quietly gen double `ps'= ln(`fw2') - ln(1-`Fw1')+ d12*(1-d11)*ln(`delta'+`landa1'*(1-`Fw2')) - t2*(`delta'+`landa1'*((`delta'+`landa1')*((`prod2'-wage)^0.5)/(`landa1'*`prod2'^0.5)-1)) +(1-d13)*(1-d12)*(1-d11)*ln(`delta') +d13*(1-d12)*(1-d11)*ln(`landa1'*((`delta'+`landa1')*((`prod2'-wage)^0.5)/(`landa1'*`prod2'^0.5)-1))	
	//quietly gen double `pb'= ln(`landa1')+ ln(1-`Fw1')+ (1-d10)*(`ps')
	
	quietly replace `lnf' =ln(`uprob') + (1+1-d0f)*ln(`landa0')- `landa0' * (t0b+t0f) +(1-d0f)*(1-d1)*(ln(`fw2')-t1*(`delta'+`landa1'*(1-`Fw2')) +d3*(1-d2)*ln(`delta'+`landa1'*(1-`Fw2')) +d4*(1-d2)*(1-d3)*ln(`landa1'*(1-`Fw2')) +(1-d4)*(1-d3)*(1-d2)*ln(`delta') ) if $ML_y1==1
	quietly replace `lnf' = ln(`eprob') + ln(`gw1') + (1-d6b)*ln(`delta'+`landa1'*(1-`Fw1')) - (`delta'+`landa1'*(1-`Fw1'))*(t1b+t1f) + d7*(1-d6f)*ln(`delta'+`landa1'*(1-`Fw1')) + (1-d8)*(1-d7)*(1-d6f)*(ln(`delta')+(1-d9)*ln(`landa0')-t0*`landa0') + d8*(1-d7)*(1-d6f)*( ln(`landa1')+ ln((`delta'+`landa1')*((`prod1'-wage)^0.5)/(`landa1'*`prod1'^0.5)-1)+ (1-d10)*(ln(`fw2')- ln((`delta'+`landa1')*((`prod1'-wage)^0.5)/(`landa1'*`prod1'^0.5)-1)+ d12*(1-d11)*ln(`delta'+`landa1'*((`delta'+`landa1')*((`prod2'-wage)^0.5)/(`landa1'*`prod2'^0.5)-1))- t2*(`delta'+`landa1'*((`delta'+`landa1')*((`prod2'-wage)^0.5)/(`landa1'*`prod2'^0.5)-1)) +(1-d13)*(1-d12)*(1-d11)*ln(`delta') +d13*(1-d12)*(1-d11)*ln(`landa1'*((`delta'+`landa1')*((`prod2'-wage)^0.5)/(`landa1'*`prod2'^0.5)-1))  )) if $ML_y1==0
end
ml model lf myml22 (unemp= ) (unemp= ) (unemp= )
ml check
//ml init 0.04 0.05 1, copy
ml search, repeat(20)
ml maximize, difficult




program define myml25
	version 1.1
	args lnf landa0
	tempvar landa1 delta wup1 wlow1 wup2 wlow2 prod1 prod2 Fw1 Fw2 fw2 gw1 uprob eprob
	//quietly gen double `landa0' = 0.047
	quietly gen double `landa1' = 0.003
	quietly gen double `delta' = 0.006
	quietly gen double `wup1' = 62846960+1
	quietly gen double `wlow1' = 20020.51-1
	quietly gen double `wup2' = 59253436+1
	quietly gen double `wlow2' = 7322.637-1
	quietly gen double `prod1' = (`wup1'-`wlow1'*((`delta'/(`delta'+`landa1'))^2))/(1-(`delta'/(`delta'+`landa1'))^2)
	quietly gen double `prod2' = (`wup2'-`wlow2'*((`delta'/(`delta'+`landa1'))^2))/(1-(`delta'/(`delta'+`landa1'))^2)
	quietly gen double `Fw1' =(`delta'+`landa1')*(1-((`prod1'-wage)/`prod1')^0.5)/`landa1'	
	quietly gen double `Fw2' =(`delta'+`landa1')*(1-((`prod2'-wage_2)/`prod2')^0.5)/`landa1'
	quietly gen double `fw2' =(`delta'+`landa1')/(2*`landa1'*((abs(`prod2'-wage_2))^0.5)*(`prod2'^0.5))	
	quietly gen double `gw1' =(`delta'*(`prod1'^0.5))/(2*`landa1'*((`prod1'-wage)^1.5))	
	quietly gen double `uprob' =`delta'/(`delta'+`landa0')
	quietly gen double `eprob' =`landa0'/(`delta'+`landa0')
	//quietly gen double `ps'= ln(`fw2') - ln(1-`Fw1')+ d12*(1-d11)*ln(`delta'+`landa1'*(1-`Fw2')) - t2*(`delta'+`landa1'*((`delta'+`landa1')*((`prod2'-wage)^0.5)/(`landa1'*`prod2'^0.5)-1)) +(1-d13)*(1-d12)*(1-d11)*ln(`delta') +d13*(1-d12)*(1-d11)*ln(`landa1'*((`delta'+`landa1')*((`prod2'-wage)^0.5)/(`landa1'*`prod2'^0.5)-1))	
	//quietly gen double `pb'= ln(`landa1')+ ln(1-`Fw1')+ (1-d10)*(`ps')
	
	quietly replace `lnf' =ln(`uprob') + (1+1-d0f)*ln(`landa0')- `landa0' * (t0b+t0f) +(1-d0f)*(1-d1)*(ln(`fw2')-t1*(`delta'+`landa1'*(1-`Fw2')) +d3*(1-d2)*ln(`delta'+`landa1'*(1-`Fw2')) +d4*(1-d2)*(1-d3)*ln(`landa1'*(1-`Fw2')) +(1-d4)*(1-d3)*(1-d2)*ln(`delta') ) if $ML_y1==1
	quietly replace `lnf' = ln(`eprob') + ln(`gw1') + (1-d6b)*ln(`delta'+`landa1'*(1-`Fw1')) - (`delta'+`landa1'*(1-`Fw1'))*(t1b+t1f) + d7*(1-d6f)*ln(`delta'+`landa1'*(1-`Fw1')) + (1-d8)*(1-d7)*(1-d6f)*(ln(`delta')+(1-d9)*ln(`landa0')-t0*`landa0') + d8*(1-d7)*(1-d6f)*( ln(`landa1')+ ln((`delta'+`landa1')*((`prod1'-wage)^0.5)/(`landa1'*`prod1'^0.5)-1)+ (1-d10)*(ln(`fw2')- ln((`delta'+`landa1')*((`prod1'-wage)^0.5)/(`landa1'*`prod1'^0.5)-1)+ d12*(1-d11)*ln(`delta'+`landa1'*((`delta'+`landa1')*((`prod2'-wage)^0.5)/(`landa1'*`prod2'^0.5)-1))- t2*(`delta'+`landa1'*((`delta'+`landa1')*((`prod2'-wage)^0.5)/(`landa1'*`prod2'^0.5)-1)) +(1-d13)*(1-d12)*(1-d11)*ln(`delta') +d13*(1-d12)*(1-d11)*ln(`landa1'*((`delta'+`landa1')*((`prod2'-wage)^0.5)/(`landa1'*`prod2'^0.5)-1))  )) if $ML_y1==0
end
ml model lf myml25 (unemp= age schooling public private)
ml check
//ml init 0.04 0.003 1 1 0.006, copy
ml search, repeat(20)
ml maximize, difficult




program define myml27
	version 1.1
	args lnf landa1
	tempvar landa0 delta wup1 wlow1 wup2 wlow2 prod1 prod2 Fw1 Fw2 fw2 gw1 uprob eprob
	quietly gen double `landa0' = 0.047
	//quietly gen double `landa1' = 0.003
	quietly gen double `delta' = 0.006
	quietly gen double `wup1' = 62846960+1
	quietly gen double `wlow1' = 20020.51-1
	quietly gen double `wup2' = 59253436+1
	quietly gen double `wlow2' = 7322.637-1
	quietly gen double `prod1' = (`wup1'-`wlow1'*((`delta'/(`delta'+`landa1'))^2))/(1-(`delta'/(`delta'+`landa1'))^2)
	quietly gen double `prod2' = (`wup2'-`wlow2'*((`delta'/(`delta'+`landa1'))^2))/(1-(`delta'/(`delta'+`landa1'))^2)
	quietly gen double `Fw1' =(`delta'+`landa1')*(1-((`prod1'-wage)/`prod1')^0.5)/`landa1'	
	quietly gen double `Fw2' =(`delta'+`landa1')*(1-((`prod2'-wage_2)/`prod2')^0.5)/`landa1'
	quietly gen double `fw2' =(`delta'+`landa1')/(2*`landa1'*((abs(`prod2'-wage_2))^0.5)*(`prod2'^0.5))	
	quietly gen double `gw1' =(`delta'*(`prod1'^0.5))/(2*`landa1'*((`prod1'-wage)^1.5))	
	quietly gen double `uprob' =`delta'/(`delta'+`landa0')
	quietly gen double `eprob' =`landa0'/(`delta'+`landa0')
	//quietly gen double `ps'= ln(`fw2') - ln(1-`Fw1')+ d12*(1-d11)*ln(`delta'+`landa1'*(1-`Fw2')) - t2*(`delta'+`landa1'*((`delta'+`landa1')*((`prod2'-wage)^0.5)/(`landa1'*`prod2'^0.5)-1)) +(1-d13)*(1-d12)*(1-d11)*ln(`delta') +d13*(1-d12)*(1-d11)*ln(`landa1'*((`delta'+`landa1')*((`prod2'-wage)^0.5)/(`landa1'*`prod2'^0.5)-1))	
	//quietly gen double `pb'= ln(`landa1')+ ln(1-`Fw1')+ (1-d10)*(`ps')
	
	quietly replace `lnf' =ln(`uprob') + (1+1-d0f)*ln(`landa0')- `landa0' * (t0b+t0f) +(1-d0f)*(1-d1)*(ln(`fw2')-t1*(`delta'+`landa1'*(1-`Fw2')) +d3*(1-d2)*ln(`delta'+`landa1'*(1-`Fw2')) +d4*(1-d2)*(1-d3)*ln(`landa1'*(1-`Fw2')) +(1-d4)*(1-d3)*(1-d2)*ln(`delta') ) if $ML_y1==1
	quietly replace `lnf' = ln(`eprob') + ln(`gw1') + (1-d6b)*ln(`delta'+`landa1'*(1-`Fw1')) - (`delta'+`landa1'*(1-`Fw1'))*(t1b+t1f) + d7*(1-d6f)*ln(`delta'+`landa1'*(1-`Fw1')) + (1-d8)*(1-d7)*(1-d6f)*(ln(`delta')+(1-d9)*ln(`landa0')-t0*`landa0') + d8*(1-d7)*(1-d6f)*( ln(`landa1')+ ln((`delta'+`landa1')*((`prod1'-wage)^0.5)/(`landa1'*`prod1'^0.5)-1)+ (1-d10)*(ln(`fw2')- ln((`delta'+`landa1')*((`prod1'-wage)^0.5)/(`landa1'*`prod1'^0.5)-1)+ d12*(1-d11)*ln(`delta'+`landa1'*((`delta'+`landa1')*((`prod2'-wage)^0.5)/(`landa1'*`prod2'^0.5)-1))- t2*(`delta'+`landa1'*((`delta'+`landa1')*((`prod2'-wage)^0.5)/(`landa1'*`prod2'^0.5)-1)) +(1-d13)*(1-d12)*(1-d11)*ln(`delta') +d13*(1-d12)*(1-d11)*ln(`landa1'*((`delta'+`landa1')*((`prod2'-wage)^0.5)/(`landa1'*`prod2'^0.5)-1))  )) if $ML_y1==0
end
ml model lf myml27 (unemp= public private)
ml check
ml init 0.00005 -0.0001 0.2 0.1 0.03, copy
ml search, repeat(20)
ml maximize, difficult




program define myml28
	version 1.1
	args lnf delta
	tempvar landa0 landa1 wup1 wlow1 wup2 wlow2 prod1 prod2 Fw1 Fw2 fw2 gw1 uprob eprob
	quietly gen double `landa0' = 0.047
	quietly gen double `landa1' = 0.003
	//quietly gen double `delta' = 0.006
	quietly gen double `wup1' = 62846960+1
	quietly gen double `wlow1' = 20020.51-1
	quietly gen double `wup2' = 59253436+1
	quietly gen double `wlow2' = 7322.637-1
	quietly gen double `prod1' = (`wup1'-`wlow1'*((`delta'/(`delta'+`landa1'))^2))/(1-(`delta'/(`delta'+`landa1'))^2)
	quietly gen double `prod2' = (`wup2'-`wlow2'*((`delta'/(`delta'+`landa1'))^2))/(1-(`delta'/(`delta'+`landa1'))^2)
	quietly gen double `Fw1' =(`delta'+`landa1')*(1-((`prod1'-wage)/`prod1')^0.5)/`landa1'	
	quietly gen double `Fw2' =(`delta'+`landa1')*(1-((`prod2'-wage_2)/`prod2')^0.5)/`landa1'
	quietly gen double `fw2' =(`delta'+`landa1')/(2*`landa1'*((abs(`prod2'-wage_2))^0.5)*(`prod2'^0.5))	
	quietly gen double `gw1' =(`delta'*(`prod1'^0.5))/(2*`landa1'*((`prod1'-wage)^1.5))	
	quietly gen double `uprob' =`delta'/(`delta'+`landa0')
	quietly gen double `eprob' =`landa0'/(`delta'+`landa0')
	//quietly gen double `ps'= ln(`fw2') - ln(1-`Fw1')+ d12*(1-d11)*ln(`delta'+`landa1'*(1-`Fw2')) - t2*(`delta'+`landa1'*((`delta'+`landa1')*((`prod2'-wage)^0.5)/(`landa1'*`prod2'^0.5)-1)) +(1-d13)*(1-d12)*(1-d11)*ln(`delta') +d13*(1-d12)*(1-d11)*ln(`landa1'*((`delta'+`landa1')*((`prod2'-wage)^0.5)/(`landa1'*`prod2'^0.5)-1))	
	//quietly gen double `pb'= ln(`landa1')+ ln(1-`Fw1')+ (1-d10)*(`ps')
	
	quietly replace `lnf' =ln(`uprob') + (1+1-d0f)*ln(`landa0')- `landa0' * (t0b+t0f) +(1-d0f)*(1-d1)*(ln(`fw2')-t1*(`delta'+`landa1'*(1-`Fw2')) +d3*(1-d2)*ln(`delta'+`landa1'*(1-`Fw2')) +d4*(1-d2)*(1-d3)*ln(`landa1'*(1-`Fw2')) +(1-d4)*(1-d3)*(1-d2)*ln(`delta') ) if $ML_y1==1
	quietly replace `lnf' = ln(`eprob') + ln(`gw1') + (1-d6b)*ln(`delta'+`landa1'*(1-`Fw1')) - (`delta'+`landa1'*(1-`Fw1'))*(t1b+t1f) + d7*(1-d6f)*ln(`delta'+`landa1'*(1-`Fw1')) + (1-d8)*(1-d7)*(1-d6f)*(ln(`delta')+(1-d9)*ln(`landa0')-t0*`landa0') + d8*(1-d7)*(1-d6f)*( ln(`landa1')+ ln((`delta'+`landa1')*((`prod1'-wage)^0.5)/(`landa1'*`prod1'^0.5)-1)+ (1-d10)*(ln(`fw2')- ln((`delta'+`landa1')*((`prod1'-wage)^0.5)/(`landa1'*`prod1'^0.5)-1)+ d12*(1-d11)*ln(`delta'+`landa1'*((`delta'+`landa1')*((`prod2'-wage)^0.5)/(`landa1'*`prod2'^0.5)-1))- t2*(`delta'+`landa1'*((`delta'+`landa1')*((`prod2'-wage)^0.5)/(`landa1'*`prod2'^0.5)-1)) +(1-d13)*(1-d12)*(1-d11)*ln(`delta') +d13*(1-d12)*(1-d11)*ln(`landa1'*((`delta'+`landa1')*((`prod2'-wage)^0.5)/(`landa1'*`prod2'^0.5)-1))  )) if $ML_y1==0
end
ml model lf myml28 (unemp= private public)
ml check
ml init 0.04 0.003 1, copy
ml search, repeat(20)
ml maximize, difficult

