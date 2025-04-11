# You can increase the --video-size to <720 1280> if your GPU has about 60GB memory. The current setting requires about 45GB GPU memory.
python scripts/inference_hunyuan.py \
    --video-size 544 960 \
    --video-length 129 \
    --infer-steps 50 \
    --prompt "A cat walks on the grass, realistic style." \
    --flow-reverse \
    --use-cpu-offload \
    --save-path ./results/t2v/hunyuan \
    --model-base ./checkpoints/hunyuanvideo/HunyuanVideo \
    --dit-weight ./checkpoints/hunyuanvideo/HunyuanVideo/hunyuan-video-t2v-720p/transformers/mp_rank_00_model_states.pt \
    --seed 43   # You may change the seed to get different results using the same prompt
