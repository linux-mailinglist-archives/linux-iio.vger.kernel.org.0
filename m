Return-Path: <linux-iio+bounces-24742-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD162BB969D
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 15:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318901896AF9
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 13:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CDB288529;
	Sun,  5 Oct 2025 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="OoOfreDv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15E72874E0;
	Sun,  5 Oct 2025 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759669992; cv=none; b=YqVOec6sloOkTI+aqyfowUCIiawVrQLHwUQrkZejA33IiSHOuzr8cniavUdEI10RHGfqSdruxVi8Lm8uIBnP54sLguR2/KSWW/ZMF2w+yX3LMN+x2NQ7FBvQJfWQ/1cAXafeREMJ3VTyzwtV0qLUDEDNiKGYYZ7XIQnDQ9/Qehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759669992; c=relaxed/simple;
	bh=WYAk4xK9TcHQO+TISTFVKxZcSfvOy87cgNMD+pjBtjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KIrWnPpaQ2jqEwwdlH3U2phZ1wkCTVbktqpB71FFepioQwZFfUHW/eLUR3JS+1fPiDEOeaVRhQffXFKYEzawW4MPvcTdAX3jzKUA2hSw0+2kznv3/++XrNkMdYsuZdG1O/kyCbYHbyxdDY2Bd0poeQERWa72S8XYEVpIM3sEHaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=OoOfreDv; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 2390B173BF3;
	Sun, 05 Oct 2025 16:13:04 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1759669984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PzA+0Ggxa72v3ATdFvgDPZQKXibCoX2v71s6OVwgWaQ=;
	b=OoOfreDvvGNTD1kz+NVGkVD8iYPpBQoCItAAk0KmoEJCqJceYgJaMcYwP5EbrItLCkf/8l
	2GJiv1Gi2rQsR3SpnqWXFKjN+ZgNA37jUUFOeQRO5q5iie8DqrujChPpW9TLBQ7c7v0CYH
	3iD8NxY6r2if8DaZeO7wb60KJyLMqQOYgEMHQ2JBkeutR71rGtO4NBUm6XVR4dzkjKrmIy
	0NldVkKGvpfRV6b91ZGeIl+GadYsnNVtZEKLWt6PLkd65jfW+05wVnlq+Lgv9cJOTXjFXF
	Ydb9c/hC957aqCFzqi96IA/lmKdYe9RzdUOSolT31gNZ/wKW7khPolkWehkNIg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sun, 05 Oct 2025 16:12:20 +0300
