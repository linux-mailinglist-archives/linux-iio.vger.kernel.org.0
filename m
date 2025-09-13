Return-Path: <linux-iio+bounces-24076-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C858FB561FA
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 17:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478D3189FD98
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04B32F6582;
	Sat, 13 Sep 2025 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="nzQARv5s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B3F2F3C22;
	Sat, 13 Sep 2025 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757778019; cv=none; b=Hs/9Bac6jW1Igs0ZJUHxifa0akWrfKP3pKcBNWQHFv1waA4dt1S7cge2rVUn4oLNBWy5qDIuHlBTU2/AIS94m9d/KEq+/2GwXh5M8nJySqniYhT5N2eE/0Vxw466ni/90escxVB+VbN/ywXYR9OfiqCgshEGIOnwZs1hsQ4Z6VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757778019; c=relaxed/simple;
	bh=5Z5fQY124O1ZTsyLp6uOfQ7IKxjVw20DcNlEyNQKf20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tG4BArioNAxMuT9y/k9QAtPiO/KJR0jc0S81pfXQ8JnPwq7jtO+7qyPCJxCx8FJJE7DKbkA1LHcEqmyDVgvzc045zucmsqzgtRYKHpH0pDx3BV4kRxEOxBl5jeoQURQjuO3CeEXk2LxTj8OgHuza5mK8YZbE4HvFBrTXhQ7sAww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=nzQARv5s; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 8C6C5173BF2;
	Sat, 13 Sep 2025 18:40:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757778008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCmRSUGYCg8xSs/+OsTWqTMn8J3LYpsqIOYhQbqzKRY=;
	b=nzQARv5saup7+ZhvcBApnSQR90hge/MUWsLtUSrT2Otl4jX+4pr9RNI0gVs1B6NtHHC9CF
	Dp3iyx85C0SNCqnmq9s6SI81sh7NnREYqKE8yJ9BdD91Fn8ZCpHK2eoCwlCEVbvD5/TKFj
	zphkxtBfn/Nfj4YZGrFF7WvPCVHzLPh2ChD4dRMKRLw5GRtnl5Kp+4VOQa9LNxB4VC8R1i
	nE3gBRUpgZKpTHfYEGlwNIsLAnPF0zi5uaY2x9Uuxqb7DBWhHJlS3NIwF8kDUPmS4p88zV
	YcfQFySmIkNq9LZ9CfElJSuQKreI8YA9HhU9hD5Exkag9n2rCn8Nv7bOGpNvcQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sat, 13 Sep 2025 18:39:31 +0300
Subject: [PATCH v3 10/18] iio: accel: bma220: migrate to regmap API
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-b4-bma220_improvements-v3-10-0b97279b4e45@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=16390;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=5Z5fQY124O1ZTsyLp6uOfQ7IKxjVw20DcNlEyNQKf20=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBoxZBS9jNxQrgN59jcFWJLkI3NPNGd+Amsmy7oG
 uRJFHlANlWJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMWQUgAKCRDPJpmZhE5/
 MCgzEACKce8ek57uy0hdB33iqoLLobKo+jAuVltmW6XjKHMHhsdynStrOenuw9D6xDYezJOlGev
 bVjR6uds6XiMjZU0woCe/N3E/nCkonVvSwTBm7bAdf+hnAfDHLELCYnh++6kk2CaRLD8BCnoW8G
 jQ4POyVWHv08HQh4/Nu1dZrPdLGJwh48a4ioe4pcMe3Zn8a9xIYwSigR+TxLflnuPYrNBRLwJmY
 VzOPtp9E+5/xX7l0a2WlmHSIv1lnYtwNucqADRhZUqpCKLjf0tLMgNfxsup+2TlqVA5Nq/wMEX9
 ins/G8efwAL7yUxXWs4IIp852f42F1kfQzWz/iJr2kPAYpPb/UGKpkaqjHkNYWqD5LPR9A77kfh
 TTv8ylQwZPUQOgNY5J9GJt1N8CXv1bfevFoCEyxMMV3JWIKQKfrvUxVwjCqb9QiKPkdGA9YWiBC
 uHOHrVHOE9cQUJqbbEmGuI/JIQ3xkna6YYD1M8NXkNRHHOwJinpkmC0EoB5/mVWlUvQk6vh/wa5
 VA9rZCiAYKkUbm2V3vK8DLAhvARP2QlvJbxb36/UyfKtGIZcvIJfI4McfF0HInGTxSMphfSAcvD
 xBavZABxr/3dGonxWrgFK7PPWRkl7De3bn8Q6tL2haBkRM3CQfRp4VyRmRWZWR+LvCD86rQm/kh
 PSs9jx7y6JaWg7w==
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
---
 drivers/iio/accel/Kconfig       |   2 +
 drivers/iio/accel/bma220.h      |   5 +-
 drivers/iio/accel/bma220_core.c | 244 ++++++++++++++++++++++++++++------------
 drivers/iio/accel/bma220_spi.c  |  10 +-
 4 files changed, 183 insertions(+), 78 deletions(-)

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
index dea34244b4fc4971841dc60d79db6c7db27bea20..f9f4fa3daf33665f07f8bf073468dff070b46d74 100644
--- a/drivers/iio/accel/bma220.h
+++ b/drivers/iio/accel/bma220.h
@@ -9,10 +9,11 @@
 #define _BMA220_H
 
 #include <linux/pm.h>
