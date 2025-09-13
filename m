Return-Path: <linux-iio+bounces-24068-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2532AB561E4
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 17:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47963189FD26
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D732F39D3;
	Sat, 13 Sep 2025 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="jKAozZJO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E5F1A5B9E;
	Sat, 13 Sep 2025 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757778015; cv=none; b=RUcEUhPk/mli02VD/Th1/GfUXg0K+yB1j0E8XfFBY/zD/3lEO2uTryrvF83muem2KUZudRl2lCSf621EH0tGOWErtGjmXzzNANzWPLBkSMGJRi/4irnaZFrRGM8XKJWvUuwSZWfDejDbOpXCf3CmNUOQTVIFCPkYe3/1YfWxb7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757778015; c=relaxed/simple;
	bh=ChNDnbsnUaD5lOGs0bZb2KRmd/Y8TTkheIP3ACkZDFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nCja9QnEQd/fZSKJfibQegQKMtmJint38jtUUhEWgkS4L2ExBP3JrnYBZUaqr839oHX/ir05hE+hYVrhA4T7gEhcbH0HQpt6bTmVw/9wzsW946a9nEHZOwwMAYJw1F/MW0hKkMbEy1WwGmz3eZHTd8CU3ZorfjuScbwfC6voTLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=jKAozZJO; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 8E856173BEC;
	Sat, 13 Sep 2025 18:40:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757778005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHc5xiSOmUO9NfuCfgpno9Tr/1qvtPLKetQwAEi29AQ=;
	b=jKAozZJOvwONlqO6c2NPZcNEEH0Ud1nBNsdZ+MydZt3Hsy1OAm1kXZWEh4lc/giwviO4d4
	mp2L+SQlaCrRNc1NRZaIj3LU8IO0LYgy6J7dDjGFa/wv6QrXlKpthcP1S+J+j+SQKxMc8N
	Ib0AwFKQ0s+yFVlH8YNmFrMJ/p4i47iAwSKXsXbidHrHKAr6CTpik8RzbJ59YJEGgytXPU
	65kbwB2i8DVqJ97xFxk9XRtOCVb0dRG1PSSAKKMAouRRK90eDrlcAk2/AMAtDWRc5KBBqT
	UXtZReJGxIQgXiGvEbsjWr+mdy7Vv2M3g25Pl+uIkpeXKjEDJE+75f55XwdH7g==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sat, 13 Sep 2025 18:39:25 +0300
Subject: [PATCH v3 04/18] iio: accel: bma220: split original driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-b4-bma220_improvements-v3-4-0b97279b4e45@subdimension.ro>
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
In-Reply-To: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Petre Rodan <petre.rodan@subdimension.ro>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=21075;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=ChNDnbsnUaD5lOGs0bZb2KRmd/Y8TTkheIP3ACkZDFg=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBoxZBRnzNZ/IqGTQ7Uk4WKZRG0Yhiilu3BwOOg8
 ippqOv/y7uJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMWQUQAKCRDPJpmZhE5/
 MIc2EACntBMV7knTnTBiDZWsILru921n9Os4e1HPdI9mtGAdil2W9Fsi+tTJjFRA0PzPCyGVEno
 oEJJB7anDlSSiKEcgkZzzd4BBrZRah5r4ij4E3rL+nWQKHgp1SlQJyB7Fli9FsZ4Pm6amMt+b5Z
 3/7cP9MrXpYhhIel3N9Q5oBbKZI79JUcHf9w0usyUqwERqvHPwwSTffLGBfbDJwHWovu8B0rfgj
 uNLU2ojiLSlwNg86u8ZfqC3pwUSoNAeWg0UHeTvnkAQkv9REpf4nqRlGyXTPPfzWF7wqzmMLAtW
 ORemT/pVRKTHBG4treeqWR6wgFP14rxVYGvjPdmB3PgIvFyz3fYpNnRFvVmDcHvG7RpYWQ3Sovx
 46M4ec0r6vHvcV/YKuMy8XGgdka+DJaw4YlbBPhBp/k9Q5y87T/CvWjhhuu1B84IziFFeZW0n3P
 OkDbCi2D0pbz4xG2DQwsJXcD6D/RHTCSLDrBvTrDHn+uSfh0ploMDo79MZo6KTnams7ao3menZp
 lLlFXX3PI4D38SCA2pZlCUs/5avv8qxSEx44IcaoNQ4HmCEukImkm3hGPj9Z/Yh3iq3WBzXWRYH
 NX+Wpn3YcQDYC+ZqzYgY0RaM0QVSLZn0s1K3TSKNOfzOYD7WrvECqjDMNxxc8oqFUeq1o10C/Vr
 W46Bo5QdnOHBhSQ==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

