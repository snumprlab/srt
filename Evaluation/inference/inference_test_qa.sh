# CACHE_DIR="/dataset/LLaVA-Hound-DPO/cache_dir"
# cache_dir=$CACHE_DIR
cache_dir="/dataset/LLaVA-Hound-DPO/cache_dir"
export cache_dir=$cache_dir

DATA_DIR="/dataset/LLaVA-Hound-DPO/dataset"
VIDEO_DATA_DIR=$DATA_DIR/video_data

data_path=$1
output_dir=$2
model_path=$3
base_model_path=${4:-"None"}

mkdir -p $output_dir

echo data path: $data_path
echo save at $output_dir
echo model path: $model_path
echo base model path: $base_model_path

# chunking and parallelism
gpu_list="0,1,2,3,4,5,6,7"
IFS=',' read -ra GPULIST <<< "$gpu_list"

CHUNKS=${#GPULIST[@]}

export PYTHONPATH=.

for IDX in $(seq 0 $((CHUNKS-1))); do
  CUDA_VISIBLE_DEVICES=${GPULIST[$IDX]} python3 test/inference/inference_test_qa.py \
      --model_path ${model_path} --base_model_path ${base_model_path} \
      --cache_dir ${cache_dir} \
      --data_path ${data_path} --video_dir $VIDEO_DATA_DIR \
      --output_dir ${output_dir} \
      --output_name ${CHUNKS}_${IDX}.jsonl \
      --chunks $CHUNKS \
      --chunk_idx $IDX &
done
wait

output_file=${output_dir}.jsonl

# Clear out the output file if it exists.
> "$output_file"

# Loop through the indices and concatenate each file.
for IDX in $(seq 0 $((CHUNKS-1))); do
    cat ${output_dir}/${CHUNKS}_${IDX}.jsonl >> "$output_file"
done

# ps -ef | grep actnet_exp/inference_test_actnet_qa.py | awk '{print $2}' | xargs -r kill -9