/*
*FM radio driver kernel module insmod file for wmt dynamic loader
*/
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/syscall.h>

//For directory operation
#include <dirent.h>

#define FMR_MODULES_PATH "/system/lib/modules/mtk_fm_drv.ko"
extern int load_fm_module(int chip_id);
extern int init_module(void *, unsigned long, const char *);

//insmod
static int insmod(const char *filename, const char *args)
{
     /* O_NOFOLLOW is removed as wlan.ko is symlink pointing to
        the vendor specfic file which is in readonly location */
     int fd = open(filename, O_RDONLY | O_CLOEXEC);
     if (fd == -1) {
        ALOGD("insmod: open(\"%s\") failed: %s", filename, strerror(errno));
        return -1;
     }
     int rc = syscall(__NR_finit_module, fd, args, 0);
     if (rc == -1) {
       ALOGD("finit_module for \"%s\" failed: %s", filename, strerror(errno));
     }
     close(fd);
     return rc;
}

int load_fm_module(int chip_id)
{
    int ret=-1;
    ret = insmod(FMR_MODULES_PATH, "");
    if(ret)
    {
        printf("insert mtk_fm_drv.ko fail(%d)\n",ret);
    }
    else
    {
        printf("insert mtk_fm_drv.ko ok\n");
    }
    return ret;
}

