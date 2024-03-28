Return-Path: <linux-iio+bounces-3865-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B01A2890018
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 14:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64FDD28B3FD
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 13:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4178175B;
	Thu, 28 Mar 2024 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uqz5rlUM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EF281219;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632152; cv=none; b=ZL4zYUV8suynqTZih+t6kUwppKneqJgkB+JRhjVeMPsCja5+umoWOiAQJIHB9itStbBC2HD8sHX9Z23fuINfPjI6ddviVJ0Q2qRDBdo4a5GlBpWTkXZ/hENASnQi0VyHl9MkpAKqe/xi5F4McdegNiAhNKH2WnZ7VkKK+Fp5E2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632152; c=relaxed/simple;
	bh=w8AvKUMhWLvQ2m/XQIuTZljlAxdNMEaYdX28L42CwEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jTW5dlM8ixTG9wVLtjS8RRMiznPYRwz56WL1blaH6/wuvwXj8SEyoWc4S1MudFA+S3zJEQjNA+d9ldnuDiukaygX43MB0M1kUPglahC4UcIIrdlF6cI/5s6S2DjXxqwUxmw7UQUCRcyQMYBC1GkxaHze2rlPqcJo2ftyTZvKofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uqz5rlUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0463C43394;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711632151;
	bh=w8AvKUMhWLvQ2m/XQIuTZljlAxdNMEaYdX28L42CwEU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Uqz5rlUMq7nn7rfHUHFrinTJH8R+66nbUJp1DJkFrWhwHH4PQ5/NJu/wJ+R1QVZjX
	 p7tq36hLSApnIy2yKVDiFOYxS5bjYrmaewMY2IQmr3XhymJPqH7cxdE+CA68iAl71O
	 S8ru3BcxoOQqLTJ8SarFa9cv8eUg1rVywx7luIRyU8NOhMtD7/9kXQQFgPjtsMUCIT
	 sQXQhtgjUtnHAts9l/1RTHpC1t/wBPejFKfY59/ztHHPgUk+tr3gDXtaTEZinN9b9p
	 PAGhoGhuWqZy8I0OaQRqk2hOS3OXTJdlqNG/gA8HVY13NBCir++to96Fjk+l3RnlhE
	 BCBV4HFlKyCng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BAACD1288;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 28 Mar 2024 14:22:33 +0100
Subject: [PATCH 09/10] iio: dac: add support for AXI DAC IP core
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-iio-backend-axi-dac-v1-9-afc808b3fde3@analog.com>
References: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
In-Reply-To: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Dragos Bogdan <dragos.bogdan@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711632149; l=21005;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=DKM/JwU90qqED48pzzJk0k9o2FS7LkIH1rSvQb9Do50=;
 b=8LPhwdf4bZ469er5Xcb6VzbUdR5MyQMOQUO9a45kkW8ptJRyXkw2dEq8GSIIvCipd/pcIrQ51
 xNDeDhbziEODkpMs2jOtG4SU/SaROVCHIMSaDTMOng1w4FBrNnTKagV
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Support the Analog Devices Generic AXI DAC IP core. The IP core is used
for interfacing with digital-to-analog (DAC) converters that require either
a high-speed serial interface (JESD204B/C) or a source synchronous parallel
interface (LVDS/CMOS). Typically (for such devices) SPI will be used for
configuration only, while this IP core handles the streaming of data into
memory via DMA.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 MAINTAINERS                   |   1 +
 drivers/iio/dac/Kconfig       |  21 ++
 drivers/iio/dac/Makefile      |   1 +
 drivers/iio/dac/adi-axi-dac.c | 644 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 667 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 76e872e320d7..505f28dc6da6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1413,6 +1413,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
+F:	drivers/iio/dac/adi-axi-dac.c
 
 ANALOG DEVICES INC DMA DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 34eb40bb9529..7c0a8caa9a34 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -131,6 +131,27 @@ config AD5624R_SPI
 	  Say yes here to build support for Analog Devices AD5624R, AD5644R and
 	  AD5664R converters (DAC). This driver uses the common SPI interface.
 
