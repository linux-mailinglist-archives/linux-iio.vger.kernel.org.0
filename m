Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77D666E4EF
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2019 13:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfGSLT3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Jul 2019 07:19:29 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:60208 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726837AbfGSLT2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Jul 2019 07:19:28 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C001EC01DD;
        Fri, 19 Jul 2019 11:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563535168; bh=DkxvOy+T/mz+azrBV6QR9q61ABi4LwrB8tpYcS1uaF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=d6PWqVq/0oJnkfMJZkNHS7cIZ4t4TzuoiJcL3SxFDy/A3vz5KZj53sZJUzh/Ql3S8
         6MKwF/brIRrUMuMhQstpMbU+JTbhUWKmHAM0XoLlGHRUujOxhQNfnmoHX0ESHBDN/z
         fh2ZCU6wdoSxtIh5jsOMcW5lB/4R9qhGbkBTU6hlYzt7DBekJNoYJmW02FauW8Ggz8
         +1INEzNCvK/UkJJ3Jd+3gnBHk+ymHysMEc2BcPt3z1Ys/DhVUl0yZz0XAUBZapMPu9
         peuNmTR3JbYWKhZNcjFvpUTP5lULGIBbsjDMfroEw2PrBLbnJVeTm6YWmbH83l2ELl
         sODQPTecoR6Nw==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3922DA0057;
        Fri, 19 Jul 2019 11:19:26 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 211243CA34;
        Fri, 19 Jul 2019 13:19:26 +0200 (CEST)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-iio@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     lorenzo@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        bbrezillon@kernel.org, Joao.Pinto@synopsys.com,
        Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v5 2/2] iio: imu: st_lsm6dsx: add i3c basic support for LSM6DSO and LSM6DSR
Date:   Fri, 19 Jul 2019 13:19:05 +0200
Message-Id: <2a181b502eb69f8506873e2ff93239cbb4108e98.1563533343.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1563533342.git.vitor.soares@synopsys.com>
References: <cover.1563533342.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1563533342.git.vitor.soares@synopsys.com>
References: <cover.1563533342.git.vitor.soares@synopsys.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

For today the st_lsm6dsx driver support LSM6DSO and LSM6DSR sensor only in
spi and i2c mode.

The LSM6DSO and LSM6DSR are also i3c capable so let's give i3c support to
them.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v5:
  Move regmap_config declaration inside st_lsm6dsx_i3c_probe()
  Fix warning [-Wint-to-void-pointer-cast] when compiling in 64-bit arch

Changes in v4:
  Remove hw_id variable

Changes in v3:
  Remove unnecessary st_lsm6dsx_i3c_data table used to hold device name
  Use st_lsm6dsx_probe new form

Changes in v2:
  Add support for LSM6DSR
  Set pm_ops to st_lsm6dsx_pm_ops

 drivers/iio/imu/st_lsm6dsx/Kconfig          |  8 +++-
 drivers/iio/imu/st_lsm6dsx/Makefile         |  1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 57 +++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c

diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
index 9e59297..6b5a73c 100644
--- a/drivers/iio/imu/st_lsm6dsx/Kconfig
+++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
@@ -1,11 +1,12 @@
 
 config IIO_ST_LSM6DSX
 	tristate "ST_LSM6DSx driver for STM 6-axis IMU MEMS sensors"
-	depends on (I2C || SPI)
+	depends on (I2C || SPI || I3C)
 	select IIO_BUFFER
 	select IIO_KFIFO_BUF
 	select IIO_ST_LSM6DSX_I2C if (I2C)
 	select IIO_ST_LSM6DSX_SPI if (SPI_MASTER)
+	select IIO_ST_LSM6DSX_I3C if (I3C)
 	help
 	  Say yes here to build support for STMicroelectronics LSM6DSx imu
 	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
@@ -23,3 +24,8 @@ config IIO_ST_LSM6DSX_SPI
 	tristate
 	depends on IIO_ST_LSM6DSX
 	select REGMAP_SPI
+
+config IIO_ST_LSM6DSX_I3C
+	tristate
+	depends on IIO_ST_LSM6DSX
+	select REGMAP_I3C
diff --git a/drivers/iio/imu/st_lsm6dsx/Makefile b/drivers/iio/imu/st_lsm6dsx/Makefile
index e5f733c..c676965 100644
--- a/drivers/iio/imu/st_lsm6dsx/Makefile
+++ b/drivers/iio/imu/st_lsm6dsx/Makefile
@@ -4,3 +4,4 @@ st_lsm6dsx-y := st_lsm6dsx_core.o st_lsm6dsx_buffer.o \
 obj-$(CONFIG_IIO_ST_LSM6DSX) += st_lsm6dsx.o
 obj-$(CONFIG_IIO_ST_LSM6DSX_I2C) += st_lsm6dsx_i2c.o
 obj-$(CONFIG_IIO_ST_LSM6DSX_SPI) += st_lsm6dsx_spi.o
+obj-$(CONFIG_IIO_ST_LSM6DSX_I3C) += st_lsm6dsx_i3c.o
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
new file mode 100644
index 0000000..57e6331
--- /dev/null
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
+ *
+ * Author: Vitor Soares <vitor.soares@synopsys.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/i3c/device.h>
+#include <linux/i3c/master.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+#include "st_lsm6dsx.h"
+
+static const struct i3c_device_id st_lsm6dsx_i3c_ids[] = {
+	I3C_DEVICE(0x0104, 0x006C, (void *)ST_LSM6DSO_ID),
+	I3C_DEVICE(0x0104, 0x006B, (void *)ST_LSM6DSR_ID),
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(i3c, st_lsm6dsx_i3c_ids);
+
+static int st_lsm6dsx_i3c_probe(struct i3c_device *i3cdev)
+{
+	struct regmap_config st_lsm6dsx_i3c_regmap_config = {
+		.reg_bits = 8,
+		.val_bits = 8,
+	};
+	const struct i3c_device_id *id = i3c_device_match_id(i3cdev,
+							    st_lsm6dsx_i3c_ids);
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i3c(i3cdev, &st_lsm6dsx_i3c_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&i3cdev->dev, "Failed to register i3c regmap %d\n",
+			(int)PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	return st_lsm6dsx_probe(&i3cdev->dev, 0, (uintptr_t)id->data, regmap);
+}
+
+static struct i3c_driver st_lsm6dsx_driver = {
+	.driver = {
+		.name = "st_lsm6dsx_i3c",
+		.pm = &st_lsm6dsx_pm_ops,
+	},
+	.probe = st_lsm6dsx_i3c_probe,
+	.id_table = st_lsm6dsx_i3c_ids,
+};
+module_i3c_driver(st_lsm6dsx_driver);
+
+MODULE_AUTHOR("Vitor Soares <vitor.soares@synopsys.com>");
+MODULE_DESCRIPTION("STMicroelectronics st_lsm6dsx i3c driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

