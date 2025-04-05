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
