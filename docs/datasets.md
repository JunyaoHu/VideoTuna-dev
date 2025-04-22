# Dataset

## ToyDataset
You can download the toydataset through the [Onedrive](https://hkustconnect-my.sharepoint.com/:u:/g/personal/zraoac_connect_ust_hk/EV5iJbQ07ydFnLQTc4UFMRABCr5CT6bHZO8_ogYcUJbZEA?e=shkban) or the [GoogleDrive](https://drive.google.com/file/d/1y91MXYG90d4uTljFfV7bXUgLN0n4j4Gm/view?usp=sharing) or run the following commands:
```
pip install gdown
gdown https://drive.google.com/file/d/1y91MXYG90d4uTljFfV7bXUgLN0n4j4Gm/view?usp=sharing --fuzzy
tar -xf toydataset.tar
rm toydataset.tar
```
The structure should be
```
VideoTuna/
    ├── Dataset/
        ├── DATASET1
        ├── ToyDataset/
            ├── toydataset.csv
            ├── videos/
                ├── video1.mp4
                ├── video2.mp4
                ...
```
The `toydataset.csv` includes the path and the caption of the videos.
```
path, caption
Dataset/ToyDataset/videos/QNa4eMNKYwk_2.mp4,A woman with a patch on her eye next to a park bench.
Dataset/ToyDataset/videos/J4FJGUugMHM_0.mp4,A group of children and adults are playing with lego toys at an exhibition.
Dataset/ToyDataset/videos/jPu8eStQrnE_2.mp4,A potted plant is growing in a glass container.
...
```



## Usage

- The `DatasetFromCSV` class is designed to load video data according to a CSV file. 
- To use the `DatasetFromCSV` class, follow these steps:

1. **Import the necessary modules:**
    ```python
    import torch
    from data.datasets import DatasetFromCSV
    ```

2. **Initialize the dataset:**
    ```python
    dataset = DatasetFromCSV(
        csv_path='path/to/your/csvfile.csv',
        data_root='path/to/data/root',
        transform=None,  # or provide your own transform functions
        resolution=(256, 256),
        num_frames=16,
        frame_interval=1,
        train=True,
        split_val=False
    )
    ```

3. **Use the dataset with a DataLoader:**
    ```python
    from torch.utils.data import DataLoader

    dataloader = DataLoader(dataset, batch_size=4, shuffle=True)
    for batch in dataloader:
        videos = batch['video']
        captions = batch['caption']
        # Your training or validation code here
    ```

## Annotation Format

The CSV file should have the following columns:

- **Basic format:**
    ```
    path, caption
    path/to/video1, caption1
    path/to/video2, caption2
    ...
    ```

- **Extended format with additional metadata  (for multi-resolution training):**
    ```
    path, caption, fps, frames, height, width
    path/to/video1, caption1, 30, 100, 512, 512
    path/to/video2, caption2, 30, 50, 1080, 512
    ...
    ```

Ensure that the paths in the CSV file are either absolute or relative to the `data_root` provided during initialization.

In addition, to support a new dataset, you need to convert your annotations to the required CSV format.


### Important Considerations

- **Transform Functions:** If no transform functions are provided, default transforms for video and image data will be used. Ensure that your transform functions are compatible with the data format.
- **Resolution and Frame Settings:** The `resolution`, `num_frames`, and `frame_interval` arguments should be set according to your specific requirements. These parameters control the size and number of frames sampled from each video.
- **Training and Validation Split:** If `split_val` is set to `True`, the dataset will be split into training and validation sets. Ensure that the `train` parameter is set correctly to indicate whether the dataset is for training or validation.


## An Example with the Open-sourced Dataset.
We here use [Vript](https://huggingface.co/datasets/Mutonix/Vript/tree/main) to illustrate the whole procudure for preparing a dataset.

1. Download Vript from HuggingFace:
```bash
huggingface-cli download
--resume-download Mutonix/Vript \
--local-dir path/to/Vript \
--local-dir-use-symlinks False
```

2. Unzip data:
```bash
cd {PROJECT}

python tools/unzip_vript.py --output_dir path/to/Vript/vript_short_videos_clips_unzip --zip_folder path/to/Vript/vript_short_videos_clips
```

3. Generate annotations:
```bash
python tools/vript_anno_converter.py --input_path path/to/Vript/vript_captions/vript_short_videos_captions.jsonl --output_path data/vript_short_videos_captions.csv --video_root path/to/Vript/vript_short_videos_clips_unzip
```

By following above steps, you can easily integrate Vript into our framework and train your own text-to-video models.
