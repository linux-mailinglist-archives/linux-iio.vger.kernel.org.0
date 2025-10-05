Return-Path: <linux-iio+bounces-24749-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FD4BB96D0
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 15:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 030231896D39
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 13:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF7528C5AA;
	Sun,  5 Oct 2025 13:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="sA9kx2Z0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D69526B77A;
	Sun,  5 Oct 2025 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759669994; cv=none; b=cA167e7Uyg8sIcw12Hxlk1SK9Dqhk8Ql9Nc3nYgFA21ej90ZW1YPWo08cNt+yuNkbaRDzvPEU9cIlIr1BTV8FZlFSgFOUXTembrk9v0yU4kMlnTvuZGHDHGoVOZLqFFd+rJXqNAkcrCVDx+Ft5PkL3FM56QBwQ19e5/fNU+LFTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759669994; c=relaxed/simple;
	bh=jro1VObDw/+YJ067lwEIyPUj7p3ellBKy+TVENoHWU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=blwERTJx5c9DFzACvR/J0H2lM+yfHGVORxxYr7q5Wz5EXX771GqLc6ESbu/JyWbvCoNOMmIZZH8kDQA03NVrR1bn6XsnZ0U3zsgWfk9fPQ3Fv/8/cd/e5xPEDyQ1ypURoDIgswXqSTi5gUHnTWLA5XRidpmFF+qhraVqjIxcf9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=sA9kx2Z0; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 98D3F173BEF;
	Sun, 05 Oct 2025 16:13:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1759669982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9CTKqybKYjFXq99qQgQ1VpGJT0bjDAKu41fSxOEQb0Q=;
	b=sA9kx2Z0iQTIEl0GCimTHVD6fYuxxH8ily59fg2pmKR6u+rKa/gvwl8TaYNgS+Jyq5Vv/N
	k+6U8xM5KBARVoXRivxEfvOH1MMvzgIgfT2UzOcGNNKpjnf8Lc7i5dpCwV5Xo6cLl7uLqj
	iAYg7nZS3cJrvKUJ7b421yGdQKPmVGNFIOfnCELfkGzlQqk5BDt5jOC7qGEKVzsgOb2atR
	TVusx+l4oz0Sb0tbz/mo0RXa2VuOthZU97wKZvRvGtddWPf1k3Rs/XMnoosjocfo7pcvnu
	2g5GSrkzsRTashzd6wxd7WW3pFWwCSQCxk6xRVKwQdP1XH46PSlpFITQ+xM1HQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sun, 05 Oct 2025 16:12:16 +0300
Subject: [PATCH v4 07/19] iio: accel: bma220: split original driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251005-b4-bma220_improvements-v4-7-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
In-Reply-To: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=21441;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=jro1VObDw/+YJ067lwEIyPUj7p3ellBKy+TVENoHWU8=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2ppYnIxaVN6OE5ZZDFMbmp0MXlhV2pNYlBwClgvNlgzNFdGTDlDNmNZMWF0
 RTFlcklrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzRtNjl
 BQW9KRUhRcko2ZGpPa2xqVEY0UC9STm15SG9xT0k5MFZ1djZkYzRqTWJBb0xoSERkemkyMjJUVw
 pDWk1QVXM3NXA4M2hhVjM5dmlROUxoVTJuUkZ2K1ZiOHA4L1pjNXlIOU1JU0tlUktMVTh3My85N
 W9pbDJ3bU9FClg0YXV4VnVBSDh1aGEwVEswRVFMc0wrWEpibnAyeE1ONlJoSkNjMGRnNEJtaE1p
 V21YTTRpSmlwTDg5c21HUVEKSitQVE5EdDFzcjl6UmtkUUVXNXY4V0swNi90U2NibENCSjNHVnB
 VMTlhZURKY3lsVWFMNDVwUkQ1akRPQ3VKMwpiZC9kTkRoTC9PZ3NobGhWUmtrdWNpMmVxaTlDbX
 Q0STgrSnpyOTBsV0RHN2hlMExyWTFzUEQwREtOeStTdkpuCkhCcTZRMXk5T1p2SHdtc2R4Rm42T
 nZRRGtiR1BEUEtFcmYvNDJEWVZVeER3R3VrdGpTZmxlUy9pTnFNTjJpRTIKdkRrSGl3VVlWekU2
 U29PdDJKZnVpRXdxY3U5RElrTzlzcm1JenVxRkR1UFdKdGV0MXVDU1VzT2lHZVR2Tkl2RQpTNjB
 5aGZBTlozcVVOQnY3SC9Yc0QwNC96cUtqRi96R3ZhQXRabEw2TElBb3NmNnArUjUyeWhkMDB3Q2
 QvMFVvCjErc2pnemMwdTNVd3ZHRnZBRmZFV3ZmUkN5SU9QTU1tcllnSjFLcUFYRVhjZ2FrRXJqV
 XJCMVZsYStSOURyUFkKaVlNYWxIQXY1dlI0K25qQ1Q3bkQ2elBhYUFOZWpCeTZKL2h2UXYydWFK
 clI2YnJQd3VSdkQ2WkE1b0ovTHJQNApyK2ZXcHYxNzA2ZFZjaHF5aXZsQVdRWVdIY0h5a0UvbUx
 SOU5FaG9pdEdJWFUzdkVrWldtbXFXNmNrSDErZ2xaCmdnRjRDNHVHSm1BbXdRPT0KPWYvWXoKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