+#include <linux/regmap.h>
 
+extern const struct regmap_config bma220_spi_regmap_config;
 extern const struct dev_pm_ops bma220_pm_ops;
-struct spi_device;
 
-int bma220_common_probe(struct spi_device *dev);
+int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq);
 
 #endif
diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 7fdb83cedfa1809490cfb7f89532182123d580ba..73ce9a9511734961c2c6dadc99c21418070dce00 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -3,17 +3,21 @@
  * BMA220 Digital triaxial acceleration sensor driver
  *
  * Copyright (c) 2016,2020 Intel Corporation.
+ * Copyright (c) 2025 Petre Rodan  <petre.rodan@subdimension.ro>
  */
 
 #include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
 #include <linux/kernel.h>
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
@@ -24,16 +28,63 @@
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
+#define BMA220_WDT_1MS				BIT(1)
+#define BMA220_WDT_10MS				GENMASK(1, 0)
 #define BMA220_REG_SUSPEND			0x18
 #define BMA220_REG_SOFTRESET			0x19
 
 #define BMA220_CHIP_ID				0xDD
-#define BMA220_READ_MASK			BIT(7)
-#define BMA220_RANGE_MASK			GENMASK(1, 0)
 #define BMA220_SUSPEND_SLEEP			0xFF
 #define BMA220_SUSPEND_WAKE			0x00
 #define BMA220_RESET_MODE			0xFF
