Return-Path: <linux-iio+bounces-2630-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB09F857EF2
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 15:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE0C281FD6
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 14:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A8412EBD3;
	Fri, 16 Feb 2024 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Er/DuA3/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF78F12D761
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092690; cv=none; b=KmlmItAP5dO1fIl83hgbm3Ry7J2V7MVAXf/AqlK0uQ0zFWZDmRV09kA99LHn5SNMHF+qBpPo91ut95eiWQ6E5u0dWET4OhOWMwFvRWvH6XZURmWxQDX9GzRoLeRtOjuss+U2XpAfJmKKM8ISp/IAmbpIKjT6vHRwsXW1c5t6J64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092690; c=relaxed/simple;
	bh=YhOGr+CA7o1hlK67baXP3eQNN3JnPRtmrYJF/tA7fEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BE6AI1yBaRaUTZ36LWJO6qAkBd6/iTLDyIth1Ex/UWrdff15sSJNIORWFMZG/J8wdYc06ZqDJyVLKfW8ujEGSYv2WEbz3xZJJYTkGd5JNd11ThmK6hlyYch6IN6zBbzF/Fs+peuXAE0BZRPN9eo6qw0284Qp+nvNNS4rbf8ovNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Er/DuA3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8ADE7C43141;
	Fri, 16 Feb 2024 14:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708092689;
	bh=YhOGr+CA7o1hlK67baXP3eQNN3JnPRtmrYJF/tA7fEE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Er/DuA3/oAZ7vx7hMbhLPFj0AOTy9sSOaJcKKPtULDia5mw/q/fCgrSIjfQ8uwxUV
	 l7fcK7Hsk2dj9w121i7Hd1jmzepk+xopEMDNTrZbjtyf+mhR/H/duJk55L6skYBi8g
	 a9mNkC7m0wpRf5dgGPu+p7tCQaI7EZvRxo8lZxZI39kVh1BhBJFBYhoHEL5wijJrhc
	 IG3WnYCzKdUIPiH4z/dfR2LztRhCYS3kgQNi3TwLwJ0ACO8KnuyUKqsj+0ck84j7du
	 pJjckWBvJGQvkkkfl53Ry327hgodvn9cRCOxjLHdoabfUPLhWUa6HQQrAyJIbXIg9b
	 GlFGg+W2ZJ0og==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78044C48BF5;
	Fri, 16 Feb 2024 14:11:29 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 16 Feb 2024 15:10:57 +0100
Subject: [PATCH RFC 8/8] iio: dac: adi-axi-dac: add support for AXI DAC IP
 core
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-iio-backend-axi-dds-v1-8-22aed9fb07a1@analog.com>
References: <20240216-iio-backend-axi-dds-v1-0-22aed9fb07a1@analog.com>
In-Reply-To: <20240216-iio-backend-axi-dds-v1-0-22aed9fb07a1@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708092664; l=17054;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=CvwKiGjVNQppXuDRhWVxRThzbYj2LThOv82ZzfoS6lA=;
 b=fD0LGjImMZWkbx5tbX0KgGnaDK/Gg8OrS5XTEqKEJe8PRGnOKNsGzkzfxwX/sGrC9bSIGr1ge
 rkTWuGDK0AnCEKFW4xWR8S9C3X2KftiDzjGvZtfaDn5GFVHlTkRPeaA
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

This change adds support for the Analog Devices Generic AXI DAC IP core.
The IP core is used for interfacing with digital-to-analog (DAC) converters
that require either a high-speed serial interface (JESD204B/C) or a source
synchronous parallel interface (LVDS/CMOS).

Usually, some other interface type (i.e SPI) is used as a control interface
for the actual DAC, while the IP core (controlled via this driver), will
interface to the data-lines of the DAC and handle the streaming of data
into memory via DMA.