Subject: [PATCH v4 11/19] iio: accel: bma220: migrate to regmap API
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251005-b4-bma220_improvements-v4-11-0f449ba31585@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=16055;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=WYAk4xK9TcHQO+TISTFVKxZcSfvOy87cgNMD+pjBtjQ=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2ppYnNaR284OWYvSUJwQXNWdmxJNWw0b3FFCjFWNmtaWXVWY2t4WFp1dTNa
 VTNUOFlrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzRtN0d
 BQW9KRUhRcko2ZGpPa2xqdGgwUUFKWlVjY0w0dnBQa1IvVWJzWUdqeG1vMkQ5bG5CcnIxUHQ2ZQ
 p1VWdNM1ZyQ2RnbEU5ZDdqQml3bTJPMkt1Vi9qRHVLV3VtcnpYSlRPcTVnZnIzVGpJTklUTEg4e
 W9oaW5jM3NzCnlQblpSTVJha0NCZ3FHblVsc3ZYS3ZWZWx6TDRmOGJ1b1VMSlArOE1KaWRzNnhU
 Z09NcmdFUVpxN0lEL2VYSEwKSHowTmw2MDhnWnBZc0dtVHdwd3dKc1QwUE51ZFFGY2E5dW9LKzh
 YbWk3U2dxaVFNU3JpUWxBUjNnNWFIKzZ0MAorQ2tqVVZ3N3d5YWZ6Wkx4ajErMEN0ODRUSU1JaV
 FiY1Ztb3ZndE91K1U2a0dPV1NjbkZDK0VRRTlTODU0Z0JTClJvYlRpRlpSdHVKbWV2bFFlYmd2a
 VkvZXRlM0I1ZDB1ZVFoOS9rUGtGdlRIRkNvK0hWY1A4L1NFMldURk1YcUUKSnExTDRNN3VpWXRY
 WUErdlR4TGRhZCtVWmw4d01XUDRsVVQvMlBwNDRaNVovV3paUjY3cGJBRWtaOCtOdUovcApFK3E
 4ZVFKSlAyZlJnclY3Sm5JNFdkOUY3Ui9FQTZjcUQ1YmxVY0FVOTZUVGpoVjR2K0pVTjJTa0xQUV
 BydXpKCmVzYzRQUTlVWU5lZTEvQmhIZDBVM1lNcXlmdkVDVCtnZHBGV0ViNnhBVHFEM0tITFZNS
 Ct5Si8rV0x6VXVmdmcKdWlOZkFDQXRZazhMQm1zS05TQWhPMGk0RDhqMVU2NHFhZnk5VzJUTGVm
 RDBpRE10Qno0RHJPeVFwVkZQS1owdApReVN4eDFSdHc2Qk1QQUZqU3pCa2ExZW5xSjBHekRYc1B
 lQWFRVGQwc3VOdXVqQWhUU21WT3RKdmNEbE5KRW81ClhkQ3FuSTk2UkJzb3hBPT0KPTE0bUIKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Switch to regmap API.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1->v2
- split out into more patches (Jonathan)
v2->v3
- split out into even more patches (Jonathan)
- use dev_err_probe() (Jonathan)
v4 remove dev from priv struct (Andy)
---
 drivers/iio/accel/Kconfig       |   2 +
 drivers/iio/accel/bma220.h      |   7 +-
 drivers/iio/accel/bma220_core.c | 231 +++++++++++++++++++++++++++-------------
 drivers/iio/accel/bma220_spi.c  |  10 +-
 4 files changed, 173 insertions(+), 77 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 4648be329917a3054615ed324156d67f53baefb6..988fe4b1f9a52c2e671ea30d8590f25ee1685ac7 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -219,6 +219,7 @@ config BMA180
 config BMA220
 	tristate "Bosch BMA220 3-Axis Accelerometer Driver"
 	depends on SPI
+	select REGMAP
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	select BMA220_SPI if SPI
@@ -232,6 +233,7 @@ config BMA220
 
 config BMA220_SPI
 	tristate
+	select REGMAP_SPI
 	depends on BMA220
 
 config BMA400
diff --git a/drivers/iio/accel/bma220.h b/drivers/iio/accel/bma220.h
index dea34244b4fc4971841dc60d79db6c7db27bea20..695f491bc5a03008f26fe8602ba633456159fb1d 100644
--- a/drivers/iio/accel/bma220.h
+++ b/drivers/iio/accel/bma220.h
@@ -9,10 +9,13 @@
 #define _BMA220_H
 
 #include <linux/pm.h>
+#include <linux/regmap.h>
 
+struct device;
+
+extern const struct regmap_config bma220_spi_regmap_config;
 extern const struct dev_pm_ops bma220_pm_ops;
-struct spi_device;
 
-int bma220_common_probe(struct spi_device *dev);
+int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq);
 
 #endif
diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 1b118a9fce3f16f0cd805a68b9887c6eaf24973a..7b1e87c6932a3a6698651e528fb8182c03a2432e 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -3,16 +3,20 @@
  * BMA220 Digital triaxial acceleration sensor driver
  *
  * Copyright (c) 2016,2020 Intel Corporation.
+ * Copyright (c) 2025 Petre Rodan  <petre.rodan@subdimension.ro>
  */
 
 #include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pm.h>
+#include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/types.h>
-#include <linux/spi/spi.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
@@ -23,16 +27,63 @@
 #include "bma220.h"
 
 #define BMA220_REG_ID				0x00
