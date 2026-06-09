# Imaginative Perception Token — Evaluation

Evaluation toolkit for the **Imaginative Perception Token (IPT)** paper, built on
[VLMEvalKit](https://github.com/open-compass/VLMEvalKit). It adds the spatial-reasoning
benchmarks used in the paper — **Perspective Taking (PET)**, **Multiview Counting (MVC)**, and
**Path Tracing (PT)** — plus their cross-domain transfer benchmarks.

<p align="center">
  <a href="https://arxiv.org/abs/2606.03988">
    <img src="https://img.shields.io/badge/arXiv-2606.03988-b31b1b?logo=arxiv&logoColor=white" alt="arXiv"/>
  </a>
  <a href="https://huggingface.co/collections/weikaih/imaginative-perception-token-data-6a15f80e0fcef43bd0c50aba">
    <img src="https://img.shields.io/badge/IPT-Datasets-yellow?logo=huggingface&logoColor=yellow" alt="IPT Datasets"/>
  </a>
  <a href="https://github.com/weikaih04/Imaginative-Perception-Token">
    <img src="https://img.shields.io/badge/IPT-Training-blue?logo=github&logoColor=white" alt="IPT Training"/>
  </a>
</p>

---

## Benchmarks

All evaluation datasets are in the [Spatial Mental Modeling Benchmark collection](https://huggingface.co/collections/weikaih/spatial-mental-modeling-benchmark-6a258507ed8b6eeac42f1d02).
Pass the unified `--data` name to `run.py`:

| Task | `--data` name | Setting | n |
|------|---------------|---------|---|
| **PET** | `PET_AI2Thor_ImaginativePerceptionToken`   | AI2-THOR (in-domain, human-verified) | 278 |
| **PET** | `PET_Habitat_ImaginativePerceptionToken`   | Habitat (different env, human-verified) | 300 |
| **PET** | `PET_SAT_ImaginativePerceptionToken`       | SAT perspective (cross-domain transfer) | 66 |
| **MVC** | `MVC_AI2Thor_ImaginativePerceptionToken`   | AI2-THOR (in-domain, human-verified) | 260 |
| **MVC** | `MVC_ScanNet_ImaginativePerceptionToken`   | ScanNet (different env) | 200 |
| **MVC** | `MVC_MessyTable_ImaginativePerceptionToken`| MessyTable (cross-domain transfer) | 200 |
| **Other spatial** | `MindCube_ImaginativePerceptionToken`  | MindCube (transfer) | 200 |
| **Other spatial** | `AllAngles_ImaginativePerceptionToken` | All-Angles EgoHumans (transfer) | 170 |

> Our own eval sets — AI2-THOR (in-domain), Habitat / Real (different env) — are all **human-verified**.
> SAT, MessyTable, ScanNet, MindCube, and All-Angles are external transfer benchmarks.
>
> **Path Tracing (PT)** benchmarks will be added under the same naming convention
> (`PT_AI2Thor_ImaginativePerceptionToken`, `PT_Real_ImaginativePerceptionToken`), also human-verified.

---

## Quick Start

### 1. Install

```bash
git clone https://github.com/weikaih04/Imaginative-Perception-Token-Eval.git
cd Imaginative-Perception-Token-Eval
pip install -r requirements.txt
```

You also need the BAGEL model dependencies installed (same environment used to
run the [training repo](https://github.com/weikaih04/Imaginative-Perception-Token)).

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
  --data PET_AI2Thor_ImaginativePerceptionToken PET_Habitat_ImaginativePerceptionToken PET_SAT_ImaginativePerceptionToken \
         MVC_AI2Thor_ImaginativePerceptionToken MVC_ScanNet_ImaginativePerceptionToken MVC_MessyTable_ImaginativePerceptionToken \
         MindCube_ImaginativePerceptionToken AllAngles_ImaginativePerceptionToken \
  --model thinkmorph \
  --judge gpt-5 \
  --work-dir ./results
```

---

Built on [VLMEvalKit](https://github.com/open-compass/VLMEvalKit).