Because of this, it will register itself as an IIO backend.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/dac/Kconfig       |  21 ++
 drivers/iio/dac/Makefile      |   1 +
 drivers/iio/dac/adi-axi-dac.c | 510 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 532 insertions(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 98e80e73fab5..d1634580f781 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -147,6 +147,27 @@ config AD9739A
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad9739a.
 
+config ADI_AXI_DAC
+	tristate "Analog Devices Generic AXI DAC IP core driver"
+	select IIO_BUFFER
+	select IIO_BUFFER_DMAENGINE
+	select REGMAP_MMIO
+	select IIO_BACKEND
+	help
+      Say yes here to build support for Analog Devices Generic
+      AXI DAC IP core. The IP core is used for interfacing with
+      digital-to-analog (DAC) converters that require either a high-speed
+      serial interface (JESD204B/C) or a source synchronous parallel
+      interface (LVDS/CMOS).
+      Typically (for such devices) SPI will be used for configuration only,
+      while this IP core handles the streaming of data into memory via DMA.
+
+      Link: https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
+      If unsure, say N (but it's safe to say "Y").
+
+      To compile this driver as a module, choose M here: the
+      module will be called adi-axi-dac.
+
 config LTC2688
 	tristate "Analog Devices LTC2688 DAC spi driver"
 	depends on SPI
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 7e39e0c218ca..8432a81a19dc 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_AD7293) += ad7293.o
 obj-$(CONFIG_AD7303) += ad7303.o
 obj-$(CONFIG_AD8801) += ad8801.o
 obj-$(CONFIG_AD9739A) += ad9739a.o
+obj-$(CONFIG_ADI_AXI_DAC) += adi-axi-dac.o
 obj-$(CONFIG_CIO_DAC) += cio-dac.o
 obj-$(CONFIG_DPOT_DAC) += dpot-dac.o
 obj-$(CONFIG_DS4424) += ds4424.o
diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
new file mode 100644
index 000000000000..58d01ecc0618
--- /dev/null
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -0,0 +1,510 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices Generic AXI DAC IP core
+ * Link: https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
+ *
+ * Copyright 2016-2024 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/limits.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/units.h>
+
+#include <linux/fpga/adi-axi-common.h>
+
+#include <linux/iio/backend.h>
+#include <linux/iio/buffer-dmaengine.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+
+/*
+ * Register definitions:
+ *   https://wiki.analog.com/resources/fpga/docs/axi_dac_ip#register_map
+ */
+
+/* Base controls */
+#define AXI_DAC_REG_CONFIG		0x0C
+#define	   AXI_DAC_DISABLE		BIT(6)
+
+ /* DAC controls */
+#define AXI_DAC_REG_RSTN		0x0040
+#define   AXI_DAC_RSTN_CE_N		BIT(2)
+#define   AXI_DAC_RSTN_MMCM_RSTN	BIT(1)
+#define   AXI_DAC_RSTN_RSTN		BIT(0)
+#define AXI_DAC_REG_CNTRL_1		0x0044
+#define   AXI_DAC_SYNC			BIT(0)
+#define AXI_DAC_REG_RATECNTRL		0x004C
+#define AXI_DAC_DRP_STATUS		0x0074
+#define   AXI_DAC_DRP_LOCKED		BIT(17)
+
+/* DAC Channel controls */
+#define AXI_DAC_REG_CHAN_CNTRL_1(c)	(0x0400 + (c) * 0x40)
+#define AXI_DAC_REG_CHAN_CNTRL_3(c)	(0x0400 + (c) * 0x40)
+#define   AXI_DAC_SCALE_SIGN		BIT(15)
+#define   AXI_DAC_SCALE_INT		BIT(14)
+#define   AXI_DAC_SCALE_INT_NEG		GENMASK(15, 14)
+#define   AXI_DAC_SCALE_FRAC		GENMASK(13, 0)
+#define AXI_DAC_REG_CHAN_CNTRL_2(c)	(0x0404 + (c) * 0x40)
+#define AXI_DAC_REG_CHAN_CNTRL_4(c)	(0x040c + (c) * 0x40)
+#define   AXI_DAC_PHASE			GENMASK(31, 16)
+#define   AXI_DAC_FREQUENCY		GENMASK(15, 0)
+#define AXI_DAC_REG_CHAN_CNTRL_7(c)	(0x0418 + (c) * 0x40)
+#define   AXI_DAC_DATA_SEL		GENMASK(3, 0)
+
+/* 360 degrees in rad */
+#define AXI_DAC_2_PI_MEGA		6283190
+enum {
+	AXI_DAC_DATA_INTERNAL_TONE,
+	AXI_DAC_DATA_DMA = 2,
+};
+
+struct axi_dac_state {
+	struct regmap *regmap;
+	struct device *dev;
+	/* Lock for synchronizing device register access. */
+	struct mutex lock;
+	u64 dac_clk;
+	u32 reg_config;
+};
+
+static int axi_dac_frequency_read(struct iio_backend *back,
+				  const struct iio_chan_spec *chan, int *val,
+				  int *val2, unsigned int tone_idx,
+				  unsigned long long sample_freq)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+	u32 reg, __val;
+	u16 freq;
+	int ret;
+
+	if (tone_idx > 1) {
+		dev_err(st->dev, "Not a valid tone: %u\n", tone_idx);
+		return -EINVAL;
+	}
+
+	if (tone_idx)
+		reg = AXI_DAC_REG_CHAN_CNTRL_4(chan->channel);
+	else
+		reg = AXI_DAC_REG_CHAN_CNTRL_2(chan->channel);
+
+	ret = regmap_read(st->regmap, reg, &__val);
+	if (ret)
+		return ret;
+
+	freq = FIELD_GET(AXI_DAC_FREQUENCY, __val);
+	*val = DIV_ROUND_CLOSEST_ULL(__val * sample_freq, BIT(16));
+
+	return 0;
+}
+
+static int axi_dac_scale_read(struct iio_backend *back,
+			      const struct iio_chan_spec *chan, int *val,
+			      int *val2, unsigned int tone_idx)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+	u8 sign, integer;
+	u32 reg, __val;
+	u16 frac;
+	int ret;
+
+	if (tone_idx > 1) {
+		dev_err(st->dev, "Not a valid tone: %u\n", tone_idx);
+		return -EINVAL;
+	}
+
+	if (tone_idx)
+		reg = AXI_DAC_REG_CHAN_CNTRL_3(chan->channel);
+	else
+		reg = AXI_DAC_REG_CHAN_CNTRL_1(chan->channel);
+
+	ret = regmap_read(st->regmap, reg, &__val);
+	if (ret)
+		return ret;
+
+	frac = FIELD_GET(AXI_DAC_SCALE_FRAC, __val);
+	sign = FIELD_GET(AXI_DAC_SCALE_SIGN, __val);
+	integer = FIELD_GET(AXI_DAC_SCALE_INT, __val);
+
+	*val2 = DIV_ROUND_CLOSEST_ULL((u64)frac * MICRO, AXI_DAC_SCALE_INT);
+
+	if (integer && sign)
+		*val = -1;
+	else if (integer)
+		*val = 1;
+	else if (sign)
+		*val2 *= -1;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int axi_dac_phase_read(struct iio_backend *back,
+			      const struct iio_chan_spec *chan, int *val,
+			      int *val2, unsigned int tone_idx)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+	unsigned int tmp;
+	u32 reg, __val;
+	u16 phase;
+	int ret;
+
+	if (tone_idx > 1) {
+		dev_err(st->dev, "Not a valid tone: %u\n", tone_idx);
+		return -EINVAL;
+	}
+
+	if (tone_idx)
+		reg = AXI_DAC_REG_CHAN_CNTRL_4(chan->channel);
+	else
+		reg = AXI_DAC_REG_CHAN_CNTRL_2(chan->channel);
+
+	ret = regmap_read(st->regmap, reg, &__val);
+	if (ret)
+		return ret;
+
+	phase = FIELD_GET(AXI_DAC_PHASE, __val);
+	tmp = DIV_ROUND_CLOSEST_ULL((u64)phase * AXI_DAC_2_PI_MEGA, U16_MAX);
+	*val = tmp / MICRO;
+	*val2 = tmp % MICRO;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int axi_dac_frequency_write(struct iio_backend *back,
+				   const struct iio_chan_spec *chan, int val,
+				   int val2, unsigned int tone_idx,
+				   unsigned long long sample_freq)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+	u16 freq;
+	u32 reg;
+	int ret;
+
+	if (val < 0 || !sample_freq || val > sample_freq / 2) {
+		dev_err(st->dev, "Invalid frequency: %d, sampling freq: %llu\n",
+			val, sample_freq);
+		return -EINVAL;
+	}
+
+	if (tone_idx > 1) {
+		dev_err(st->dev, "Not a valid tone: %u\n", tone_idx);
+		return -EINVAL;
+	}
+
+	if (tone_idx)
+		reg = AXI_DAC_REG_CHAN_CNTRL_4(chan->channel);
+	else
+		reg = AXI_DAC_REG_CHAN_CNTRL_2(chan->channel);
+
+	freq = DIV64_U64_ROUND_CLOSEST((u64)val * BIT(16), sample_freq);
+
+	guard(mutex)(&st->lock);
+	ret = regmap_update_bits(st->regmap,  reg, AXI_DAC_FREQUENCY, freq);
+	if (ret)
+		return ret;
+
+	/* synchronize channels */
+	return regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_1, AXI_DAC_SYNC);
+}
+
+static int axi_dac_scale_write(struct iio_backend *back,
+			       const struct iio_chan_spec *chan, int val,
+			       int val2, unsigned int tone_idx)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+	u32 scale = 0, tmp, reg;
+	int ret;
+
+	if (tone_idx > 1) {
+		dev_err(st->dev, "Not a valid tone: %u\n", tone_idx);
+		return -EINVAL;
+	}
+
+	/*  format is 1.1.14 (sign, integer and fractional bits) */
+	switch (val) {
+	case 1:
+		scale = FIELD_PREP(AXI_DAC_SCALE_INT, 1);
+		break;
+	case -1:
+		scale = FIELD_PREP(AXI_DAC_SCALE_INT_NEG, 3);
+		break;
+	case 0:
+		if (val2 < 0) {
+			scale = FIELD_PREP(AXI_DAC_SCALE_SIGN, 1);
+			val2 *= -1;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	tmp = DIV_ROUND_CLOSEST_ULL((u64)val2 * AXI_DAC_SCALE_INT, MICRO);
+	scale |= FIELD_PREP(AXI_DAC_SCALE_FRAC, tmp);
+
+	if (tone_idx)
+		reg = AXI_DAC_REG_CHAN_CNTRL_3(chan->channel);
+	else
+		reg = AXI_DAC_REG_CHAN_CNTRL_1(chan->channel);
+
+	guard(mutex)(&st->lock);
+	ret = regmap_write(st->regmap, reg, scale);
+	if (ret)
+		return ret;
+
+	/* synchronize channels */
+	return regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_1, AXI_DAC_SYNC);
+}
+
+static int axi_dac_phase_write(struct iio_backend *back,
+			       const struct iio_chan_spec *chan, int val,
+			       int val2, unsigned int tone_idx)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+	u32 phase, reg;
+	int ret;
+
+	if (tone_idx > 1) {
+		dev_err(st->dev, "Not a valid tone: %u\n", tone_idx);
+		return -EINVAL;
+	}
+
+	phase = val * MILLI + val2;
+
+	phase = DIV_ROUND_CLOSEST_ULL((u64)phase * U16_MAX, AXI_DAC_2_PI_MEGA);
+
+	if (tone_idx)
+		reg = AXI_DAC_REG_CHAN_CNTRL_4(chan->channel);
+	else
+		reg = AXI_DAC_REG_CHAN_CNTRL_2(chan->channel);
+
+	guard(mutex)(&st->lock);
+	ret = regmap_update_bits(st->regmap, reg, AXI_DAC_PHASE,
+				 FIELD_PREP(AXI_DAC_PHASE, phase));
+	if (ret)
+		return ret;
+
+	/* synchronize channels */
+	return regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_1, AXI_DAC_SYNC);
+}
+
+static int axi_dac_data_source_set(struct iio_backend *back, unsigned int chan,
+				   enum iio_backend_data_source data)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	switch (data) {
+	case IIO_BACKEND_INTERNAL_CW:
+		return regmap_update_bits(st->regmap,
+					  AXI_DAC_REG_CHAN_CNTRL_7(chan),
+					  AXI_DAC_DATA_SEL,
+					  AXI_DAC_DATA_INTERNAL_TONE);
+	case IIO_BACKEND_EXTERNAL:
+		return regmap_update_bits(st->regmap,
+					  AXI_DAC_REG_CHAN_CNTRL_7(chan),
+					  AXI_DAC_DATA_SEL, AXI_DAC_DATA_DMA);
+	default:
+		return -EINVAL;
+	}
+}
+
+static struct iio_buffer *axi_dac_request_buffer(struct iio_backend *back,
+						 struct iio_dev *indio_dev)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+	struct iio_buffer *buffer;
+	const char *dma_name;
+	int ret;
+
+	if (device_property_read_string(st->dev, "dma-names", &dma_name))
+		dma_name = "tx";
+
+	buffer = iio_dmaengine_buffer_alloc(st->dev, dma_name);
+	if (IS_ERR(buffer)) {
+		dev_err(st->dev, "Could not get DMA buffer, %ld\n",
+			PTR_ERR(buffer));
+		return ERR_CAST(buffer);
+	}
+
+	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
+	iio_buffer_set_dir(buffer, IIO_BUFFER_DIRECTION_OUT);
+
+	ret = iio_device_attach_buffer(indio_dev, buffer);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return buffer;
+}
+
+static void axi_dac_free_buffer(struct iio_backend *back,
+				struct iio_buffer *buffer)
+{
+	iio_dmaengine_buffer_free(buffer);
+}
+
+static int axi_dac_enable(struct iio_backend *back)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+	unsigned int __val;
+	int ret;
+
+	guard(mutex)(&st->lock);
+	ret = regmap_set_bits(st->regmap, AXI_DAC_REG_RSTN,
+			      AXI_DAC_RSTN_MMCM_RSTN);
+	if (ret)
+		return ret;
+	/*
+	 * Make sure the DRP (Dynamic Reconfiguration Port) is locked. Not all
+	 * designs really use it but if they don't we still get the lock bit
+	 * set. So let's do it all the time so the code is generic.
+	 */
+	ret = regmap_read_poll_timeout(st->regmap, AXI_DAC_DRP_STATUS, __val,
+				       __val & AXI_DAC_DRP_LOCKED, 100, 1000);
+	if (ret)
+		return ret;
+
+	return regmap_set_bits(st->regmap, AXI_DAC_REG_RSTN,
+			       AXI_DAC_RSTN_RSTN | AXI_DAC_RSTN_MMCM_RSTN);
+}
+
+static void axi_dac_disable(struct iio_backend *back)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	guard(mutex)(&st->lock);
+	regmap_write(st->regmap, AXI_DAC_REG_RSTN, 0);
+}
+
+static const struct iio_backend_ops axi_dac_generic = {
+	.enable = axi_dac_enable,
+	.disable = axi_dac_disable,
+	.request_buffer = axi_dac_request_buffer,
+	.free_buffer = axi_dac_free_buffer,
+	.read_frequency = axi_dac_frequency_read,
+	.write_frequency = axi_dac_frequency_write,
+	.read_scale = axi_dac_scale_read,
+	.write_scale = axi_dac_scale_write,
+	.read_phase = axi_dac_phase_read,
+	.write_phase = axi_dac_phase_write,
+	.data_source_set = axi_dac_data_source_set,
+};
+
+static const struct regmap_config axi_dac_regmap_config = {
+	.val_bits = 32,
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.max_register = 0x0800,
+};
+
+static int axi_dac_probe(struct platform_device *pdev)
+{
+	const unsigned int *expected_ver;
+	struct axi_dac_state *st;
+	void __iomem *base;
+	unsigned int ver;
+	struct clk *clk;
+	int ret;
+
+	st = devm_kzalloc(&pdev->dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	expected_ver = device_get_match_data(&pdev->dev);
+	if (!expected_ver)
+		return -ENODEV;
+
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	st->dev = &pdev->dev;
+	st->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					   &axi_dac_regmap_config);
+	if (IS_ERR(st->regmap))
+		return PTR_ERR(st->regmap);
+
+	/*
+	 * Force disable the core. Up to the frontend to enable us. And we can
+	 * still read/write registers...
+	 */
+	ret = regmap_write(st->regmap, AXI_DAC_REG_RSTN, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, ADI_AXI_REG_VERSION, &ver);
+	if (ret)
+		return ret;
+
+	if (ADI_AXI_PCORE_VER_MAJOR(ver) != ADI_AXI_PCORE_VER_MAJOR(*expected_ver)) {
+		dev_err(&pdev->dev,
+			"Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
+			ADI_AXI_PCORE_VER_MAJOR(*expected_ver),
+			ADI_AXI_PCORE_VER_MINOR(*expected_ver),
+			ADI_AXI_PCORE_VER_PATCH(*expected_ver),
+			ADI_AXI_PCORE_VER_MAJOR(ver),
+			ADI_AXI_PCORE_VER_MINOR(ver),
+			ADI_AXI_PCORE_VER_PATCH(ver));
+		return -ENODEV;
+	}
+
+	/* Let's get the core read only configuration */
+	ret = regmap_read(st->regmap, AXI_DAC_REG_CONFIG, &st->reg_config);
+	if (ret)
+		return ret;
+
+	/*
+	 * Default rate to 1 so the sampling frequency will be the same as the
+	 * digital interface clock which should be the same as the frontend
+	 * sampling clock/frequency. When this is not true, the frontend will
+	 * have to explicitly set a new frequency and thus rate.
+	 */
+	ret = regmap_write(st->regmap, AXI_DAC_REG_RATECNTRL, 1);
+	if (ret)
+		return ret;
+
+	mutex_init(&st->lock);
+	ret = devm_iio_backend_register(&pdev->dev, &axi_dac_generic, st);
+	if (ret)
+		return ret;
+
+	dev_info(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
+		 ADI_AXI_PCORE_VER_MAJOR(ver),
+		 ADI_AXI_PCORE_VER_MINOR(ver),
+		 ADI_AXI_PCORE_VER_PATCH(ver));
+
+	return 0;
+}
+
+static unsigned int axi_dac_9_1_b_info = ADI_AXI_PCORE_VER(9, 1, 'b');
+
+static const struct of_device_id axi_dac_of_match[] = {
+	{ .compatible = "adi,axi-dac-9.1.b", .data = &axi_dac_9_1_b_info },
+	{}
+};
+MODULE_DEVICE_TABLE(of, axi_dac_of_match);
+
+static struct platform_driver axi_dac_driver = {
+	.driver = {
+		.name = "adi-axi-dac",
+		.of_match_table = axi_dac_of_match,
+	},
+	.probe = axi_dac_probe,
+};
+module_platform_driver(axi_dac_driver);
+
+MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices Generic AXI DAC IP core driver");
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_DMAENGINE_BUFFER);
+MODULE_IMPORT_NS(IIO_BACKEND);

-- 
2.43.0