@@ -69,14 +120,15 @@ static const int bma220_scale_table[][2] = {
 };
 
 struct bma220_data {
-	struct spi_device *spi_device;
+	struct device *dev;
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
@@ -86,35 +138,57 @@ static const struct iio_chan_spec bma220_channels[] = {
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
@@ -125,24 +199,22 @@ static int bma220_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long mask)
 {
 	int ret;
-	u8 range_idx;
+	u8 index;
+	unsigned int reg;
 	struct bma220_data *data = iio_priv(indio_dev);
 
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
 
@@ -158,6 +230,8 @@ static int bma220_write_raw(struct iio_dev *indio_dev,
 	int index = -1;
 	struct bma220_data *data = iio_priv(indio_dev);
 
+	guard(mutex)(&data->lock);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		for (i = 0; i < ARRAY_SIZE(bma220_scale_table); i++)
@@ -169,14 +243,12 @@ static int bma220_write_raw(struct iio_dev *indio_dev,
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
@@ -206,9 +278,12 @@ static const struct iio_info bma220_info = {
 	.read_avail		= bma220_read_avail,
 };
 
-static int bma220_reset(struct spi_device *spi, bool up)
+static int bma220_reset(struct bma220_data *data, bool up)
 {
 	int i, ret;
+	unsigned int val;
+
+	guard(mutex)(&data->lock);
 
 	/**
 	 * The chip can be reset by a simple register read.
@@ -216,89 +291,112 @@ static int bma220_reset(struct spi_device *spi, bool up)
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
 	int i, ret;
+	unsigned int val;
 
+	guard(mutex)(&data->lock);
 	/**
 	 * The chip can be suspended/woken up by a simple register read.
 	 * So, we need up to 2 register reads of the suspend register
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
+static int bma220_init(struct bma220_data *data)
 {
 	int ret;
+	unsigned int val;
+	struct device *dev = data->dev;
 	static const char * const regulator_names[] = { "vddd", "vddio", "vdda" };
 
-	ret = devm_regulator_bulk_get_enable(&spi->dev,
+	ret = devm_regulator_bulk_get_enable(dev,
 					     ARRAY_SIZE(regulator_names),
 					     regulator_names);
 	if (ret)
-		return dev_err_probe(&spi->dev, ret, "Failed to get regulators\n");
+		return dev_err_probe(dev, ret, "Failed to get regulators\n");
 
-	ret = bma220_read_reg(spi, BMA220_REG_ID);
-	if (ret != BMA220_CHIP_ID)
-		dev_info(&spi->dev, "Unknown chip found: 0x%02x\n", ret);
+	/* Try to read chip_id register. It should return 0xdd. */
+	ret = regmap_read(data->regmap, BMA220_REG_ID, &val);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to read chip id register\n");
 
-	/* Make sure the chip is powered on and config registers are reset */
-	ret = bma220_power(spi, true);
+	if (val != BMA220_CHIP_ID)
+		dev_info(dev, "Unknown chip found: 0x%02x\n", val);
+
+	ret = bma220_power(data, true);
 	if (ret)
-		return dev_err_probe(&spi->dev, ret, "Failed to power-on chip\n");
+		return dev_err_probe(dev, ret, "Failed to power-on chip\n");
 
-	ret = bma220_reset(spi, true);
+	ret = bma220_reset(data, true);
 	if (ret)
-		return dev_err_probe(&spi->dev, ret, "Failed to soft reset chip\n");
+		return dev_err_probe(dev, ret, "Failed to soft reset chip\n");
 
 	return 0;
 }
 
-static void bma220_deinit(void *spi)
+static void bma220_deinit(void *data_ptr)
 {
-	bma220_power(spi, false);
+	struct bma220_data *data = data_ptr;
+	int ret;
+
+	ret = bma220_power(data, false);
+	if (ret)
+		dev_warn(data->dev,
+			 "Failed to put device into suspend mode (%pe)\n",
+			 ERR_PTR(ret));
 }
 
-int bma220_common_probe(struct spi_device *spi)
+int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq)
 {
 	int ret;
 	struct iio_dev *indio_dev;
 	struct bma220_data *data;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
-	data->spi_device = spi;
-	mutex_init(&data->lock);
+	data->regmap = regmap;
+	data->dev = dev;
+
+	ret = bma220_init(data);
+	if (ret)
+		return ret;
+
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
 
 	indio_dev->info = &bma220_info;
 	indio_dev->name = BMA220_DEVICE_NAME;
@@ -307,38 +405,34 @@ int bma220_common_probe(struct spi_device *spi)
 	indio_dev->num_channels = ARRAY_SIZE(bma220_channels);
 	indio_dev->available_scan_masks = bma220_accel_scan_masks;
 
-	ret = bma220_init(data->spi_device);
+	ret = devm_add_action_or_reset(dev, bma220_deinit, data);
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&spi->dev, bma220_deinit, spi);
-	if (ret)
-		return ret;
-
-	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
 					      bma220_trigger_handler, NULL);
-	if (ret < 0) {
-		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
-		return ret;
-	}
+	if (ret < 0)
+		dev_err_probe(dev, ret, "iio triggered buffer setup failed\n");
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
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
index 78820d90e39119d9755b6266a8329e11ffd55723..7364428b3e363950d3be2a03b7657a2f0315fc5b 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -9,6 +9,7 @@
 #include <linux/errno.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/types.h>
 #include <linux/spi/spi.h>
 
@@ -18,7 +19,14 @@
 
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


