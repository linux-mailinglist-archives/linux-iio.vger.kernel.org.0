Return-Path: <linux-iio+bounces-3863-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A5F89001C
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 14:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CB5A1F21B50
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 13:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6A281AA5;
	Thu, 28 Mar 2024 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdwChKeP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D662A80BEC;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632151; cv=none; b=p+BW/gKmZIBViwkN5pfBC1txaHwRgjizluix7Uwx+Gc9IGbF3sZ7qVvOGwq3vA4kTVFJRXjWX1GPr3+MBekFIbGCWrwZubp9R8EUAuECb/5QiDZoHcsOOz0PP6GS5RWRyAVz2CSl5hn7ztfZMSKz4yVjz/e1rOlKuMg+TbwjPKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632151; c=relaxed/simple;
	bh=LF19WaaztjHdCc6OVmbu8EJvVviIRgJSVfjtU2nVnzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nFRletwBktxnyPNYylreW/NTfUvrHzrYQ2TFDUCECGzHzGRnx/qQDW+LbyzwPPStogQUrqziq8OagE8QT/0AfkPb9H0gX34l5AG1s2Pki4k2DUU1QeRj2sX5e7t/4P2jjVhw/ZxyF6zRpS6+aQxH/3WgvRRcRVy+BY2m0ZjkXuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdwChKeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4F35C43390;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711632151;
	bh=LF19WaaztjHdCc6OVmbu8EJvVviIRgJSVfjtU2nVnzI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FdwChKePih8yPF8GCWKr8mh1/oR8gZTQizWKLvbNXprQLvrXd4/LxqPebE/bya/8Z
	 FnPPUI0TnYmYQqWALVCVp19zyhbko3Cwsxhidv4H8udE46qaMxN1ZnSIODODjX5NU+
	 I/zZ880kUOhpAT/F8ReECLKLScuU5bzAhf1arFe7okWED15qV3+o9EvV61Tr9GU+4p
	 KBLJZLLAFUkUBAlrXUJpDmAkdIORywJ3Ie/X7b0EXMSBYDaCWyJ5BmwdRnQZwIIiTk
	 v7UbKiKwuGEnHD7/n+Sdpxvzj23/LM5iZqDa68jytChYsOLdWbDPfZZn3hE+xozLt1
	 DyQBCMfz9hryQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96F5C54E67;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 28 Mar 2024 14:22:34 +0100
Subject: [PATCH 10/10] iio: dac: support the ad9739a RF DAC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-iio-backend-axi-dac-v1-10-afc808b3fde3@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711632149; l=16736;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=UHJOHHEi0BGVi14Ir1h0p3C6TAALF+GQOiEx2J3ylDQ=;
 b=CjDNLNKLdSgFD1equAvlMWpxTVARFmu5xlV61v0WxfJTXIIIHBHRQTwI5DblZx22sJPKR3vHV
 7+7hnqlSafbCx6s2mVYrQlnIBdHhoxnpx5hrdPtfd9foXcZwxrwlIx1
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

The AD9739A is a 14-bit, 2.5 GSPS high performance RF DACs that are capable
of synthesizing wideband signals from dc up to 3 GHz.

A dual-port, source synchronous, LVDS interface simplifies the digital
interface with existing FGPA/ASIC technology. On-chip controllers are used
to manage external and internal clock domain variations over temperature to
ensure reliable data transfer from the host to the DAC core.

Co-developed-by: Dragos Bogdan <dragos.bogdan@analog.com>
Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-ad9739a |  17 +
 MAINTAINERS                                     |   1 +
 drivers/iio/dac/Kconfig                         |  16 +
 drivers/iio/dac/Makefile                        |   1 +
 drivers/iio/dac/ad9739a.c                       | 445 ++++++++++++++++++++++++
 5 files changed, 480 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-ad9739a b/Documentation/ABI/testing/sysfs-bus-iio-ad9739a
new file mode 100644
index 000000000000..8a8a5cd10386
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-ad9739a
@@ -0,0 +1,17 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_operating_mode
+KernelVersion:	6.9
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Dac operating mode. One of the following modes can be selected:
+         * normal: This is DAC normal mode.
+         * mixed-mode: In this mode the output is effectively chopped at the
+                       DAC sample rate. This has the effect of reducing the
+                       power of the fundamental signal while increasing the
+                       power of the images centered around the DAC sample rate,
+                       thus improving the output power of these images.
+
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_operating_mode_available
+KernelVersion:	6.9
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Available operating modes.
diff --git a/MAINTAINERS b/MAINTAINERS
index 505f28dc6da6..8ad79cf70552 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1241,6 +1241,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
+F:	drivers/iio/dac/ad9739a.c
 
 ANALOG DEVICES INC ADA4250 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 7c0a8caa9a34..ee0d9798d8b4 100644
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
 config ADI_AXI_DAC
 	tristate "Analog Devices Generic AXI DAC IP core driver"
 	select IIO_BUFFER
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 6bcaa65434b2..8432a81a19dc 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_AD5696_I2C) += ad5696-i2c.o
 obj-$(CONFIG_AD7293) += ad7293.o
 obj-$(CONFIG_AD7303) += ad7303.o
 obj-$(CONFIG_AD8801) += ad8801.o
+obj-$(CONFIG_AD9739A) += ad9739a.o
 obj-$(CONFIG_ADI_AXI_DAC) += adi-axi-dac.o
 obj-$(CONFIG_CIO_DAC) += cio-dac.o
 obj-$(CONFIG_DPOT_DAC) += dpot-dac.o
