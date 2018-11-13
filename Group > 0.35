clear
import delimited using "mba2412B.csv", delimiter(",")
rename ïdate date
rename cinemafenz~g cfeng
rename makerfenzh~g mfeng
drop cfeng
order budget,after(revenues)
gen mMsqu = log(makermin)
gen mGsqu = log(makerguo)
gen PPsqu = log(paipian)
gen cMsqu = log(chupinmin)
gen cGsqu = log(chupinguo)
gen mFln = log(mfeng)
drop makerguo makermin chupinguo chupinmin faxingmin
order mMsqu, after(budget)
order cMsqu, after(mMsqu)
order mFln, after(cMsqu)
order rating, after(mFln)
gen PriceLn = log(price)
order PriceLn, after(mFln)
drop price
order period, after(rating)
order PPsqu, after(period)
order mGsqu, after(mMsqu)
drop mfeng

gen FaXing = faxingguo
keep if FaXing>=0.35

/* all regression  */
regress revenues mMsqu mGsqu cMsqu cGsqu budget mFln PriceLn rating period PPsqu

whitetst

gen time= n

tsset time 
	  
dwstat
/* WLS */
predict r, resid
gen logusq=ln(r^4)
regress logusq mMsqu mGsqu cMsqu cGsqu budget mFln PriceLn rating period PPsqu 
predict g, xb 
gen h=exp(g)

regress revenues mMsqu mGsqu cMsqu cGsqu budget mFln PriceLn rating period PPsqu [aweight = h]
dwstat

/* delete PPsqu mMsqu cGsqu rating period  price budget*/
regress revenues mGsqu cMsqu mFln [aweight = h]
dwstat
