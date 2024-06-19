APPS_EVAL_DIR="../" # path to apps/eval
SKIP_AMT=20
SAVE_LOC="../../../results" # path to results dir
MODEL_LOC=':)' # basicly anything non-empty it does not matter but if old code is used -- path to model
TEST_LOC="../../../APPS/test" # path to test data
TOTAL_PROBLEMS=20

export HF_HOME=/mnt/LLM
export CUDA_VISIBLE_DEVICES=3

for (( i=0; i <= $TOTAL_PROBLEMS ; i+=$SKIP_AMT)) ; 
do 
    echo "It: $i - $($i + $SKIP_AMT), cuda: $CUDA_VISIBLE_DEVICES, HF_HOME: $HF_HOME"
    # jid1=$(sbatch --parsable start_slurm_gen.sbatch $APPS_EVAL_DIR $i $(($i+$SKIP_AMT)) $SAVE_LOC  $MODEL_LOC  $TEST_LOC )
    bash start_slurm_gen.sbatch $APPS_EVAL_DIR $i $(($i+$SKIP_AMT)) $SAVE_LOC  $MODEL_LOC  $TEST_LOC
    # jid2=$(sbatch --dependency=afterany:$jid1 test_all_sols.sbatch $APPS_EVAL_DIR $i $(($i+$SKIP_AMT)) $SAVE_LOC  $TEST_LOC )
    bash test_all_sols.sbatch $APPS_EVAL_DIR $i $(($i+$SKIP_AMT)) $SAVE_LOC  $TEST_LOC
done

