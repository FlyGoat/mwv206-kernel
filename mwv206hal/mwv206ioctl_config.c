/*
 * JM7200 GPU driver
 *
 * Copyright (c) 2018 ChangSha JingJiaMicro Electronics Co., Ltd.
 *
 * Author:
 *      rfshen <jjwgpu@jingjiamicro.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 */
#include <linux/uaccess.h>
#include <linux/version.h>
#include "mwv206ioctl.h"
#include "mwv206devconfig.h"
#include "mwv206dev.h"
int FUNC206HAL296(V206DEV025 *V206DEV103, long arg)
{
	MWV206DevConfig        *pcfg;
	void                   *buf;
	int          ret;

	buf = (void *) arg;
#if (_MWV206_OS_ == _MWV206_KYLIN_ && LINUX_VERSION_CODE >= KERNEL_VERSION(4, 19, 90))
	if (!access_ok(buf, sizeof(*pcfg))) {
#else
	if (!access_ok(VERIFY_WRITE, buf, sizeof(*pcfg))) {
#endif
		return -EFAULT;
	}

	pcfg = FUNC206HAL109(V206DEV103);
	if (pcfg == NULL) {
		return -EINVAL;
	}

	ret = copy_to_user(buf, pcfg, sizeof(*pcfg));
	if (ret) {
		return -EFAULT;
	}
	return 0;

}