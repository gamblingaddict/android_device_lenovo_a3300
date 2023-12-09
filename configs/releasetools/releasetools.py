import common
import struct

def FullOTA_InstallEnd(info):
  info.script.AppendExtra('package_extract_file("boot.img", "/tmp/boot.img");')
  info.script.AppendExtra('assert(run_program("/sbin/sh", "-c", "dd if=/tmp/boot.img of=/dev/bootimg") == 0);')