+#define BMA220_REG_REVISION_ID			0x01
 #define BMA220_REG_ACCEL_X			0x02
 #define BMA220_REG_ACCEL_Y			0x03
 #define BMA220_REG_ACCEL_Z			0x04
+#define BMA220_REG_CONF0			0x05
+#define BMA220_HIGH_DUR_MSK			GENMASK(5, 0)
+#define BMA220_HIGH_HY_MSK			GENMASK(7, 6)
+#define BMA220_REG_CONF1			0x06
+#define BMA220_HIGH_TH_MSK			GENMASK(3, 0)
+#define BMA220_LOW_TH_MSK			GENMASK(7, 4)
+#define BMA220_REG_CONF2			0x07
+#define BMA220_LOW_DUR_MSK			GENMASK(5, 0)
+#define BMA220_LOW_HY_MSK			GENMASK(7, 6)
+#define BMA220_REG_CONF3			0x08
+#define BMA220_TT_DUR_MSK			GENMASK(2, 0)
+#define BMA220_TT_TH_MSK			GENMASK(6, 3)
+#define BMA220_REG_CONF4			0x09
+#define BMA220_SLOPE_DUR_MSK			GENMASK(1, 0)
+#define BMA220_SLOPE_TH_MSK			GENMASK(5, 2)
+#define BMA220_REG_CONF5			0x0a
+#define BMA220_TIP_EN_MSK			BIT(4)
+#define BMA220_REG_IF0				0x0b
+#define BMA220_REG_IF1				0x0c
+#define BMA220_IF_SLOPE				BIT(0)
+#define BMA220_IF_DRDY				BIT(1)
+#define BMA220_IF_HIGH				BIT(2)
+#define BMA220_IF_LOW				BIT(3)
+#define BMA220_IF_TT				BIT(4)
+#define BMA220_REG_IE0				0x0d
+#define BMA220_INT_EN_TAP_Z_MSK			BIT(0)
+#define BMA220_INT_EN_TAP_Y_MSK			BIT(1)
+#define BMA220_INT_EN_TAP_X_MSK			BIT(2)
+#define BMA220_INT_EN_SLOPE_Z_MSK		BIT(3)
+#define BMA220_INT_EN_SLOPE_Y_MSK		BIT(4)
+#define BMA220_INT_EN_SLOPE_X_MSK		BIT(5)
+#define BMA220_INT_EN_DRDY_MSK			BIT(7)
+#define BMA220_REG_IE1				0x0e
+#define BMA220_INT_EN_HIGH_Z_MSK		BIT(0)
+#define BMA220_INT_EN_HIGH_Y_MSK		BIT(1)
+#define BMA220_INT_EN_HIGH_X_MSK		BIT(2)
+#define BMA220_INT_EN_LOW_MSK			BIT(3)
+#define BMA220_INT_LATCH_MSK			GENMASK(6, 4)
+#define BMA220_INT_RST_MSK			BIT(7)
+#define BMA220_REG_IE2				0x0f
+#define BMA220_REG_FILTER			0x10
+#define BMA220_FILTER_MASK			GENMASK(3, 0)
 #define BMA220_REG_RANGE			0x11
+#define BMA220_RANGE_MASK			GENMASK(1, 0)
+#define BMA220_REG_WDT				0x17
+#define BMA220_WDT_MASK				GENMASK(2, 1)
+#define BMA220_WDT_OFF				0x0
+#define BMA220_WDT_1MS				0x2
+#define BMA220_WDT_10MS				0x3
 #define BMA220_REG_SUSPEND			0x18
 #define BMA220_REG_SOFTRESET			0x19
 
 #define BMA220_CHIP_ID				0xDD
-#define BMA220_READ_MASK			BIT(7)
-#define BMA220_RANGE_MASK			GENMASK(1, 0)
 #define BMA220_SUSPEND_SLEEP			0xFF
 #define BMA220_SUSPEND_WAKE			0x00
 #define BMA220_RESET_MODE			0xFF
