clear
import delimited using "mba2412B.csv", delimiter(",")
rename ïdate date
rename cinemafenz~g cfeng
rename makerfenzh~g mfeng
drop cfeng
order budget,after(revenues)
gen mMsqu = makermin^2
gen PPsqu = paipian^2
gen cMsqu = chupinmin^2
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
drop mfeng
gen mMsqu_IV = mm_iv^2
gen cMsqu_IV = cm_iv^2

ivreg revenues budget cMsqu mFln PriceLn rating period (mMsqu = mMsqu_IV)

/* WLS */
predict r, resid
gen logusq=ln(r^2)
regress logusq budget mMsqu cMsqu mFln PriceLn rating period PPsqu 
predict g, xb 
gen h=exp(g)

regress revenues budget mMsqu_IV cMsqu mFln PriceLn rating period PPsqu [aweight = h]

/* reg mMsqu mMsqu_IV */
