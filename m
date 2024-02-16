Return-Path: <linux-iio+bounces-2633-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1614A857EF4
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 15:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57004B27B43
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 14:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B4312E1F2;
	Fri, 16 Feb 2024 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cK9/uFyG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DB312EBC4
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092690; cv=none; b=gbYxPFzs69s/rj19YpoFVlQoBG+wvtkRqgxUN41YBRJP4smLCSu0KeOU9m65nA9P8Als9V92a/sL+Mz/UFTmAh+z+YFyZl+b+RMbZvnVU4of14xsbzGzwD2+ucMFumt4xMeOnn+VyNfYhpFaI3LxdwowbgWDIOJVA/YzToSCTek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092690; c=relaxed/simple;
	bh=vAmWd+tUeWZ+abFMMHSQn/BJPKH9dI95nxkPn1ibv8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lluEoFPPSqgSxKvyoRvlMnfi0B7aZWvviUZNWiX6dGrYzDO0Rf1RDQh4brW3E/qHZDZXOAKT2oURUau29iPG5eJz5y+NMRJPIc8TAuxsWUbmqUrS7hnRmcbXd2dARNbWX0qQvbxVsEsyg8GkdmVMP1kLMXnub67kT75TD5h6/wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cK9/uFyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8251FC4166A;
	Fri, 16 Feb 2024 14:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708092689;
	bh=vAmWd+tUeWZ+abFMMHSQn/BJPKH9dI95nxkPn1ibv8s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cK9/uFyGogiQunVKtEgQIv6pFKq11A2g+/7pXimBeYuYmBwb7ptZ19pqiw+xidjGW
	 PgPlmq7cfwCa18YjsepwIKnlZqe/xZRVqsqbkalAgY9r4/X0qGoUH03LXOH1ArVN2A
	 HaYC9bBZHcm8Mdwq/97YQyNXXsKbICtopgMU1OsZELqWYd5/jHdzmqfY+stil1sa/x
	 bKB4YKrmPv78J0bObgOhyNtksFCiUwspt5ydunk4GflmfnB7CI240k4TBief60VhVf
	 m6isC5fmQzXZa04rdrpwWTYXDoCCQLNsCNEb2VEzg2BhQaLsIaXMjA+kc1nZ6BM0Xa
	 p/sssOrXPofOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6D7C48BEF;
	Fri, 16 Feb 2024 14:11:29 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 16 Feb 2024 15:10:56 +0100
Subject: [PATCH RFC 7/8] iio: dac: add support for the AD97339A RF DAC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-iio-backend-axi-dds-v1-7-22aed9fb07a1@analog.com>
References: <20240216-iio-backend-axi-dds-v1-0-22aed9fb07a1@analog.com>
In-Reply-To: <20240216-iio-backend-axi-dds-v1-0-22aed9fb07a1@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708092664; l=16425;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=JvJEEC42EH4Jf6P2LRlyeWRmTv3p1qbMMrzLpMLfAY0=;
 b=kG4+co4yDOxLFyW6Ihq7htzqnit4H23CfqxQtRaqCIfrKYug9g765u46AoClaPCvkevKMpYGM
 cqQ4yoh1eIUBV7JSC94h9lRxOYb9mkr1uxjoN6NZyge9+0JoK1xz/oM
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

The AD9739A is a 14-bit, 2.5 GSPS high performance RF DAC that is capable
of synthesizing wideband signals from dc up to 3 GHz.

On-chip controllers are used to manage external and internal clock domain
variations over temperature to ensure reliable data transfer from the host
to the DAC core.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/dac/Kconfig   |  16 ++
 drivers/iio/dac/Makefile  |   1 +
 drivers/iio/dac/ad9739a.c | 503 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 520 insertions(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 34eb40bb9529..98e80e73fab5 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -131,6 +131,22 @@ config AD5624R_SPI
 	  Say yes here to build support for Analog Devices AD5624R, AD5644R and
 	  AD5664R converters (DAC). This driver uses the common SPI interface.
 
+config AD9739A
+	tristate "Analog Devices AD9739A RF DAC spi driver"
+	depends on SPI
+	select REGMAP_SPI
+	select IIO_BACKEND
+	help
+	  Say yes here to build support for Analog Devices AD9739A Digital-to
+	  Analog Converter.
+
+	  The driver requires the assistance of the AXI DAC IP core to operate,
+	  since SPI is used for configuration only, while data has to be
+	  streamed into memory via DMA.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad9739a.
+
 config LTC2688
 	tristate "Analog Devices LTC2688 DAC spi driver"
 	depends on SPI
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 55bf89739d14..7e39e0c218ca 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_AD5696_I2C) += ad5696-i2c.o
 obj-$(CONFIG_AD7293) += ad7293.o
 obj-$(CONFIG_AD7303) += ad7303.o
 obj-$(CONFIG_AD8801) += ad8801.o
