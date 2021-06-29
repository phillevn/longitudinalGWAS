# longitudinalGWAS

This is a pipline for running longitudinal GWAS study. The analysis is based one fGWAS method by Wang at https://github.com/wzhy2000/fGWAS

You need to install the following tools besides fGWAS program at the above website. 
+ plink2.0
+ bcftools
I used pbs for running on HPC.
Your vcf file names may be different than mine, so you need to make some change accordingly.

You may do the following steps to run the program:
1) Run the phenotype_genotype_id program to get the genotype data corresponding to your phenotype data.
2) Run the curve fitting program to find the best covariance structure and the best fgwas functional type for your data.
3) Run the split program to slit the genotype data into smaller files with at most 1M SNPs by runing the code split_chro1-22.pbs code
4) Run the create_Rscript.sh to create Rscripts for all the splitted files for each chromosome to run the fGWAS
5) Run the program to submit the jobs from each Rscript for each splitted files of each chromosome
