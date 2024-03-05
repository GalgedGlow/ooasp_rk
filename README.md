# ooasp_rk
Project Solution for OOASP Implementation Knowledged Based Configuration

The OOASP Encoding is in ooasp.lp, the config-model from the paper, which I extended slightly, is in config-model.lp.
There are couple of test files. A test file can be launched via e. g.:

clingo ooasp.lp config-model.lp test1.lp 0

The amount of potentially generated objects is defined by initial_generation(N), 
currently at N=50 for performance reasons. It can be modified if necessary.