In preparation for the i2c module, move the original code into multiple
source files without any other functional change.

Create the additional bma220_core module which currently is not
providing an abstracted bus type (this will change with the regmap
patch).
Fix a few includes in the context of this patch.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1->v2
- split out open firmware table modification into separate patch
- bma220_write_raw() exits without dev_err() based on similar feedback
  from David
- change includes in bma220.h (Jonathan)
- include bma220.h in bma220_core.c (Jonathan)
- add mutex.h and pm.h includes to bma220_core.c
- cleanup struct spacing in bma220_spi.c
v2->v3
- keep depends on SPI (David)
- fix a few includes in bma220_spi.c (Jonathan)
v2->v3
- keep depends on SPI (David)
- fix a few includes in bma220_spi.c (Jonathan)
- mention new includes in commit body (Jonathan)
v4 move some of the changes into precursor patches (01-07) (Andy)
---
 drivers/iio/accel/Kconfig       |   8 +-
 drivers/iio/accel/Makefile      |   3 +-
 drivers/iio/accel/bma220.h      |  18 +++
 drivers/iio/accel/bma220_core.c | 319 ++++++++++++++++++++++++++++++++++++++++
 drivers/iio/accel/bma220_spi.c  | 314 ++-------------------------------------
 5 files changed, 357 insertions(+), 305 deletions(-)

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
index 0000000000000000000000000000000000000000..00fe1064486aa469f7ad15593027c7ec86197365
--- /dev/null
+++ b/drivers/iio/accel/bma220_core.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * BMA220 Digital triaxial acceleration sensor driver
+ *
+ * Copyright (c) 2016,2020 Intel Corporation.
+ */
+
+#include <linux/bits.h>
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
+static int bma220_power(struct spi_device *spi, bool up)
+{
+	int ret;
+	unsigned int i;
+
+	/*
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
+static int bma220_init(struct spi_device *spi)
+{
+	int ret;
+	struct device *dev = &spi->dev;
+
+	ret = bma220_read_reg(spi, BMA220_REG_ID);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to read chip id register\n");
+
+	if (ret != BMA220_CHIP_ID)
+		dev_info(dev, "Unknown chip found: 0x%02x\n", ret);
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
+	struct device *dev = &spi->dev;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
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
+	ret = devm_add_action_or_reset(dev, bma220_deinit, spi);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      bma220_trigger_handler, NULL);
+	if (ret < 0) {
+		dev_err(dev, "iio triggered buffer setup failed\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(dev, indio_dev);
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
index abff24a48e5aaa5efb05cdf1924ffea24f4da4c5..70b8bd94895e95936c7294271b5d46d9ec9903c6 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -5,334 +5,42 @@
  * Copyright (c) 2016,2020 Intel Corporation.
  */
 
-#include <linux/bits.h>
+#include <linux/errno.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/pm.h>
 #include <linux/types.h>
 #include <linux/spi/spi.h>
 
-#include <linux/iio/buffer.h>
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-#include <linux/iio/trigger_consumer.h>
-#include <linux/iio/triggered_buffer.h>
+#include "bma220.h"
 
-#define BMA220_REG_ID				0x00
-#define BMA220_REG_ACCEL_X			0x02
-#define BMA220_REG_ACCEL_Y			0x03
-#define BMA220_REG_ACCEL_Z			0x04
-#define BMA220_REG_RANGE			0x11
-#define BMA220_REG_SUSPEND			0x18
-
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
+static int bma220_spi_probe(struct spi_device *spi)
 {
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
-{
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
-static int bma220_power(struct spi_device *spi, bool up)
-{
-	int ret;
-	unsigned int i;
-
-	/*
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
-static int bma220_init(struct spi_device *spi)
-{
-	int ret;
-	struct device *dev = &spi->dev;
-
-	ret = bma220_read_reg(spi, BMA220_REG_ID);
-	if (ret < 0)
-		return dev_err_probe(dev, ret,
-				     "Failed to read chip id register\n");
-
-	if (ret != BMA220_CHIP_ID)
-		dev_info(dev, "Unknown chip found: 0x%02x\n", ret);
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
-	struct device *dev = &spi->dev;
-
-	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
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
-	ret = devm_add_action_or_reset(dev, bma220_deinit, spi);
-	if (ret)
-		return ret;
-
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      iio_pollfunc_store_time,
-					      bma220_trigger_handler, NULL);
-	if (ret < 0) {
-		dev_err(dev, "iio triggered buffer setup failed\n");
-		return ret;
-	}
-
-	return devm_iio_device_register(dev, indio_dev);
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
+MODULE_DESCRIPTION("BMA220 triaxial acceleration sensor spi driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_BOSCH_BMA220");

-- 
2.49.1


