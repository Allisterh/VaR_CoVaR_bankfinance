This is my project concerning bankfinance.

This is my project concerning bank finance.

The main program code and data can be found in the author's bankfinance project on GitHub:
https://github.com/shenciyou/bankfinance

For detailed software operation and code integration, see the project operation manual document: manual.docx

The main code list is as follows:
Chapter III Measurement of Systemic Risk
1. Calculation of DD
(1) code_for_DD.do
(2) KMVfun.m
(3) KMVOptSearch.m
(4) KMV.m

2. Calculation of PDD
(1) sigmaP_solver.do
(2) pdd_generator.do

3. Calculation of LRSQ
(1) lrsq_generator.do

4. Calculation of △CoVaR
(1) deltacovar_generator.do

5. Calculation of static MES
(1) static_mes.txt

6. Calculation of dynamic MES
(1) dynamic_mes.txt

7. Descriptive statistics
(1) descriptive_stat.txt

Chapter IV Research on Systemic Risk Contagion
1. Calculation of inter-bank bilateral risk exposure matrix X
(1) lingo.txt
2. Simulation of inter-bank risk contagion
(1) BankDownFun.m
(2) riskcontagion.m

Chapter V Identification of Systemically Important Banks
1. Identification of relative systemically important banks based on SRISK derived from SES
(1) srisk.txt
2. Identification of systemically important banks based on the entropy index method
(1) dsibs.txt (including the core function entropy_method.m of the entropy method process)

Chapter 6 Influencing Factors of Systemic Risk
1. Bank competition
(1) code_for_comp.txt
2. Monetary policy
(1) code_for_mp.txt
3. Panel synthesis
(1) code_for_combine.txt
4. Regression analysis
(1) code_for_xtreg.txt

Chapter 7 Coordination of Macro-prudential Policy and Monetary Policy Based on DSGE Model
1. MOD file of Dynare toolbox
(1) macrodata_dynare.mod
2. Matlab calls Dynare files
(1) Dynarecall.m
3. Matlab data preprocessing module
(1) macrodata_input.m
4. Matlab impact smooth estimation and impulse response value output module
(1) macrodata_output.m