+config ADI_AXI_DAC
+	tristate "Analog Devices Generic AXI DAC IP core driver"
+	select IIO_BUFFER
+	select IIO_BUFFER_DMAENGINE
+	select REGMAP_MMIO
+	select IIO_BACKEND
+	help
+	  Say yes here to build support for Analog Devices Generic
+	  AXI DAC IP core. The IP core is used for interfacing with
+	  digital-to-analog (DAC) converters that require either a high-speed
+	  serial interface (JESD204B/C) or a source synchronous parallel
+	  interface (LVDS/CMOS).
+	  Typically (for such devices) SPI will be used for configuration only,
+	  while this IP core handles the streaming of data into memory via DMA.
+
+	  Link: https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
+	  If unsure, say N (but it's safe to say "Y").
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called adi-axi-dac.
+
 config LTC2688
 	tristate "Analog Devices LTC2688 DAC spi driver"
 	depends on SPI
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 55bf89739d14..6bcaa65434b2 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_AD5696_I2C) += ad5696-i2c.o
 obj-$(CONFIG_AD7293) += ad7293.o
 obj-$(CONFIG_AD7303) += ad7303.o
 obj-$(CONFIG_AD8801) += ad8801.o
+obj-$(CONFIG_ADI_AXI_DAC) += adi-axi-dac.o
 obj-$(CONFIG_CIO_DAC) += cio-dac.o
 obj-$(CONFIG_DPOT_DAC) += dpot-dac.o
 obj-$(CONFIG_DS4424) += ds4424.o
diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
new file mode 100644
index 000000000000..0022ecb4e4bb
--- /dev/null
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -0,0 +1,644 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices Generic AXI DAC IP core
+ * Link: https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
+ *
+ * Copyright 2016-2024 Analog Devices Inc.
+ */
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/limits.h>
+#include <linux/kstrtox.h>
+#include <linux/math.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/units.h>
+
+#include <linux/fpga/adi-axi-common.h>
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
+#define AXI_DAC_REG_CONFIG		0x0c
+#define	   AXI_DDS_DISABLE		BIT(6)
+
+ /* DAC controls */
+#define AXI_DAC_REG_RSTN		0x0040
+#define   AXI_DAC_RSTN_CE_N		BIT(2)
+#define   AXI_DAC_RSTN_MMCM_RSTN	BIT(1)
+#define   AXI_DAC_RSTN_RSTN		BIT(0)
+#define AXI_DAC_REG_CNTRL_1		0x0044
+#define   AXI_DAC_SYNC			BIT(0)
+#define AXI_DAC_REG_CNTRL_2		0x0048
+#define	  ADI_DAC_R1_MODE		BIT(4)
+#define AXI_DAC_DRP_STATUS		0x0074
+#define   AXI_DAC_DRP_LOCKED		BIT(17)
+/* DAC Channel controls */
+#define AXI_DAC_REG_CHAN_CNTRL_1(c)	(0x0400 + (c) * 0x40)
+#define AXI_DAC_REG_CHAN_CNTRL_3(c)	(0x0408 + (c) * 0x40)
+#define   AXI_DAC_SCALE_SIGN		BIT(15)
+#define   AXI_DAC_SCALE_INT		BIT(14)
+#define   AXI_DAC_SCALE			GENMASK(14, 0)
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
+	/*
+	 * lock to protect multiple accesses to the device registers and global
+	 * data/variables.
+	 */
+	struct mutex lock;
+	u64 dac_clk;
+	u32 reg_config;
+	bool int_tone;
+};
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
+enum {
+	AXI_DAC_FREQ_TONE_1,
+	AXI_DAC_FREQ_TONE_2,
+	AXI_DAC_SCALE_TONE_1,
+	AXI_DAC_SCALE_TONE_2,
+	AXI_DAC_PHASE_TONE_1,
+	AXI_DAC_PHASE_TONE_2,
+};
+
+static int __axi_dac_frequency_get(struct axi_dac_state *st, unsigned int chan,
+				   unsigned int tone, unsigned int *freq)
+{
+	u32 reg, raw;
+	int ret;
+
+	if (!st->dac_clk) {
+		dev_err(st->dev, "Sampling rate is 0...\n");
+		return -EINVAL;
+	}
+
+	if (tone == AXI_DAC_FREQ_TONE_1)
+		reg = AXI_DAC_REG_CHAN_CNTRL_2(chan);
+	else
+		reg = AXI_DAC_REG_CHAN_CNTRL_4(chan);
+
+	ret = regmap_read(st->regmap, reg, &raw);
+	if (ret)
+		return ret;
+
+	raw = FIELD_GET(AXI_DAC_FREQUENCY, raw);
+	*freq = DIV_ROUND_CLOSEST_ULL(raw * st->dac_clk, BIT(16));
+
+	return 0;
+}
+
+static int axi_dac_frequency_get(struct axi_dac_state *st,
+				 const struct iio_chan_spec *chan, char *buf,
+				 unsigned int tone)
+{
+	unsigned int freq;
+	int ret;
+
+	scoped_guard(mutex, &st->lock) {
+		ret = __axi_dac_frequency_get(st, chan->channel, tone, &freq);
+		if (ret)
+			return ret;
+	}
+
+	return sysfs_emit(buf, "%u\n", freq);
+}
+
+static int axi_dac_scale_get(struct axi_dac_state *st,
+			     const struct iio_chan_spec *chan, char *buf,
+			     unsigned int tone)
+{
+	unsigned int scale, sign;
+	int ret, vals[2];
+	u32 reg, raw;
+
+	if (tone == AXI_DAC_SCALE_TONE_1)
+		reg = AXI_DAC_REG_CHAN_CNTRL_1(chan->channel);
+	else
+		reg = AXI_DAC_REG_CHAN_CNTRL_3(chan->channel);
+
+	ret = regmap_read(st->regmap, reg, &raw);
+	if (ret)
+		return ret;
+
+	sign = FIELD_GET(AXI_DAC_SCALE_SIGN, raw);
+	raw = FIELD_GET(AXI_DAC_SCALE, raw);
+	scale = DIV_ROUND_CLOSEST_ULL((u64)raw * MEGA, AXI_DAC_SCALE_INT);
+
+	vals[0] = scale / MEGA;
+	vals[1] = scale % MEGA;
+
+	if (sign) {
+		vals[0] *= -1;
+		if (!vals[0])
+			vals[1] *= -1;
+	}
+
+	return iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, ARRAY_SIZE(vals),
+				vals);
+}
+
+static int axi_dac_phase_get(struct axi_dac_state *st,
+			     const struct iio_chan_spec *chan, char *buf,
+			     unsigned int tone)
+{
+	u32 reg, raw, phase;
+	int ret, vals[2];
+
+	if (tone == AXI_DAC_PHASE_TONE_1)
+		reg = AXI_DAC_REG_CHAN_CNTRL_2(chan->channel);
+	else
+		reg = AXI_DAC_REG_CHAN_CNTRL_4(chan->channel);
+
+	ret = regmap_read(st->regmap, reg, &raw);
+	if (ret)
+		return ret;
+
+	raw = FIELD_GET(AXI_DAC_PHASE, raw);
+	phase = DIV_ROUND_CLOSEST_ULL((u64)raw * AXI_DAC_2_PI_MEGA, U16_MAX);
+
+	vals[0] = phase / MEGA;
+	vals[1] = phase % MEGA;
+
+	return iio_format_value(buf, IIO_VAL_INT_PLUS_MICRO, ARRAY_SIZE(vals),
+				vals);
+}
+
+static int __axi_dac_frequency_set(struct axi_dac_state *st, unsigned int chan,
+				   u64 sample_rate, unsigned int freq,
+				   unsigned int tone)
+{
+	u32 reg;
+	u16 raw;
+	int ret;
+
+	if (!sample_rate || freq > sample_rate / 2) {
+		dev_err(st->dev, "Invalid frequency(%u) dac_clk(%llu)\n",
+			freq, sample_rate);
+		return -EINVAL;
+	}
+
+	if (tone == AXI_DAC_FREQ_TONE_1)
+		reg = AXI_DAC_REG_CHAN_CNTRL_2(chan);
+	else
+		reg = AXI_DAC_REG_CHAN_CNTRL_4(chan);
+
+	raw = DIV64_U64_ROUND_CLOSEST((u64)freq * BIT(16), sample_rate);
+
+	ret = regmap_update_bits(st->regmap,  reg, AXI_DAC_FREQUENCY, raw);
+	if (ret)
+		return ret;
+
+	/* synchronize channels */
+	return regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_1, AXI_DAC_SYNC);
+}
+
+static int axi_dac_frequency_set(struct axi_dac_state *st,
+				 const struct iio_chan_spec *chan,
+				 const char *buf, size_t len, unsigned int tone)
+{
+	unsigned int freq;
+	int ret;
+
+	ret = kstrtou32(buf, 10, &freq);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+	ret = __axi_dac_frequency_set(st, chan->channel, st->dac_clk, freq,
+				      tone);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static int axi_dac_scale_set(struct axi_dac_state *st,
+			     const struct iio_chan_spec *chan,
+			     const char *buf, size_t len, unsigned int tone)
+{
+	int integer, frac, scale;
+	u32 raw = 0, reg;
+	int ret;
+
+	ret = iio_str_to_fixpoint(buf, 100000, &integer, &frac);
+	if (ret)
+		return ret;
+
+	scale = integer * MEGA + frac;
+	if (scale <= -2 * (int)MEGA || scale >= 2 * (int)MEGA)
+		return -EINVAL;
+
+	/*  format is 1.1.14 (sign, integer and fractional bits) */
+	if (scale < 0) {
+		raw = FIELD_PREP(AXI_DAC_SCALE_SIGN, 1);
+		scale *= -1;
+	}
+
+	raw |= div_u64((u64)scale * AXI_DAC_SCALE_INT, MEGA);
+
+	if (tone == AXI_DAC_SCALE_TONE_1)
+		reg = AXI_DAC_REG_CHAN_CNTRL_1(chan->channel);
+	else
+		reg = AXI_DAC_REG_CHAN_CNTRL_3(chan->channel);
+
+	guard(mutex)(&st->lock);
+	ret = regmap_write(st->regmap, reg, raw);
+	if (ret)
+		return ret;
+
+	/* synchronize channels */
+	ret = regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_1, AXI_DAC_SYNC);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static int axi_dac_phase_set(struct axi_dac_state *st,
+			     const struct iio_chan_spec *chan,
+			     const char *buf, size_t len, unsigned int tone)
+{
+	int integer, frac, phase;
+	u32 raw, reg;
+	int ret;
+
+	ret = iio_str_to_fixpoint(buf, 100000, &integer, &frac);
+	if (ret)
+		return ret;
+
+	phase = integer * MEGA + frac;
+	if (phase < 0 || phase > AXI_DAC_2_PI_MEGA)
+		return -EINVAL;
+
+	raw = DIV_ROUND_CLOSEST_ULL((u64)phase * U16_MAX, AXI_DAC_2_PI_MEGA);
+
+	if (tone == AXI_DAC_PHASE_TONE_1)
+		reg = AXI_DAC_REG_CHAN_CNTRL_2(chan->channel);
+	else
+		reg = AXI_DAC_REG_CHAN_CNTRL_4(chan->channel);
+
+	guard(mutex)(&st->lock);
+	ret = regmap_update_bits(st->regmap, reg, AXI_DAC_PHASE,
+				 FIELD_PREP(AXI_DAC_PHASE, raw));
+	if (ret)
+		return ret;
+
+	/* synchronize channels */
+	ret = regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_1, AXI_DAC_SYNC);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static int axi_dac_ext_info_set(struct iio_backend *back, uintptr_t private,
+				const struct iio_chan_spec *chan,
+				const char *buf, size_t len)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	switch (private) {
+	case AXI_DAC_FREQ_TONE_1:
+	case AXI_DAC_FREQ_TONE_2:
+		return axi_dac_frequency_set(st, chan, buf, len, private);
+	case AXI_DAC_SCALE_TONE_1:
+	case AXI_DAC_SCALE_TONE_2:
+		return axi_dac_scale_set(st, chan, buf, len, private);
+	case AXI_DAC_PHASE_TONE_1:
+	case AXI_DAC_PHASE_TONE_2:
+		return axi_dac_phase_set(st, chan, buf, len, private);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int axi_dac_ext_info_get(struct iio_backend *back, uintptr_t private,
+				const struct iio_chan_spec *chan, char *buf)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	switch (private) {
+	case AXI_DAC_FREQ_TONE_1:
+	case AXI_DAC_FREQ_TONE_2:
+		return axi_dac_frequency_get(st, chan, buf, private);
+	case AXI_DAC_SCALE_TONE_1:
+	case AXI_DAC_SCALE_TONE_2:
+		return axi_dac_scale_get(st, chan, buf, private);
+	case AXI_DAC_PHASE_TONE_1:
+	case AXI_DAC_PHASE_TONE_2:
+		return axi_dac_phase_get(st, chan, buf, private);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const struct iio_chan_spec_ext_info axi_dac_ext_info[] = {
+	IIO_BACKEND_EX_INFO("frequency0", IIO_SEPARATE, AXI_DAC_FREQ_TONE_1),
+	IIO_BACKEND_EX_INFO("frequency1", IIO_SEPARATE, AXI_DAC_FREQ_TONE_2),
+	IIO_BACKEND_EX_INFO("scale0", IIO_SEPARATE, AXI_DAC_SCALE_TONE_1),
+	IIO_BACKEND_EX_INFO("scale1", IIO_SEPARATE, AXI_DAC_SCALE_TONE_2),
+	IIO_BACKEND_EX_INFO("phase0", IIO_SEPARATE, AXI_DAC_PHASE_TONE_1),
+	IIO_BACKEND_EX_INFO("phase1", IIO_SEPARATE, AXI_DAC_PHASE_TONE_2),
+	{}
+};
+
+static int axi_dac_extend_chan(struct iio_backend *back,
+			       struct iio_chan_spec *chan)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+
+	if (chan->type != IIO_ALTVOLTAGE)
+		return -EINVAL;
+	if (st->reg_config & AXI_DDS_DISABLE)
+		/* nothing to extend */
+		return 0;
+
+	chan->ext_info = axi_dac_ext_info;
+
+	return 0;
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
+static int axi_dac_set_sample_rate(struct iio_backend *back, unsigned int chan,
+				   u64 sample_rate)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+	unsigned int freq;
+	int ret, tone;
+
+	if (!sample_rate)
+		return -EINVAL;
+	if (st->reg_config & AXI_DDS_DISABLE)
+		/* nothing to care if DDS is disabled */
+		return 0;
+
+	guard(mutex)(&st->lock);
+	/*
+	 * If dac_clk is 0 then this must be the first time we're being notified
+	 * about the interface sample rate. Hence, just update our internal
+	 * variable and bail... If it's not 0, then we get the current DDS
+	 * frequency (for the old rate) and update the registers for the new
+	 * sample rate.
+	 */
+	if (!st->dac_clk) {
+		st->dac_clk = sample_rate;
+		return 0;
+	}
+
+	for (tone = 0; tone <= AXI_DAC_FREQ_TONE_2; tone++) {
+		ret = __axi_dac_frequency_get(st, chan, tone, &freq);
+		if (ret)
+			return ret;
+
+		ret = __axi_dac_frequency_set(st, chan, sample_rate, tone, freq);
+		if (ret)
+			return ret;
+	}
+
+	st->dac_clk = sample_rate;
+
+	return 0;
+}
+
+static const struct iio_backend_ops axi_dac_generic = {
+	.enable = axi_dac_enable,
+	.disable = axi_dac_disable,
+	.request_buffer = axi_dac_request_buffer,
+	.free_buffer = axi_dac_free_buffer,
+	.extend_chan_spec = axi_dac_extend_chan,
+	.ext_info_set = axi_dac_ext_info_set,
+	.ext_info_get = axi_dac_ext_info_get,
+	.data_source_set = axi_dac_data_source_set,
+	.set_sample_rate = axi_dac_set_sample_rate,
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
+	 * In some designs, setting the R1_MODE bit to 0 (which is the default
+	 * value) causes all channels of the frontend to be routed to the same
+	 * DMA (so they are sampled together). This is for things like
+	 * Multiple-Input and Multiple-Output (MIMO). As most of the times we
+	 * want independent channels let's override the core's default value and
+	 * set the R1_MODE bit.
+	 */
+	ret = regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_2, ADI_DAC_R1_MODE);
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
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_DMAENGINE_BUFFER);
+MODULE_IMPORT_NS(IIO_BACKEND);

-- 
2.44.0



