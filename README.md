# zephyr-esp32-dev

Zephyr + ESP32 の開発・CI 対応 Docker イメージです。  
ローカル開発にも GitHub Actions にも使える汎用的な構成になっています。

## 🔧 使用方法（ローカル）

```bash
# Docker イメージをビルド
docker build -t zephyr-esp32-dev .

# Zephyr プロジェクトをマウントしてビルド
docker run --rm -it -v $(pwd):/work -w /work zephyr-esp32-dev \
  bash -c "west init -l . && west update && west build -b esp32"

## 🔥 書き込み手順（ESP32 への flash）

ビルドに成功すると、次の3つの `.bin` ファイルが `build/` ディレクトリに生成されます：

- `bootloader.bin`（0x1000 に書き込み）
- `partition-table.bin`（0x8000 に書き込み）
- `zephyr.bin`（0x10000 に書き込み）

以下のコマンドで書き込みが可能です：

```bash
esptool.py --chip esp32 --port /dev/ttyUSB0 --baud 460800 write_flash \
  0x1000 build/bootloader/bootloader.bin \
  0x8000 build/partition_table/partition-table.bin \
  0x10000 build/zephyr/zephyr.bin
