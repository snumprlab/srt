# --------------------------- out domain QA---------------------------------
output_dir=$1/llavahound
model_path=$2
model_base=${3:-"None"}
resulting_path=${4:-"eval_results.jsonl"}

TEST_DATA_DIR="dataset/video_instruction/test"

data_names=(
    msvd
    msrvtt
    tgif
    ssv2
)

for i in ${!data_names[@]}; do
    data_name=${data_names[$i]}
    data_path=$TEST_DATA_DIR/${data_name}.qa.jsonl
    infer_dir=$output_dir/${data_name}/inference_test

    bash test/inference/inference_test_qa.sh \
    $data_path \
    $infer_dir \
    $model_path \
    $model_base

    bash test/eval/eval_qa.sh \
    $infer_dir.jsonl \
    $data_path \
    ${output_dir}/${data_name}/eval_test \
    $resulting_path &
done