+obj-$(CONFIG_AD9739A) += ad9739a.o
 obj-$(CONFIG_CIO_DAC) += cio-dac.o
 obj-$(CONFIG_DPOT_DAC) += dpot-dac.o
 obj-$(CONFIG_DS4424) += ds4424.o
diff --git a/drivers/iio/dac/ad9739a.c b/drivers/iio/dac/ad9739a.c
new file mode 100644
index 000000000000..e4ade13aaf00
--- /dev/null
+++ b/drivers/iio/dac/ad9739a.c
@@ -0,0 +1,503 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices AD9739a SPI DAC driver
+ *
+ * Copyright 2015-2024 Analog Devices Inc.
+ */
+
+#include "linux/delay.h"
+#include "linux/dev_printk.h"
+#include "linux/gpio/consumer.h"
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/units.h>
+
+#include <linux/iio/backend.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+
+#define AD9739A_REG_MODE		0
+#define   AD9739A_RESET_MASK		BIT(5)
+#define AD9739A_REG_LVDS_REC_CNT1	0x10
+#define   AD9739A_RCVR_LOOP_EN_MASK	GENMASK(1, 0)
+#define AD9739A_REG_LVDS_REC_CNT4	0x13
+#define   AD9739A_FINE_DEL_SKW_MASK	GENMASK(3, 0)
+#define AD9739A_REG_LVDS_REC_STAT9	0x21
+#define   AD9739A_RCVR_TRACK_AND_LOCK	(BIT(3) | BIT(0))
+#define AD9739A_REG_CROSS_CNT1		0x22
+#define AD9739A_REG_CROSS_CNT2		0x23
+#define AD9739A_REG_PHS_DET		0x24
+#define AD9739A_REG_MU_DUTY		0x25
+#define AD9739A_REG_MU_CNT1		0x26
+#define   AD9739A_MU_EN_MASK		BIT(0)
+#define AD9739A_REG_MU_CNT2		0x27
+#define AD9739A_REG_MU_CNT3		0x28
+#define AD9739A_REG_MU_CNT4		0x29
+#define   AD9739A_MU_CNT4_DEFAULT	0xcb
+#define AD9739A_REG_MU_STAT1		0x2A
+#define   AD9739A_MU_LOCK_MASK		BIT(0)
+#define AD9739A_REG_ANA_CNT_1		0x32
+#define AD9739A_REG_ID			0x35
+
+#define AD9739A_ID			0x24
+#define AD9739A_REG_IS_RESERVED(reg)	\
+	((reg) == 0x5 || (reg) == 0x9 || (reg) == 0x0E || (reg) == 0x0D || \
+	 (reg) == 0x2B || (reg) == 0x2C || (reg) == 0x34)
+
+#define AD9739A_MIN_DAC_CLK	(1600 * MEGA)
+#define AD9739A_MAX_DAC_CLK	(2500 * MEGA)
+#define AD9739A_DAC_CLK_RANGE	(AD9739A_MAX_DAC_CLK - AD9739A_MIN_DAC_CLK + 1)
+/* as recommended by the datasheet */
+#define AD9739A_LOCK_N_TRIES	3
+
+struct ad9739a_state {
+	struct iio_backend *back;
+	struct regmap *regmap;
+	unsigned long sample_rate;
+};
+
+static int ad9739a_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct ad9739a_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->sample_rate;
+		*val2 = 0;
+		return IIO_VAL_INT_64;
+	default:
+		return -EINVAL;
+	}
+}
+
+enum {
+	AD9739A_TONE_1,
+	AD9739A_TONE_2,
+};
+
+static ssize_t ad9739a_read_ext_info(struct iio_dev *indio_dev,
+				     uintptr_t private,
+				     const struct iio_chan_spec *chan,
+				     char *buf,
+				     int (*backend_op)(struct iio_backend *back,
+						       const struct iio_chan_spec *chan,
+						       int *val, int *val2,
+						       unsigned int tone_idx))
+{
+	struct ad9739a_state *st = iio_priv(indio_dev);
+	int ret, vals[2], tone = 0;
+
+	if (private == AD9739A_TONE_2)
+		tone++;
+
+	ret = backend_op(st->back, chan, &vals[0], &vals[1], tone);
+	if (ret < 0)
+		return ret;
+
+	return iio_format_value(buf, ret, ARRAY_SIZE(vals), vals);
+}
+
+static ssize_t ad9739a_write_ext_info(struct iio_dev *indio_dev,
+				      uintptr_t private,
+				      const struct iio_chan_spec *chan,
+				      const char *buf, size_t len,
+				      int (*backend_op)(struct iio_backend *back,
+							const struct iio_chan_spec *chan,
+							int val, int val2,
+							unsigned int tone_idx))
+{
+	struct ad9739a_state *st = iio_priv(indio_dev);
+	int ret, integer, frac, tone = 0;
+
+	/* assumed IIO_VAL_INT_PLUS_MICRO */
+	ret = iio_str_to_fixpoint(buf, 100000, &integer, &frac);
+	if (ret)
+		return ret;
+
+	if (private == AD9739A_TONE_2)
+		tone++;
+
+	ret = backend_op(st->back, chan, integer, frac, tone);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static ssize_t ad9739a_frequency_get(struct iio_dev *indio_dev,
+				     uintptr_t private,
+				     const struct iio_chan_spec *chan,
+				     char *buf)
+{
+	struct ad9739a_state *st = iio_priv(indio_dev);
+	int ret, vals[2], tone = 0;
+
+	if (private == AD9739A_TONE_2)
+		tone++;
+
+	ret = iio_backend_read_frequency(st->back, chan, &vals[0], &vals[1],
+					 tone, st->sample_rate);
+	if (ret < 0)
+		return ret;
+
+	return iio_format_value(buf, ret, ARRAY_SIZE(vals), vals);
+}
+
+static ssize_t ad9739a_frequency_set(struct iio_dev *indio_dev,
+				     uintptr_t private,
+				     const struct iio_chan_spec *chan,
+				     const char *buf, size_t len)
+{
+	struct ad9739a_state *st = iio_priv(indio_dev);
+	int ret, integer, frac, tone = 0;
+
+	/* assumed IIO_VAL_INT_PLUS_MICRO */
+	ret = iio_str_to_fixpoint(buf, 100000, &integer, &frac);
+	if (ret)
+		return ret;
+
+	if (private == AD9739A_TONE_2)
+		tone++;
+
+	ret = iio_backend_write_frequency(st->back, chan, integer, frac, tone,
+					  st->sample_rate);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static ssize_t ad9739a_scale_get(struct iio_dev *indio_dev, uintptr_t private,
+				 const struct iio_chan_spec *chan, char *buf)
+{
+	return ad9739a_read_ext_info(indio_dev, private, chan, buf,
+				     iio_backend_read_scale);
+}
+
+static ssize_t ad9739a_scale_set(struct iio_dev *indio_dev, uintptr_t private,
+				 const struct iio_chan_spec *chan,
+				 const char *buf, size_t len)
+{
+	return ad9739a_write_ext_info(indio_dev, private, chan, buf, len,
+				      iio_backend_write_scale);
+}
+
+static ssize_t ad9739a_phase_get(struct iio_dev *indio_dev, uintptr_t private,
+				 const struct iio_chan_spec *chan, char *buf)
+{
+	return ad9739a_read_ext_info(indio_dev, private, chan, buf,
+				     iio_backend_read_phase);
+}
+
+static ssize_t ad9739a_phase_set(struct iio_dev *indio_dev, uintptr_t private,
+				 const struct iio_chan_spec *chan,
+				 const char *buf, size_t len)
+{
+	return ad9739a_write_ext_info(indio_dev, private, chan, buf, len,
+				      iio_backend_write_phase);
+}
+
+static int ad9739a_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ad9739a_state *st = iio_priv(indio_dev);
+
+	return iio_backend_data_source_set(st->back, 0, IIO_BACKEND_EXTERNAL);
+}
+
+static int ad9739a_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad9739a_state *st = iio_priv(indio_dev);
+
+	return iio_backend_data_source_set(st->back, 0,
+					   IIO_BACKEND_INTERNAL_CW);
+}
+
+static bool ad9739a_reg_accessible(struct device *dev, unsigned int reg)
+{
+	if (AD9739A_REG_IS_RESERVED(reg))
+		return false;
+	if (reg > AD9739A_REG_MU_STAT1 && reg < AD9739A_REG_ANA_CNT_1)
+		return false;
+
+	return true;
+}
+
+static int ad9739a_reset(struct device *dev, const struct ad9739a_state *st)
+{
+	struct gpio_desc *gpio;
+	int ret;
+
+	gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpio))
+		return PTR_ERR(gpio);
+	if (gpio) {
+		/* minimum pulse width of 40ns */
+		ndelay(40);
+		gpiod_set_value_cansleep(gpio, 0);
+		return 0;
+	}
+
+	/* bring all registers to their default state */
+	ret = regmap_set_bits(st->regmap, AD9739A_REG_MODE, AD9739A_RESET_MASK);
+	if (ret)
+		return ret;
+
+	ndelay(40);
+
+	return regmap_clear_bits(st->regmap, AD9739A_REG_MODE,
+				 AD9739A_RESET_MASK);
+}
+
+/*
+ * Recommended values (as per datasheet) for the dac clk common mode voltage
+ * and Mu controller. Look at table 29.
+ */
+static const struct reg_sequence ad9739a_clk_mu_ctrl[] = {
+	/* DAC clk common mode voltage */
+	{AD9739A_REG_CROSS_CNT1, 0x0f},
+	{AD9739A_REG_CROSS_CNT2, 0x0f},
+	/* Mu controller configuration */
+	{AD9739A_REG_PHS_DET, 0x30},
+	{AD9739A_REG_MU_DUTY, 0x80},
+	{AD9739A_REG_MU_CNT2, 0x44},
+	{AD9739A_REG_MU_CNT3, 0x6c},
+};
+
+static int ad9739a_init(struct device *dev, const struct ad9739a_state *st)
+{
+	unsigned int i = 0, lock;
+	int ret;
+
+	ret = regmap_multi_reg_write(st->regmap, ad9739a_clk_mu_ctrl,
+				     ARRAY_SIZE(ad9739a_clk_mu_ctrl));
+	if (ret)
+		return ret;
+
+	/*
+	 * Try to get the MU lock. Repeat the below steps AD9739A_LOCK_N_TRIES
+	 * (as specified by the datasheet) until we get the lock.
+	 */
+	do {
+		ret = regmap_write(st->regmap, AD9739A_REG_MU_CNT4,
+				   AD9739A_MU_CNT4_DEFAULT);
+		if (ret)
+			return ret;
+
+		/* Enable the Mu controller search and track mode. */
+		ret = regmap_set_bits(st->regmap, AD9739A_REG_MU_CNT1,
+				      AD9739A_MU_EN_MASK);
+		if (ret)
+			return ret;
+
+		/* Ensure the DLL loop is locked */
+		ret = regmap_read_poll_timeout(st->regmap, AD9739A_REG_MU_STAT1,
+					       lock, lock & AD9739A_MU_LOCK_MASK,
+					       0, 1000);
+	} while (ret && ++i < AD9739A_LOCK_N_TRIES);
+
+	if (i == AD9739A_LOCK_N_TRIES)
+		return dev_err_probe(dev, ret, "Mu lock timeout\n");
+
+	/* Receiver tracking an lock. Same deal as the Mu controller */
+	i = 0;
+	do {
+		ret = regmap_update_bits(st->regmap, AD9739A_REG_LVDS_REC_CNT4,
+					 AD9739A_FINE_DEL_SKW_MASK,
+					 FIELD_PREP(AD9739A_FINE_DEL_SKW_MASK, 2));
+		if (ret)
+			return ret;
+
+		/* Disable the receiver and the loop. */
+		ret = regmap_write(st->regmap, AD9739A_REG_LVDS_REC_CNT1, 0);
+		if (ret)
+			return ret;
+
+		/*
+		 * Re-enable the loop so it falls out of lock and begins the
+		 * search/track routine again.
+		 */
+		ret = regmap_set_bits(st->regmap, AD9739A_REG_LVDS_REC_CNT1,
+				      AD9739A_RCVR_LOOP_EN_MASK);
+		if (ret)
+			return ret;
+
+		/* Ensure the DLL loop is locked */
+		ret = regmap_read_poll_timeout(st->regmap,
+					       AD9739A_REG_LVDS_REC_STAT9, lock,
+					       lock == AD9739A_RCVR_TRACK_AND_LOCK,
+					       0, 1000);
+	} while (ret && ++i < AD9739A_LOCK_N_TRIES);
+
+	if (i == AD9739A_LOCK_N_TRIES)
+		return dev_err_probe(dev, ret, "Receiver lock timeout\n");
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ad9739a_buffer_setup_ops = {
+	.preenable = &ad9739a_buffer_preenable,
+	.postdisable = &ad9739a_buffer_postdisable,
+};
+
+static const struct iio_info ad9739a_info = {
+	.read_raw = ad9739a_read_raw,
+};
+
+static const struct regmap_config ad9739a_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.readable_reg = ad9739a_reg_accessible,
+	.writeable_reg = ad9739a_reg_accessible,
+	.max_register = AD9739A_REG_ID,
+};
+
+#define AD9739A_EXT_INFO(_name, _read, _write, _what) {	\
+	.name = (_name),				\
+	.private = (_what),				\
+	.read = (_read),				\
+	.write = (_write),				\
+	.shared = IIO_SEPARATE,				\
+}
+
+static const struct iio_chan_spec_ext_info ad9739a_ext_info[] = {
+	AD9739A_EXT_INFO("frequency0", ad9739a_frequency_get,
+			 ad9739a_frequency_set, AD9739A_TONE_1),
+	AD9739A_EXT_INFO("frequency1", ad9739a_frequency_get,
+			 ad9739a_frequency_set, AD9739A_TONE_2),
+	AD9739A_EXT_INFO("scale0", ad9739a_scale_get,
+			 ad9739a_scale_set, AD9739A_TONE_1),
+	AD9739A_EXT_INFO("scale1", ad9739a_scale_get,
+			 ad9739a_scale_set, AD9739A_TONE_2),
+	AD9739A_EXT_INFO("phase0", ad9739a_phase_get,
+			 ad9739a_phase_set, AD9739A_TONE_1),
+	AD9739A_EXT_INFO("phase1", ad9739a_phase_get,
+			 ad9739a_phase_set, AD9739A_TONE_2),
+	{}
+};
+
+static const struct iio_chan_spec ad9739a_channel[] = {
+	{
+		.type = IIO_ALTVOLTAGE,
+		.indexed = 1,
+		.output = 1,
+		.scan_index = -1,
+		.ext_info = ad9739a_ext_info,
+	},
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.output = 1,
+		.scan_type = {
+			.sign = 's',
+			.storagebits = 16,
+			.realbits = 16,
+		},
+	}
+};
+
+static int ad9739a_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ad9739a_state *st;
+	unsigned int id;
+	struct clk *clk;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Could not get clkin\n");
+
+	st->sample_rate = clk_get_rate(clk);
+	if (!in_range(st->sample_rate, AD9739A_MIN_DAC_CLK,
+		      AD9739A_DAC_CLK_RANGE))
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid dac clk range(%lu) [%lu %lu]\n",
+				     st->sample_rate, AD9739A_MIN_DAC_CLK,
+				     AD9739A_MAX_DAC_CLK);
+
+	st->regmap = devm_regmap_init_spi(spi, &ad9739a_regmap_config);
+	if (IS_ERR(st->regmap))
+		return PTR_ERR(st->regmap);
+
+	ret = regmap_read(st->regmap, AD9739A_REG_ID, &id);
+	if (ret)
+		return ret;
+
+	if (id != AD9739A_ID)
+		return dev_err_probe(dev, -ENODEV, "Unrecognized CHIP_ID 0x%X",
+				     id);
+
+	ret = ad9739a_reset(dev, st);
+	if (ret)
+		return ret;
+
+	ret = ad9739a_init(dev, st);
+	if (ret)
+		return ret;
+
+	st->back = devm_iio_backend_get(dev, NULL);
+	if (IS_ERR(st->back))
+		return PTR_ERR(st->back);
+
+	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_backend_enable(dev, st->back);
+	if (ret)
+		return ret;
+
+	indio_dev->name = "ad9739a";
+	indio_dev->info = &ad9739a_info;
+	indio_dev->channels = ad9739a_channel;
+	indio_dev->num_channels = ARRAY_SIZE(ad9739a_channel);
+	indio_dev->setup_ops = &ad9739a_buffer_setup_ops;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct of_device_id ad9739a_of_match[] = {
+	{ .compatible = "adi,ad9739a" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ad9739a_of_match);
+
+static const struct spi_device_id ad9739a_id[] = {
+	{"ad9739a"},
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad9739a_id);
+
+static struct spi_driver ad9739a_driver = {
+	.driver = {
+		.name = "ad9739a",
+		.of_match_table = ad9739a_of_match,
+	},
+	.probe = ad9739a_probe,
+	.id_table = ad9739a_id,
+};
+module_spi_driver(ad9739a_driver);
+
+MODULE_AUTHOR("Dragos Bogdan <dragos.bogdan@analog.com>");
+MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD9739 DAC");
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_BACKEND);

-- 
2.43.0


