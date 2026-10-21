# BinaryReceptor 打包脚本（Windows / MSYS2 Git Bash）
# 用法：bash package.sh
set -e

export PATH="$PATH:/c/HaxeToolkit/haxe:/c/HaxeToolkit/neko"
PROJ_DIR="$(cd "$(dirname "$0")" && pwd)"
OUT_DIR="$PROJ_DIR/build/BinaryReceptor"

# PowerShell 需要原生 Windows 路径（MSYS 的 /d/... 形式无法识别）
WIN_PROJ_DIR="$(cygpath -w "$PROJ_DIR")"
WIN_OUT_DIR="$(cygpath -w "$OUT_DIR")"
WIN_ZIP="$(cygpath -w "$PROJ_DIR/BinaryReceptor.zip")"

echo "==> 1/3 编译 Haxe 核心 (BinaryReceptor.exe)"
cd "$PROJ_DIR"
haxe release.hxml

echo "==> 2/3 编译 C# 托盘程序 (BinaryReceptorGUI.exe)"
dotnet publish gui/win -c Release

echo "==> 3/3 打包"
rm -rf "$OUT_DIR"
mkdir -p "$OUT_DIR"
cp "$PROJ_DIR/build/release/BinaryReceptor.exe" "$OUT_DIR/BinaryReceptor.exe"
cp "$PROJ_DIR/gui/win/bin/Release/net8.0-windows/win-x64/publish/BinaryReceptorGUI.exe" "$OUT_DIR/BinaryReceptorGUI.exe"
cp "$PROJ_DIR/res/default-settings.ini" "$OUT_DIR/settings.ini"

cd "$PROJ_DIR"
rm -f BinaryReceptor.zip
powershell.exe -NoProfile -Command "Compress-Archive -Force -Path '$WIN_OUT_DIR' -DestinationPath '$WIN_ZIP'"

echo ""
echo "打包完成："
echo "  目录：$OUT_DIR"
echo "  压缩包：$PROJ_DIR/BinaryReceptor.zip"
ls -la "$OUT_DIR"