In preparation for the i2c module, move the original code into multiple
source files without any other functional change.

Create the additional bma220_core module which currently is not
providing an abstracted bus type (this will change with the regmap
patch).
Fix checkpatch warning about GPL v2 license in bma220_spi.c.
Fix a few includes to make the change functional and prepare for the
next patches.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1->v2
- split out open firmware table modification into separate patch
- bma220_write_raw() exits without dev_err() based on similar feedback
  from David
- change includes in bma220.h (Jonathan)
- include bma220.h in bma220_core.c (Jonathan)
- add device.h, errno.h, mutex.h and pm.h includes to bma220_core.c
- cleanup struct spacing in bma220_spi.c
v2->v3
- keep depends on SPI (David)
- fix a few includes in bma220_spi.c (Jonathan)
- mention new includes in commit body (Jonathan)
---
 drivers/iio/accel/Kconfig       |   8 +-
 drivers/iio/accel/Makefile      |   3 +-
 drivers/iio/accel/bma220.h      |  18 +++
 drivers/iio/accel/bma220_core.c | 313 ++++++++++++++++++++++++++++++++++++++++
 drivers/iio/accel/bma220_spi.c  | 307 ++-------------------------------------
 5 files changed, 353 insertions(+), 296 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 8c3f7cf55d5fa432a4d4662b184a46cd59c3ebca..4648be329917a3054615ed324156d67f53baefb6 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -221,12 +221,18 @@ config BMA220
 	depends on SPI
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	select BMA220_SPI if SPI
 	help
 	  Say yes here to add support for the Bosch BMA220 triaxial
 	  acceleration sensor.
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called bma220_spi.
+	  module will be called bma220_core and you will also get
+	  bma220_spi if SPI is enabled.
+
+config BMA220_SPI
+	tristate
+	depends on BMA220
 
 config BMA400
 	tristate "Bosch BMA400 3-Axis Accelerometer Driver"
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index ca8569e25aba31c3ae3437abf8506addbf5edffa..56a9f848f7f913633bc2a628c1ac5c9190774b9d 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -25,7 +25,8 @@ obj-$(CONFIG_ADXL380) += adxl380.o
 obj-$(CONFIG_ADXL380_I2C) += adxl380_i2c.o
 obj-$(CONFIG_ADXL380_SPI) += adxl380_spi.o
 obj-$(CONFIG_BMA180) += bma180.o
-obj-$(CONFIG_BMA220) += bma220_spi.o
+obj-$(CONFIG_BMA220) += bma220_core.o
+obj-$(CONFIG_BMA220_SPI) += bma220_spi.o
 obj-$(CONFIG_BMA400) += bma400_core.o
 obj-$(CONFIG_BMA400_I2C) += bma400_i2c.o
 obj-$(CONFIG_BMA400_SPI) += bma400_spi.o