diff --git a/drivers/iio/dac/ad9739a.c b/drivers/iio/dac/ad9739a.c
new file mode 100644
index 000000000000..46431fa345a5
--- /dev/null
+++ b/drivers/iio/dac/ad9739a.c
@@ -0,0 +1,445 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices AD9739a SPI DAC driver
+ *
+ * Copyright 2015-2024 Analog Devices Inc.
+ */
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/gpio/consumer.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
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
+#define AD9739A_REG_FSC_1		0x06
+#define AD9739A_REG_FSC_2		0x07
+#define   AD9739A_FSC_MSB		GENMASK(1, 0)
+#define AD9739A_REG_DEC_CNT		0x8
+#define   AD9739A_DAC_DEC		GENMASK(1, 0)
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
+#define AD9739A_FSC_MIN		8700
+#define AD9739A_FSC_MAX		31700
+#define AD9739A_FSC_RANGE	(AD9739A_FSC_MAX - AD9739A_FSC_MIN + 1)
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
+enum {
+	AD9739A_NORMAL_MODE,
+	AD9739A_MIXED_MODE = 2,
+};
+
+static int ad9739a_oper_mode_get(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan)
+{
+	struct ad9739a_state *st = iio_priv(indio_dev);
+	u32 mode;
+	int ret;
+
+	ret = regmap_read(st->regmap, AD9739A_REG_DEC_CNT, &mode);
+	if (ret)
+		return ret;
+
+	mode = FIELD_GET(AD9739A_DAC_DEC, mode);
+	/* sanity check we get valid values from the HW */
+	if (mode != AD9739A_NORMAL_MODE && mode != AD9739A_MIXED_MODE)
+		return -EIO;
+	if (!mode)
+		return AD9739A_NORMAL_MODE;
+
+	return AD9739A_MIXED_MODE - 1;
+}
+
+static int ad9739a_oper_mode_set(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan, u32 mode)
+{
+	struct ad9739a_state *st = iio_priv(indio_dev);
+
+	if (mode == AD9739A_MIXED_MODE - 1)
+		mode = AD9739A_MIXED_MODE;
+
+	return regmap_update_bits(st->regmap, AD9739A_REG_DEC_CNT,
+				  AD9739A_DAC_DEC, mode);
+}
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
+	unsigned int i = 0, lock, fsc;
+	u32 fsc_raw;
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
+	/* Receiver tracking and lock. Same deal as the Mu controller */
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
+	ret = device_property_read_u32(dev, "adi,full-scale-microamp", &fsc);
+	if (ret && ret == -EINVAL)
+		return 0;
+	if (ret)
+		return ret;
+	if (!in_range(fsc, AD9739A_FSC_MIN, AD9739A_FSC_RANGE))
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid full scale current(%u) [%u %u]\n",
+				     fsc, AD9739A_FSC_MIN, AD9739A_FSC_MAX);
+	/*
+	 * IOUTFS is given by
+	 *	Ioutfs = 0.0226 * FSC + 8.58
+	 * and is given in mA. Hence we'll have to multiply by 10 * MILLI in
+	 * order to get rid of the fractional.
+	 */
+	fsc_raw = DIV_ROUND_CLOSEST(fsc * 10 - 85800, 226);
+
+	ret = regmap_write(st->regmap, AD9739A_REG_FSC_1, fsc_raw & 0xff);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(st->regmap, AD9739A_REG_FSC_1,
+				  AD9739A_FSC_MSB, fsc_raw >> 8);
+}
+
+static const char * const ad9739a_modes_avail[] = { "normal", "mixed-mode" };
+
+static const struct iio_enum ad9739a_modes = {
+	.items = ad9739a_modes_avail,
+	.num_items = ARRAY_SIZE(ad9739a_modes_avail),
+	.get = ad9739a_oper_mode_get,
+	.set = ad9739a_oper_mode_set,
+};
+
+static const struct iio_chan_spec_ext_info ad9739a_ext_info[] = {
+	IIO_ENUM_AVAILABLE("operating_mode", IIO_SEPARATE, &ad9739a_modes),
+	IIO_ENUM("operating_mode", IIO_SEPARATE, &ad9739a_modes),
+};
+
+static struct iio_chan_spec ad9739a_channels[] = {
+	{
+		.type = IIO_ALTVOLTAGE,
+		.indexed = 1,
+		.output = 1,
+		.scan_index = -1,
+	},
+	{
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.output = 1,
+		.ext_info = ad9739a_ext_info,
+		.scan_type = {
+			.sign = 's',
+			.storagebits = 16,
+			.realbits = 16,
+		},
+	}
+};
+
+static const struct iio_info ad9739a_info = {
+	.read_raw = ad9739a_read_raw,
+};
+
+static const struct iio_buffer_setup_ops ad9739a_buffer_setup_ops = {
+	.preenable = &ad9739a_buffer_preenable,
+	.postdisable = &ad9739a_buffer_postdisable,
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
+	ret = iio_backend_extend_chan_spec(indio_dev, st->back,
+					   &ad9739a_channels[0]);
+	if (ret)
+		return ret;
+
+	ret = iio_backend_set_sampling_freq(st->back, 0, st->sample_rate);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_backend_enable(dev, st->back);
+	if (ret)
+		return ret;
+
+	indio_dev->name = "ad9739a";
+	indio_dev->info = &ad9739a_info;
+	indio_dev->channels = ad9739a_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad9739a_channels);
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
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_BACKEND);

-- 
2.44.0