@@ -68,14 +119,14 @@ static const int bma220_scale_table[][2] = {
 };
 
 struct bma220_data {
-	struct spi_device *spi_device;
+	struct regmap *regmap;
 	struct mutex lock;
+	u8 range_idx;
 	struct {
 		s8 chans[3];
 		/* Ensure timestamp is naturally aligned. */
 		aligned_s64 timestamp;
-	} scan;
-	u8 tx_buf[2] __aligned(IIO_DMA_MINALIGN);
+	} scan __aligned(IIO_DMA_MINALIGN);
 };
 
 static const struct iio_chan_spec bma220_channels[] = {
@@ -85,35 +136,57 @@ static const struct iio_chan_spec bma220_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
-static inline int bma220_read_reg(struct spi_device *spi, u8 reg)
-{
-	return spi_w8r8(spi, reg | BMA220_READ_MASK);
-}
-
 static const unsigned long bma220_accel_scan_masks[] = {
 	BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
 	0
 };
 
+static bool bma220_is_writable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BMA220_REG_CONF0:
+	case BMA220_REG_CONF1:
+	case BMA220_REG_CONF2:
+	case BMA220_REG_CONF3:
+	case BMA220_REG_CONF4:
+	case BMA220_REG_CONF5:
+	case BMA220_REG_IE0:
+	case BMA220_REG_IE1:
+	case BMA220_REG_IE2:
+	case BMA220_REG_FILTER:
+	case BMA220_REG_RANGE:
+	case BMA220_REG_WDT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+const struct regmap_config bma220_spi_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.read_flag_mask = BIT(7),
+	.max_register = BMA220_REG_SOFTRESET,
+	.cache_type = REGCACHE_NONE,
+	.writeable_reg = bma220_is_writable_reg,
+};
+EXPORT_SYMBOL_NS_GPL(bma220_spi_regmap_config, "IIO_BOSCH_BMA220");
+
 static irqreturn_t bma220_trigger_handler(int irq, void *p)
 {
 	int ret;
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bma220_data *data = iio_priv(indio_dev);
-	struct spi_device *spi = data->spi_device;
 
-	mutex_lock(&data->lock);
-	data->tx_buf[0] = BMA220_REG_ACCEL_X | BMA220_READ_MASK;
-	ret = spi_write_then_read(spi, data->tx_buf, 1, &data->scan.chans,
-				  ARRAY_SIZE(bma220_channels) - 1);
+	ret = regmap_bulk_read(data->regmap, BMA220_REG_ACCEL_X,
+			       &data->scan.chans,
+			       sizeof(data->scan.chans));
 	if (ret < 0)
-		goto err;
+		return IRQ_NONE;
 
 	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
 				    pf->timestamp);
