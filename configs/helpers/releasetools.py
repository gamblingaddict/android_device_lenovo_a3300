import common
import struct

def FullOTA_InstallEnd(info):
  # copy the data into the package.
  mtk_boot = info.input_zip.read("RADIO/boot.img")
  common.ZipWriteStr(info.output_zip, "boot_with_header.img", mtk_boot)

  info.script.AppendExtra('package_extract_file("boot_with_header.img", "/tmp/boot.img");')
  info.script.AppendExtra('assert(run_program("/sbin/sh", "-c", "dd if=/tmp/boot.img of=/dev/bootimg") == 0);')