diff --git a/drivers/iio/accel/bma220.h b/drivers/iio/accel/bma220.h
new file mode 100644
index 0000000000000000000000000000000000000000..dea34244b4fc4971841dc60d79db6c7db27bea20
--- /dev/null
+++ b/drivers/iio/accel/bma220.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Forward declarations needed by the bma220 sources.
+ *
+ * Copyright 2025 Petre Rodan <petre.rodan@subdimension.ro>
+ */
+
+#ifndef _BMA220_H
+#define _BMA220_H
+
+#include <linux/pm.h>
+
+extern const struct dev_pm_ops bma220_pm_ops;
+struct spi_device;
+
+int bma220_common_probe(struct spi_device *dev);
+
+#endif
diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
new file mode 100644
index 0000000000000000000000000000000000000000..6bc2e5c3fb6cebd50209acbcc2d5340630c27cd1
--- /dev/null
+++ b/drivers/iio/accel/bma220_core.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * BMA220 Digital triaxial acceleration sensor driver
+ *
+ * Copyright (c) 2016,2020 Intel Corporation.
+ */
+
+#include <linux/bits.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/types.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#include "bma220.h"
+
+#define BMA220_REG_ID				0x00
+#define BMA220_REG_ACCEL_X			0x02
+#define BMA220_REG_ACCEL_Y			0x03
+#define BMA220_REG_ACCEL_Z			0x04
+#define BMA220_REG_RANGE			0x11
+#define BMA220_REG_SUSPEND			0x18
+
+#define BMA220_CHIP_ID				0xDD
+#define BMA220_READ_MASK			BIT(7)
+#define BMA220_RANGE_MASK			GENMASK(1, 0)
+#define BMA220_SUSPEND_SLEEP			0xFF
+#define BMA220_SUSPEND_WAKE			0x00
+
+#define BMA220_DEVICE_NAME			"bma220"
+
+#define BMA220_ACCEL_CHANNEL(index, reg, axis) {			\
+	.type = IIO_ACCEL,						\
+	.address = reg,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 6,						\
+		.storagebits = 8,					\
+		.shift = 2,						\
+		.endianness = IIO_CPU,					\
+	},								\
+}
+
+enum bma220_axis {
+	AXIS_X,
+	AXIS_Y,
+	AXIS_Z,
+};
+
+static const int bma220_scale_table[][2] = {
+	{0, 623000}, {1, 248000}, {2, 491000}, {4, 983000},
+};
+
+struct bma220_data {
+	struct spi_device *spi_device;
+	struct mutex lock;
+	struct {
+		s8 chans[3];
+		/* Ensure timestamp is naturally aligned. */
+		aligned_s64 timestamp;
+	} scan;
+	u8 tx_buf[2] __aligned(IIO_DMA_MINALIGN);
+};
+
+static const struct iio_chan_spec bma220_channels[] = {
+	BMA220_ACCEL_CHANNEL(0, BMA220_REG_ACCEL_X, X),
+	BMA220_ACCEL_CHANNEL(1, BMA220_REG_ACCEL_Y, Y),
+	BMA220_ACCEL_CHANNEL(2, BMA220_REG_ACCEL_Z, Z),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+static inline int bma220_read_reg(struct spi_device *spi, u8 reg)
+{
+	return spi_w8r8(spi, reg | BMA220_READ_MASK);
+}
+
+static const unsigned long bma220_accel_scan_masks[] = {
+	BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
+	0
+};
+
+static irqreturn_t bma220_trigger_handler(int irq, void *p)
+{
+	int ret;
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bma220_data *data = iio_priv(indio_dev);
+	struct spi_device *spi = data->spi_device;
+
+	mutex_lock(&data->lock);
+	data->tx_buf[0] = BMA220_REG_ACCEL_X | BMA220_READ_MASK;
+	ret = spi_write_then_read(spi, data->tx_buf, 1, &data->scan.chans,
+				  ARRAY_SIZE(bma220_channels) - 1);
+	if (ret < 0)
+		goto err;
+
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+				    pf->timestamp);
+err:
+	mutex_unlock(&data->lock);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int bma220_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	int ret;
+	u8 range_idx;
+	struct bma220_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = bma220_read_reg(data->spi_device, chan->address);
+		if (ret < 0)
+			return -EINVAL;
+		*val = sign_extend32(ret >> chan->scan_type.shift,
+				     chan->scan_type.realbits - 1);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		ret = bma220_read_reg(data->spi_device, BMA220_REG_RANGE);
+		if (ret < 0)
+			return ret;
+		range_idx = ret & BMA220_RANGE_MASK;
+		*val = bma220_scale_table[range_idx][0];
+		*val2 = bma220_scale_table[range_idx][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+
+	return -EINVAL;
+}
+
+static int bma220_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	int i;
+	int ret;
+	int index = -1;
+	struct bma220_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		for (i = 0; i < ARRAY_SIZE(bma220_scale_table); i++)
+			if (val == bma220_scale_table[i][0] &&
+			    val2 == bma220_scale_table[i][1]) {
+				index = i;
+				break;
+			}
+		if (index < 0)
+			return -EINVAL;
+
+		mutex_lock(&data->lock);
+		data->tx_buf[0] = BMA220_REG_RANGE;
+		data->tx_buf[1] = index;
+		ret = spi_write(data->spi_device, data->tx_buf,
+				sizeof(data->tx_buf));
+		if (ret < 0)
+			return ret;
+		mutex_unlock(&data->lock);
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int bma220_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (int *)bma220_scale_table;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = ARRAY_SIZE(bma220_scale_table) * 2;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info bma220_info = {
+	.read_raw		= bma220_read_raw,
+	.write_raw		= bma220_write_raw,
+	.read_avail		= bma220_read_avail,
+};
+
+static int bma220_init(struct spi_device *spi)
+{
+	int ret;
+
+	ret = bma220_read_reg(spi, BMA220_REG_ID);
+	if (ret != BMA220_CHIP_ID)
+		return -ENODEV;
+
+	/* Make sure the chip is powered on */
+	ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
+	if (ret == BMA220_SUSPEND_WAKE)
+		ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
+	if (ret < 0)
+		return ret;
+	if (ret == BMA220_SUSPEND_WAKE)
+		return -EBUSY;
+
+	return 0;
+}
+
+static int bma220_power(struct spi_device *spi, bool up)
+{
+	int i, ret;
+
+	/**
+	 * The chip can be suspended/woken up by a simple register read.
+	 * So, we need up to 2 register reads of the suspend register
+	 * to make sure that the device is in the desired state.
+	 */
+	for (i = 0; i < 2; i++) {
+		ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
+		if (ret < 0)
+			return ret;
+
+		if (up && ret == BMA220_SUSPEND_SLEEP)
+			return 0;
+
+		if (!up && ret == BMA220_SUSPEND_WAKE)
+			return 0;
+	}
+
+	return -EBUSY;
+}
+
+static void bma220_deinit(void *spi)
+{
+	bma220_power(spi, false);
+}
+
+int bma220_common_probe(struct spi_device *spi)
+{
+	int ret;
+	struct iio_dev *indio_dev;
+	struct bma220_data *data;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->spi_device = spi;
+	mutex_init(&data->lock);
+
+	indio_dev->info = &bma220_info;
+	indio_dev->name = BMA220_DEVICE_NAME;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = bma220_channels;
+	indio_dev->num_channels = ARRAY_SIZE(bma220_channels);
+	indio_dev->available_scan_masks = bma220_accel_scan_masks;
+
+	ret = bma220_init(data->spi_device);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&spi->dev, bma220_deinit, spi);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      bma220_trigger_handler, NULL);
+	if (ret < 0) {
+		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+EXPORT_SYMBOL_NS(bma220_common_probe, "IIO_BOSCH_BMA220");
+
+static int bma220_suspend(struct device *dev)
+{
+	struct spi_device *spi = to_spi_device(dev);
+
+	return bma220_power(spi, false);
+}
+
+static int bma220_resume(struct device *dev)
+{
+	struct spi_device *spi = to_spi_device(dev);
+
+	return bma220_power(spi, true);
+}
+EXPORT_NS_SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume,
+			    IIO_BOSCH_BMA220);
+
+MODULE_AUTHOR("Tiberiu Breana <tiberiu.a.breana@intel.com>");
+MODULE_DESCRIPTION("BMA220 acceleration sensor driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 01592eebf05bb6b002d44c41cca1d2dd5f28350c..3ad5e43aae496d265a8cf198595bf824f8e73692 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -5,326 +5,45 @@
  * Copyright (c) 2016,2020 Intel Corporation.
  */
 
-#include <linux/bits.h>
-#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/spi/spi.h>
 
-#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-#include <linux/iio/trigger_consumer.h>
-#include <linux/iio/triggered_buffer.h>
 
-#define BMA220_REG_ID				0x00
-#define BMA220_REG_ACCEL_X			0x02
-#define BMA220_REG_ACCEL_Y			0x03
-#define BMA220_REG_ACCEL_Z			0x04
-#define BMA220_REG_RANGE			0x11
-#define BMA220_REG_SUSPEND			0x18
+#include "bma220.h"
 
-#define BMA220_CHIP_ID				0xDD
-#define BMA220_READ_MASK			BIT(7)
-#define BMA220_RANGE_MASK			GENMASK(1, 0)
-#define BMA220_SUSPEND_SLEEP			0xFF
-#define BMA220_SUSPEND_WAKE			0x00
-
-#define BMA220_DEVICE_NAME			"bma220"
-
-#define BMA220_ACCEL_CHANNEL(index, reg, axis) {			\
-	.type = IIO_ACCEL,						\
-	.address = reg,							\
-	.modified = 1,							\
-	.channel2 = IIO_MOD_##axis,					\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
-	.scan_index = index,						\
-	.scan_type = {							\
-		.sign = 's',						\
-		.realbits = 6,						\
-		.storagebits = 8,					\
-		.shift = 2,						\
-		.endianness = IIO_CPU,					\
-	},								\
-}
-
-enum bma220_axis {
-	AXIS_X,
-	AXIS_Y,
-	AXIS_Z,
-};
-
-static const int bma220_scale_table[][2] = {
-	{0, 623000}, {1, 248000}, {2, 491000}, {4, 983000},
-};
-
-struct bma220_data {
-	struct spi_device *spi_device;
-	struct mutex lock;
-	struct {
-		s8 chans[3];
-		/* Ensure timestamp is naturally aligned. */
-		aligned_s64 timestamp;
-	} scan;
-	u8 tx_buf[2] __aligned(IIO_DMA_MINALIGN);
-};
-
-static const struct iio_chan_spec bma220_channels[] = {
-	BMA220_ACCEL_CHANNEL(0, BMA220_REG_ACCEL_X, X),
-	BMA220_ACCEL_CHANNEL(1, BMA220_REG_ACCEL_Y, Y),
-	BMA220_ACCEL_CHANNEL(2, BMA220_REG_ACCEL_Z, Z),
-	IIO_CHAN_SOFT_TIMESTAMP(3),
-};
-
-static inline int bma220_read_reg(struct spi_device *spi, u8 reg)
-{
-	return spi_w8r8(spi, reg | BMA220_READ_MASK);
-}
-
-static const unsigned long bma220_accel_scan_masks[] = {
-	BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
-	0
-};
-
-static irqreturn_t bma220_trigger_handler(int irq, void *p)
-{
-	int ret;
-	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->indio_dev;
-	struct bma220_data *data = iio_priv(indio_dev);
-	struct spi_device *spi = data->spi_device;
-
-	mutex_lock(&data->lock);
-	data->tx_buf[0] = BMA220_REG_ACCEL_X | BMA220_READ_MASK;
-	ret = spi_write_then_read(spi, data->tx_buf, 1, &data->scan.chans,
-				  ARRAY_SIZE(bma220_channels) - 1);
-	if (ret < 0)
-		goto err;
-
-	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
-				    pf->timestamp);
-err:
-	mutex_unlock(&data->lock);
-	iio_trigger_notify_done(indio_dev->trig);
-
-	return IRQ_HANDLED;
-}
-
-static int bma220_read_raw(struct iio_dev *indio_dev,
-			   struct iio_chan_spec const *chan,
-			   int *val, int *val2, long mask)
-{
-	int ret;
-	u8 range_idx;
-	struct bma220_data *data = iio_priv(indio_dev);
-
-	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		ret = bma220_read_reg(data->spi_device, chan->address);
-		if (ret < 0)
-			return -EINVAL;
-		*val = sign_extend32(ret >> chan->scan_type.shift,
-				     chan->scan_type.realbits - 1);
-		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE:
-		ret = bma220_read_reg(data->spi_device, BMA220_REG_RANGE);
-		if (ret < 0)
-			return ret;
-		range_idx = ret & BMA220_RANGE_MASK;
-		*val = bma220_scale_table[range_idx][0];
-		*val2 = bma220_scale_table[range_idx][1];
-		return IIO_VAL_INT_PLUS_MICRO;
-	}
-
-	return -EINVAL;
-}
-
-static int bma220_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int val, int val2, long mask)
+static int bma220_spi_probe(struct spi_device *spi)
 {
-	int i;
-	int ret;
-	int index = -1;
-	struct bma220_data *data = iio_priv(indio_dev);
-
-	switch (mask) {
-	case IIO_CHAN_INFO_SCALE:
-		for (i = 0; i < ARRAY_SIZE(bma220_scale_table); i++)
-			if (val == bma220_scale_table[i][0] &&
-			    val2 == bma220_scale_table[i][1]) {
-				index = i;
-				break;
-			}
-		if (index < 0)
-			return -EINVAL;
-
-		mutex_lock(&data->lock);
-		data->tx_buf[0] = BMA220_REG_RANGE;
-		data->tx_buf[1] = index;
-		ret = spi_write(data->spi_device, data->tx_buf,
-				sizeof(data->tx_buf));
-		if (ret < 0)
-			dev_err(&data->spi_device->dev,
-				"failed to set measurement range\n");
-		mutex_unlock(&data->lock);
-
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-static int bma220_read_avail(struct iio_dev *indio_dev,
-			     struct iio_chan_spec const *chan,
-			     const int **vals, int *type, int *length,
-			     long mask)
-{
-	switch (mask) {
-	case IIO_CHAN_INFO_SCALE:
-		*vals = (int *)bma220_scale_table;
-		*type = IIO_VAL_INT_PLUS_MICRO;
-		*length = ARRAY_SIZE(bma220_scale_table) * 2;
-		return IIO_AVAIL_LIST;
-	default:
-		return -EINVAL;
-	}
-}
-
-static const struct iio_info bma220_info = {
-	.read_raw		= bma220_read_raw,
-	.write_raw		= bma220_write_raw,
-	.read_avail		= bma220_read_avail,
-};
-
-static int bma220_init(struct spi_device *spi)
-{
-	int ret;
-
-	ret = bma220_read_reg(spi, BMA220_REG_ID);
-	if (ret != BMA220_CHIP_ID)
-		return -ENODEV;
-
-	/* Make sure the chip is powered on */
-	ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
-	if (ret == BMA220_SUSPEND_WAKE)
-		ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
-	if (ret < 0)
-		return ret;
-	if (ret == BMA220_SUSPEND_WAKE)
-		return -EBUSY;
-
-	return 0;
-}
-
-static int bma220_power(struct spi_device *spi, bool up)
-{
-	int i, ret;
-
-	/**
-	 * The chip can be suspended/woken up by a simple register read.
-	 * So, we need up to 2 register reads of the suspend register
-	 * to make sure that the device is in the desired state.
-	 */
-	for (i = 0; i < 2; i++) {
-		ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
-		if (ret < 0)
-			return ret;
-
-		if (up && ret == BMA220_SUSPEND_SLEEP)
-			return 0;
-
-		if (!up && ret == BMA220_SUSPEND_WAKE)
-			return 0;
-	}
-
-	return -EBUSY;
-}
-
-static void bma220_deinit(void *spi)
-{
-	bma220_power(spi, false);
-}
-
-static int bma220_probe(struct spi_device *spi)
-{
-	int ret;
-	struct iio_dev *indio_dev;
-	struct bma220_data *data;
-
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
-	if (!indio_dev)
-		return -ENOMEM;
-
-	data = iio_priv(indio_dev);
-	data->spi_device = spi;
-	mutex_init(&data->lock);
-
-	indio_dev->info = &bma220_info;
-	indio_dev->name = BMA220_DEVICE_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = bma220_channels;
-	indio_dev->num_channels = ARRAY_SIZE(bma220_channels);
-	indio_dev->available_scan_masks = bma220_accel_scan_masks;
-
-	ret = bma220_init(data->spi_device);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(&spi->dev, bma220_deinit, spi);
-	if (ret)
-		return ret;
-
-	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
-					      iio_pollfunc_store_time,
-					      bma220_trigger_handler, NULL);
-	if (ret < 0) {
-		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
-		return ret;
-	}
-
-	return devm_iio_device_register(&spi->dev, indio_dev);
-}
-
-static int bma220_suspend(struct device *dev)
-{
-	struct spi_device *spi = to_spi_device(dev);
-
-	return bma220_power(spi, false);
-}
-
-static int bma220_resume(struct device *dev)
-{
-	struct spi_device *spi = to_spi_device(dev);
-
-	return bma220_power(spi, true);
+	return bma220_common_probe(spi);
 }
-static DEFINE_SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume);
 
 static const struct spi_device_id bma220_spi_id[] = {
-	{"bma220", 0},
+	{ "bma220", 0 },
 	{ }
 };
 
 static const struct acpi_device_id bma220_acpi_id[] = {
-	{"BMA0220", 0},
+	{ "BMA0220", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, bma220_spi_id);
 
-static struct spi_driver bma220_driver = {
+static struct spi_driver bma220_spi_driver = {
 	.driver = {
 		.name = "bma220_spi",
 		.pm = pm_sleep_ptr(&bma220_pm_ops),
 		.acpi_match_table = bma220_acpi_id,
 	},
-	.probe =            bma220_probe,
+	.probe =            bma220_spi_probe,
 	.id_table =         bma220_spi_id,
 };
-module_spi_driver(bma220_driver);
+module_spi_driver(bma220_spi_driver);
 
 MODULE_AUTHOR("Tiberiu Breana <tiberiu.a.breana@intel.com>");
-MODULE_DESCRIPTION("BMA220 acceleration sensor driver");
-MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("BMA220 triaxial acceleration sensor spi driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_BOSCH_BMA220");

-- 
2.49.1