-err:
-	mutex_unlock(&data->lock);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
@@ -124,24 +197,24 @@ static int bma220_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long mask)
 {
 	int ret;
-	u8 range_idx;
+	u8 index;
+	unsigned int reg;
 	struct bma220_data *data = iio_priv(indio_dev);
 
+	guard(mutex)(&data->lock);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = bma220_read_reg(data->spi_device, chan->address);
+		ret = regmap_read(data->regmap, chan->address, &reg);
 		if (ret < 0)
 			return -EINVAL;
-		*val = sign_extend32(ret >> chan->scan_type.shift,
+		*val = sign_extend32(reg >> chan->scan_type.shift,
 				     chan->scan_type.realbits - 1);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		ret = bma220_read_reg(data->spi_device, BMA220_REG_RANGE);
-		if (ret < 0)
-			return ret;
-		range_idx = ret & BMA220_RANGE_MASK;
-		*val = bma220_scale_table[range_idx][0];
-		*val2 = bma220_scale_table[range_idx][1];
+		index = data->range_idx;
+		*val = bma220_scale_table[index][0];
+		*val2 = bma220_scale_table[index][1];
 		return IIO_VAL_INT_PLUS_MICRO;
 	}
 
@@ -157,6 +230,8 @@ static int bma220_write_raw(struct iio_dev *indio_dev,
 	int index = -1;
 	struct bma220_data *data = iio_priv(indio_dev);
 
+	guard(mutex)(&data->lock);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		for (i = 0; i < ARRAY_SIZE(bma220_scale_table); i++)
@@ -168,14 +243,12 @@ static int bma220_write_raw(struct iio_dev *indio_dev,
 		if (index < 0)
 			return -EINVAL;
 
-		mutex_lock(&data->lock);
-		data->tx_buf[0] = BMA220_REG_RANGE;
-		data->tx_buf[1] = index;
-		ret = spi_write(data->spi_device, data->tx_buf,
-				sizeof(data->tx_buf));
+		ret = regmap_update_bits(data->regmap, BMA220_REG_RANGE,
+					 BMA220_RANGE_MASK,
+					 FIELD_PREP(BMA220_RANGE_MASK, index));
 		if (ret < 0)
 			return ret;
-		mutex_unlock(&data->lock);
+		data->range_idx = index;
 
 		return 0;
 	}
@@ -205,10 +278,10 @@ static const struct iio_info bma220_info = {
 	.read_avail		= bma220_read_avail,
 };
 
-static int bma220_reset(struct spi_device *spi, bool up)
+static int bma220_reset(struct bma220_data *data, bool up)
 {
 	int ret;
-	unsigned int i;
+	unsigned int i, val;
 
 	/*
 	 * The chip can be reset by a simple register read.
@@ -216,24 +289,24 @@ static int bma220_reset(struct spi_device *spi, bool up)
 	 * to make sure that the device is in the desired state.
 	 */
 	for (i = 0; i < 2; i++) {
-		ret = bma220_read_reg(spi, BMA220_REG_SOFTRESET);
+		ret = regmap_read(data->regmap, BMA220_REG_SOFTRESET, &val);
 		if (ret < 0)
 			return ret;
 
-		if (up && ret == BMA220_RESET_MODE)
+		if (up && val == BMA220_RESET_MODE)
 			return 0;
 
-		if (!up && ret == BMA220_NONRESET_MODE)
+		if (!up && val == BMA220_NONRESET_MODE)
 			return 0;
 	}
 
 	return -EBUSY;
 }
 
-static int bma220_power(struct spi_device *spi, bool up)
+static int bma220_power(struct bma220_data *data, bool up)
 {
 	int ret;
-	unsigned int i;
+	unsigned int i, val;
 
 	/*
 	 * The chip can be suspended/woken up by a simple register read.
@@ -241,70 +314,84 @@ static int bma220_power(struct spi_device *spi, bool up)
 	 * to make sure that the device is in the desired state.
 	 */
 	for (i = 0; i < 2; i++) {
-		ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
+		ret = regmap_read(data->regmap, BMA220_REG_SUSPEND, &val);
 		if (ret < 0)
 			return ret;
 
-		if (up && ret == BMA220_SUSPEND_SLEEP)
+		if (up && val == BMA220_SUSPEND_SLEEP)
 			return 0;
 
-		if (!up && ret == BMA220_SUSPEND_WAKE)
+		if (!up && val == BMA220_SUSPEND_WAKE)
 			return 0;
 	}
 
 	return -EBUSY;
 }
 
-static int bma220_init(struct spi_device *spi)
+static int bma220_init(struct device *dev, struct bma220_data *data)
 {
 	int ret;
-	struct device *dev = &spi->dev;
+	unsigned int val;
 	static const char * const regulator_names[] = { "vddd", "vddio", "vdda" };
 
-	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
+	ret = devm_regulator_bulk_get_enable(dev,
+					     ARRAY_SIZE(regulator_names),
 					     regulator_names);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get regulators\n");
 
-	ret = bma220_read_reg(spi, BMA220_REG_ID);
-	if (ret < 0)
+	ret = regmap_read(data->regmap, BMA220_REG_ID, &val);
+	if (ret)
 		return dev_err_probe(dev, ret,
 				     "Failed to read chip id register\n");
 
-	if (ret != BMA220_CHIP_ID)
-		dev_info(dev, "Unknown chip found: 0x%02x\n", ret);
+	if (val != BMA220_CHIP_ID)
+		dev_info(dev, "Unknown chip found: 0x%02x\n", val);
 
-	/* Make sure the chip is powered on and config registers are reset */
-	ret = bma220_power(spi, true);
+	ret = bma220_power(data, true);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to power-on chip\n");
 
-	ret = bma220_reset(spi, true);
+	ret = bma220_reset(data, true);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to soft reset chip\n");
 
 	return 0;
 }
 
-static void bma220_deinit(void *spi)
+static void bma220_deinit(void *data_ptr)
 {
-	bma220_power(spi, false);
+	struct bma220_data *data = data_ptr;
+	int ret;
+	struct device *dev = regmap_get_device(data->regmap);
+
+	ret = bma220_power(data, false);
+	if (ret)
+		dev_warn(dev,
+			 "Failed to put device into suspend mode (%pe)\n",
+			 ERR_PTR(ret));
 }
 
-int bma220_common_probe(struct spi_device *spi)
+int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq)
 {
 	int ret;
 	struct iio_dev *indio_dev;
 	struct bma220_data *data;
-	struct device *dev = &spi->dev;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
-	data->spi_device = spi;
-	mutex_init(&data->lock);
+	data->regmap = regmap;
+
+	ret = bma220_init(dev, data);
+	if (ret)
+		return ret;
+
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
 
 	indio_dev->info = &bma220_info;
 	indio_dev->name = BMA220_DEVICE_NAME;
@@ -313,38 +400,34 @@ int bma220_common_probe(struct spi_device *spi)
 	indio_dev->num_channels = ARRAY_SIZE(bma220_channels);
 	indio_dev->available_scan_masks = bma220_accel_scan_masks;
 
-	ret = bma220_init(data->spi_device);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(dev, bma220_deinit, spi);
+	ret = devm_add_action_or_reset(dev, bma220_deinit, data);
 	if (ret)
 		return ret;
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
 					      bma220_trigger_handler, NULL);
-	if (ret < 0) {
-		dev_err(dev, "iio triggered buffer setup failed\n");
-		return ret;
-	}
+	if (ret < 0)
+		dev_err_probe(dev, ret, "iio triggered buffer setup failed\n");
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-EXPORT_SYMBOL_NS(bma220_common_probe, "IIO_BOSCH_BMA220");
+EXPORT_SYMBOL_NS_GPL(bma220_common_probe, "IIO_BOSCH_BMA220");
 
 static int bma220_suspend(struct device *dev)
 {
-	struct spi_device *spi = to_spi_device(dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct bma220_data *data = iio_priv(indio_dev);
 
-	return bma220_power(spi, false);
+	return bma220_power(data, false);
 }
 
 static int bma220_resume(struct device *dev)
 {
-	struct spi_device *spi = to_spi_device(dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct bma220_data *data = iio_priv(indio_dev);
 
-	return bma220_power(spi, true);
+	return bma220_power(data, true);
 }
 EXPORT_NS_SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume,
 			    IIO_BOSCH_BMA220);
diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index b27592591d2817e2c3f3780f4307e3a76c7e06cb..8990155ac0cd36ace08d1192b4dda3c275ad675e 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -8,6 +8,7 @@
 #include <linux/errno.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/types.h>
 #include <linux/spi/spi.h>
 
@@ -15,7 +16,14 @@
 
 static int bma220_spi_probe(struct spi_device *spi)
 {
-	return bma220_common_probe(spi);
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_spi(spi, &bma220_spi_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
+				     "failed to create regmap\n");
+
+	return bma220_common_probe(&spi->dev, regmap, spi->irq);
 }
 
 static const struct spi_device_id bma220_spi_id[] = {

-- 
2.49.1


