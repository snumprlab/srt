# 🚄 SRT
> [**i-SRT:Aligning Large Multimodal Models for Videos by Iterative Self-Retrospective Judgment**](),            
[Daechul Ahn*](https://dcahn12.github.io)<sup>1,3</sup>,
[Yura Choi*](https://yuuraa.github.io)<sup>1,3</sup>,
San Kim<sup>1,3</sup>,
[Youngjae Yu](https://yj-yu.github.io/home/)<sup>1</sup>, 
[Dongyeop Kang](https://dykang.github.io)<sup>2</sup>,
[Jonghyun Choi](https://ppolon.github.io)<sup>3,&dagger;</sup>(*Equal Contribution)<br>
<sup>1</sup>Yonsei University,
<sup>2</sup>University of Minnesota,
<sup>3</sup>Seoul National University<br>
<sup>&dagger;</sup>Corresponding Author<br>

[![srt-model](https://img.shields.io/badge/Model-isrt__9th__7b-blue)](https://huggingface.co/SNUMPR/isrt_video_llava_7b_9th)
[![isrt-paper](https://img.shields.io/badge/Paper-arxiv-green)](https://arxiv.org/pdf/2406.11280v1)

> **Abstract:** *Aligning Video Large Multimodal Models (VLMMs) face challenges such as modality misalignment and verbose responses. Although iterative approaches such as self-rewarding or iterative direct preference optimization (DPO) recently showed a significant improvement in language model alignment, particularly on reasoning tasks, self-aligned models applied to large video-language models often result in lengthy and irrelevant responses. To address these challenges, we propose a novel method that employs self-retrospection to enhance both response generation and preference modeling, and call iterative self-retrospective judgment (i-SRT). By revisiting and evaluating already generated content and preference in loop, i-SRT improves the alignment between textual and visual modalities, reduce verbosity, and enhances content relevance. Our empirical evaluations across diverse video question answering benchmarks demonstrate that i-SRT significantly outperforms prior arts. We are committed to opensourcing our code, models, and datasets to encourage further investigation.*

<!-- ## Approach -->
![Overview](assets/images/overview.png)

## Release
- [07/02] Upload model checkpoint & evaluation code
- [06/17] Create repository, update README


## Evaluation
### Prepare evaluation dataset
- using the script from [LLaVA-Hound-DPO](https://github.com/RifleZhang/LLaVA-Hound-DPO)
    ```
    TEST_VIDEO_DIR=YOUR_PATH bash setup/setup_test_data.sh
    ```
- or, download manually from this [link](https://huggingface.co/datasets/ShareGPTVideo/test_video_and_instruction/tree/main)

### Evaluating the model 
    # out-domain video question answering
    bash Evaluation/pipeline/ \
        results \
        SNUMPR/isrt_video_llava_7b_9th


## Building Preference Data w/ Model
- Coming soon

## Training
- Coming soon



## Acknowledgement
- [LLaVA-Hound-DPO](https://github.com/RifleZhang/LLaVA-Hound-DPO): Our code is built upon the codebase from LLaVA-Hound-DPO