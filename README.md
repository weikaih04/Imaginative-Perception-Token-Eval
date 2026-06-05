# 🧭 Spatial Imaginative Token — Evaluation

Evaluation toolkit for the **Spatial Imaginative Token (IPT)** paper, built on
[VLMEvalKit](https://github.com/open-compass/VLMEvalKit) and the
[ThinkMorph](https://github.com/ThinkMorph/ThinkMorph) eval stack. It adds the spatial-reasoning
benchmarks used in the paper across three tasks — **Perspective Taking (PET)** and
**Multiview Counting (MVC)** — plus their cross-domain transfer benchmarks.

<p align="center">
  <a href="https://huggingface.co/collections/weikaih/spatial-imaginative-token-mvc-pet-pt-datasets-6a15f80e0fcef43bd0c50aba">
    <img src="https://img.shields.io/badge/IPT-Datasets-yellow?logo=huggingface&logoColor=yellow" alt="IPT Datasets"/>
  </a>
  <a href="https://github.com/weikaih04/Spatial-Imaginative-Token">
    <img src="https://img.shields.io/badge/IPT-Training-blue?logo=github&logoColor=white" alt="IPT Training"/>
  </a>
</p>

---

## 📊 Benchmarks

All evaluation datasets are in the [🤗 collection](https://huggingface.co/collections/weikaih/spatial-imaginative-token-mvc-pet-pt-datasets-6a15f80e0fcef43bd0c50aba).
Pass the unified `--data` name to `run.py`:

| Task | `--data` name | Setting | n |
|------|---------------|---------|---|
| **PET** | `PET_AI2Thor_SpatialImaginativeToken`   | AI2-THOR (in-domain) | 278 |
| **PET** | `PET_Habitat_SpatialImaginativeToken`   | Habitat (different env, human-verified) | 300 |
| **PET** | `PET_SAT_SpatialImaginativeToken`       | SAT perspective (cross-domain transfer) | 66 |
| **MVC** | `MVC_AI2Thor_SpatialImaginativeToken`   | AI2-THOR (in-domain, human-verified) | 260 |
| **MVC** | `MVC_ScanNet_SpatialImaginativeToken`   | ScanNet (different env) | 200 |
| **MVC** | `MVC_MessyTable_SpatialImaginativeToken`| MessyTable (cross-domain transfer) | 200 |
| **Other spatial** | `MindCube_SpatialImaginativeToken`  | MindCube (transfer) | 200 |
| **Other spatial** | `AllAngles_SpatialImaginativeToken` | All-Angles EgoHumans (transfer) | 170 |

> **Path Tracing (PT)** benchmarks will be added under the same naming convention
> (`PT_AI2Thor_SpatialImaginativeToken`, `PT_Real_SpatialImaginativeToken`).

---

## 🚀 Quick Start

### 1. Install

```bash
git clone https://github.com/weikaih04/SpatialReasoning_Eval.git
cd SpatialReasoning_Eval
pip install -r requirements.txt
```

You also need the ThinkMorph / BAGEL model dependencies installed (same environment used to
run the [training repo](https://github.com/weikaih04/Spatial-Imaginative-Token)).

### 2. Configure the model

The model entry lives in [`vlmeval/config.py`](vlmeval/config.py) under `thinkmorph_series`:

```python
"thinkmorph": partial(
    ThinkMorph,
    model_path="ThinkMorph/ThinkMorph-7B",   # or your local checkpoint
    think=True,
    understanding_output=False,              # False => interleaved reasoning, saves generated images
    temperature=0.3,
    max_think_token_n=4096,
    save_dir="path_to_your_imgs_dir",
),
```

Paths and the image directory can also be overridden via the `THINKMORPH_MODEL_PATH` and
`THINKMORPH_SAVE_DIR` environment variables.

### 3. Run

A ready-to-use script is in [`run_spatial.sh`](run_spatial.sh) (set `OPENAI_API_KEY` first; judge = `gpt-5`):

```bash
export OPENAI_API_KEY="your_api_key_here"

python run.py \
  --data PET_AI2Thor_SpatialImaginativeToken PET_Habitat_SpatialImaginativeToken PET_SAT_SpatialImaginativeToken \
         MVC_AI2Thor_SpatialImaginativeToken MVC_ScanNet_SpatialImaginativeToken MVC_MessyTable_SpatialImaginativeToken \
         MindCube_SpatialImaginativeToken AllAngles_SpatialImaginativeToken \
  --model thinkmorph \
  --judge gpt-5 \
  --work-dir ./results
```

---

<details>
<summary><b>📚 Built on ThinkMorph / VLMEvalKit (click to expand)</b></summary>

This repository is forked from the [ThinkMorph](https://github.com/ThinkMorph/ThinkMorph) eval stack
([VLMEvalKit_Thinkmorph](https://github.com/hychaochao/VLMEvalKit_Thinkmorph)), itself based on
[VLMEvalKit](https://github.com/open-compass/VLMEvalKit). The original ThinkMorph evaluation supports
`VSP`, `VisPuzzle`, `ChartQA`, `VStar`, `BLINK-J`, `MMVP`, `SAT`, `BLINK`, and `CV-Bench`.

```bash
python run.py \
    --data VSP_maze_task_main_original VisPuzzle ChartQA_h_bar ChartQA_v_bar VStarBench BLINK_Jigsaw MMVP BLINK CV-Bench-2D CV-Bench-3D \
    --model thinkmorph \
    --judge gpt-5 \
    --work-dir ./results
```

For more benchmarks, see the [VLMEvalKit feature list](https://github.com/open-compass/VLMEvalKit).

</details>
