Return-Path: <linux-iio+bounces-4919-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAB88C1E45
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 08:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F280D1F20F60
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 06:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3BA15ECCB;
	Fri, 10 May 2024 06:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hBiPC503"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673A9157A4D;
	Fri, 10 May 2024 06:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323321; cv=none; b=uOrMg2fJcSfugkT2NxXdBJFZVRO4WHvfsMb7z7emNQaIqkbEOyFSHgp42ODjjc/TILbfXFsMr10+Mj4cQ7pgvyNmK9P/2QZjH0DMGbuI1k4nQEGr8Fh4NF5YnDTAvh9/4Al43kEYAFhEsERg887oS4jifFgz0JzwslfDrb4nvWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323321; c=relaxed/simple;
	bh=8aKlKal+iMYgGUF9ZB6XAMQT5L6cdwXAX3HyxHbgBwE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGvENWya5UvFHoh0l4YnaTu1VqdHba8m3gfhJPGQgpzpZz+ID3jR4rkqTV8EsSFgeBomWScnH7LoeROoEa/Py7Rcc+xLCYASl788aZpjPsPuxC+pjBaYlJWI7Erai5y/IPo39ushSlR3L91vZSEGq5iuRBLSEnv1RSlBStfGKz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hBiPC503; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A3dPg2016519;
	Fri, 10 May 2024 02:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=DKIM;
	 bh=zNS4RSJT+EmgApnqUQpLYUAPAixrdb5KtRRAo8scnTY=; b=hBiPC503tr6x
	xm4sSZnVeP02wBi8WY2E5UuP7idtvlfCbOscRezKZe1MpRBNg8OT+1DeIGy7W0jo
	tGEmxAUxTq5gdZy82Y5sejSfdcPotSOwygvnqY2DITOcT0ohb12A8U/J5Djjc2yB
	2r54Y8Ao+Q76KMToCGBsZ6qTccrALdxoZwWfWD+zb+USt0m3UsRlg+qOUIA0hGKv
	K1uoEhwH/M0xZpZ6x5wbh75R4Zv+y8ENx2CpfkJ+TwTT6agKN3GlKPfWbS7aKMsa
	Spbz9MhN0/ecTsXmu39k+j2duvtURbK7wrYmo7Ds3bnzGi0eTBGnkx1V21+SHBuH
	lP0Y9Auv6Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3y1bvagg2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 02:41:27 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 44A6fQm2051509
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 10 May 2024 02:41:26 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 10 May
 2024 02:41:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 10 May 2024 02:41:25 -0400
Received: from MTINACO-L03.ad.analog.com (MTINACO-L03.ad.analog.com [10.117.116.80])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 44A6ewwd001379;
	Fri, 10 May 2024 02:41:13 -0400
From: Mariel Tinaco <Mariel.Tinaco@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Dimitri Fedrau
	<dima.fedrau@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/2] iio: dac: support the ad8460 Waveform DAC
Date: Fri, 10 May 2024 14:40:53 +0800
Message-ID: <20240510064053.278257-3-Mariel.Tinaco@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
References: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: hiBeBS1z5ZEG0deoavqI4BzACnu_2i5W
X-Proofpoint-GUID: hiBeBS1z5ZEG0deoavqI4BzACnu_2i5W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_04,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100046

The AD8460 is a “bits in, power out” high voltage, high-power,
highspeed driver optimized for large output current (up to ±1 A)
and high slew rate (up to ±1800 V/μs) at high voltage (up to ±40 V)
into capacitive loads.

A digital engine implements user-configurable features: modes for
digital input, programmable supply current, and fault monitoring
and programmable protection settings for output current,
output voltage, and junction temperature. The AD8460 operates on
high voltage dual supplies up to ±55 V and a single low voltage
supply of 5 V.

Signed-off-by: Mariel Tinaco <Mariel.Tinaco@analog.com>
---
 MAINTAINERS              |   1 +
 drivers/iio/dac/Kconfig  |  13 +
 drivers/iio/dac/Makefile |   1 +
 drivers/iio/dac/ad8460.c | 652 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 667 insertions(+)
 create mode 100644 drivers/iio/dac/ad8460.c

diff --git a/MAINTAINERS b/MAINTAINERS
index dae93df2a..6134cac65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1240,6 +1240,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
+F:	drivers/iio/dac/ad8460.c
 
 ANALOG DEVICES INC AD9739a DRIVER
 M:	Nuno Sa <nuno.sa@analog.com>
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 3c2bf620f..8da5cfe4f 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -300,6 +300,19 @@ config AD7303
 	  To compile this driver as module choose M here: the module will be called
 	  ad7303.
 
+config AD8460
+	tristate "Analog Devices AD8460 DAC driver"
+	depends on SPI
+	select REGMAP_SPI
+	select IIO_BUFFER
+	select IIO_BUFFER_DMAENGINE
+	help
+	  Say yes here to build support for Analog Devices AD8460 Digital to
+	  Analog Converters (DAC).
+
+	  To compile this driver as a module choose M here: the module will be called
+	  ad8460.
+
 config AD8801
 	tristate "Analog Devices AD8801/AD8803 DAC driver"
 	depends on SPI_MASTER
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 8432a81a1..0fa2849e1 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_AD5686_SPI) += ad5686-spi.o
 obj-$(CONFIG_AD5696_I2C) += ad5696-i2c.o
 obj-$(CONFIG_AD7293) += ad7293.o
 obj-$(CONFIG_AD7303) += ad7303.o
+obj-$(CONFIG_AD8460) += ad8460.o
 obj-$(CONFIG_AD8801) += ad8801.o
 obj-$(CONFIG_AD9739A) += ad9739a.o
 obj-$(CONFIG_ADI_AXI_DAC) += adi-axi-dac.o
diff --git a/drivers/iio/dac/ad8460.c b/drivers/iio/dac/ad8460.c
new file mode 100644
index 000000000..4049be0f5
--- /dev/null
+++ b/drivers/iio/dac/ad8460.c
@@ -0,0 +1,652 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AD8460 Waveform generator DAC Driver
+ *
+ * Copyright (C) 2024 Analog Devices, Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/buffer-dma.h>
+#include <linux/iio/buffer-dmaengine.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+
+#define AD8460_CTRL_REG(x)                      (x)
+#define AD8460_HVDAC_DATA_WORD_LOW(x)           (0x60 + (2 * (x)))
+#define AD8460_HVDAC_DATA_WORD_HIGH(x)          (0x61 + (2 * (x)))
+
+#define AD8460_HV_RESET_MSK                     BIT(7)
+#define AD8460_HV_SLEEP_MSK                     BIT(4)
+#define AD8460_WAVE_GEN_MODE_MSK                BIT(0)
+
+#define AD8460_HVDAC_SLEEP_MSK                  BIT(3)
+
+#define AD8460_APG_MODE_ENABLE_MSK              BIT(5)
+#define AD8460_PATTERN_DEPTH_MSK                GENMASK(3, 0)
+
+#define AD8460_SHUTDOWN_FLAG_MSK                BIT(7)
+#define AD8460_DATA_BYTE_LOW_MSK                GENMASK(7, 0)
+#define AD8460_DATA_BYTE_HIGH_MSK               GENMASK(5, 0)
+
+#define AD8460_NOMINAL_VOLTAGE_SPAN		80
+#define AD8460_MIN_VREFIO_UV			120000
+#define AD8460_MAX_VREFIO_UV			1200000
+#define	AD8460_MIN_RSET_OHMS			2000
+#define	AD8460_MAX_RSET_OHMS			20000
+
+struct ad8460_state {
+	struct spi_device *spi;
+	struct regmap *regmap;
+	struct clk *sync_clk;
+	/* lock to protect against multiple access to the device and shared data */
+	struct mutex lock;
+	u32 cache_apg_idx;
+	u32 rset_ohms;
+	int vref_mv;
+};
+
+static int ad8460_hv_reset(struct ad8460_state *state)
+{
+	int ret;
+
+	ret = regmap_update_bits(state->regmap,	AD8460_CTRL_REG(0x00),
+				 AD8460_HV_RESET_MSK,
+				 FIELD_PREP(AD8460_HV_RESET_MSK, 1));
+	if (ret)
+		return ret;
+
+	fsleep(20);
+
+	return regmap_update_bits(state->regmap, AD8460_CTRL_REG(0x00),
+				  AD8460_HV_RESET_MSK,
+				  FIELD_PREP(AD8460_HV_RESET_MSK, 0));
+}
+
+static int ad8460_reset(const struct ad8460_state *state)
+{
+	struct device *dev = &state->spi->dev;
+	struct gpio_desc *reset;
+
+	reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(reset))
+		return dev_err_probe(dev, PTR_ERR(reset),
+				     "Failed to get reset gpio");
+	if (reset) {
+		/* minimum duration of 10ns */
+		ndelay(10);
+		gpiod_set_value_cansleep(reset, 1);
+		return 0;
+	}
+
+	/* bring all registers to their default state */
+	return regmap_write(state->regmap, AD8460_CTRL_REG(0x03), 1);
+}
+
+static int ad8460_enable_apg_mode(struct ad8460_state *state, int val)
+{
+	int ret;
+
+	ret = regmap_update_bits(state->regmap, AD8460_CTRL_REG(0x02),
+				 AD8460_APG_MODE_ENABLE_MSK,
+				 FIELD_PREP(AD8460_APG_MODE_ENABLE_MSK, val));
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(state->regmap, AD8460_CTRL_REG(0x00),
+				  AD8460_WAVE_GEN_MODE_MSK,
+				  FIELD_PREP(AD8460_WAVE_GEN_MODE_MSK, val));
+}
+
+static int ad8460_read_shutdown_flag(struct ad8460_state *state, u64 *flag)
+{
+	int ret, val;
+
+	ret = regmap_read(state->regmap, AD8460_CTRL_REG(0x0E), &val);
+	if (ret)
+		return ret;
+
+	*flag = FIELD_GET(AD8460_SHUTDOWN_FLAG_MSK, val);
+	return 0;
+}
+
+static ssize_t ad8460_read_powerdown(struct iio_dev *indio_dev,
+				     uintptr_t private,
+				     const struct iio_chan_spec *chan,
+				     char *buf)
+{
+	struct ad8460_state *state = iio_priv(indio_dev);
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_read(state->regmap, AD8460_CTRL_REG(0x01), &reg);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%ld\n", FIELD_GET(AD8460_HVDAC_SLEEP_MSK, reg));
+}
+
+static ssize_t ad8460_write_powerdown(struct iio_dev *indio_dev,
+				      uintptr_t private,
+				      const struct iio_chan_spec *chan,
+				      const char *buf,
+				      size_t len)
+{
+	struct ad8460_state *state = iio_priv(indio_dev);
+	bool pwr_down;
+	u64 sdn_flag;
+	int ret;
+
+	ret = kstrtobool(buf, &pwr_down);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&state->lock);
+
+	ret = regmap_update_bits(state->regmap, AD8460_CTRL_REG(0x01),
+				 AD8460_HVDAC_SLEEP_MSK,
+				 FIELD_PREP(AD8460_HVDAC_SLEEP_MSK, pwr_down));
+	if (ret)
+		return ret;
+
+	if (!pwr_down) {
+		ret = ad8460_read_shutdown_flag(state, &sdn_flag);
+		if (ret)
+			return ret;
+
+		if (sdn_flag) {
+			ret = ad8460_hv_reset(state);
+			if (ret)
+				return ret;
+		}
+	}
+
+	ret = regmap_update_bits(state->regmap, AD8460_CTRL_REG(0x00),
+				 AD8460_HV_SLEEP_MSK,
+				 FIELD_PREP(AD8460_HV_SLEEP_MSK, !pwr_down));
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static const char * const ad8460_powerdown_modes[] = {
+	"three_state",
+};
+
+static int ad8460_get_powerdown_mode(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan)
+{
+	return 0;
+}
+
+static int ad8460_set_powerdown_mode(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     unsigned int type)
+{
+	return 0;
+}
+
+static int ad8460_get_hvdac_byte(struct ad8460_state *state,
+				 int index,
+				 int *val)
+{
+	unsigned int high, low;
+	int ret;
+
+	ret = regmap_read(state->regmap, AD8460_HVDAC_DATA_WORD_HIGH(index),
+			  &high);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(state->regmap, AD8460_HVDAC_DATA_WORD_LOW(index),
+			  &low);
+	if (ret)
+		return ret;
+
+	*val = FIELD_GET(AD8460_DATA_BYTE_HIGH_MSK, high) << 8 | low;
+
+	return ret;
+}
+
+static int ad8460_set_hvdac_byte(struct ad8460_state *state,
+				 int index,
+				 int val)
+{
+	int ret;
+
+	ret = regmap_write(state->regmap, AD8460_HVDAC_DATA_WORD_LOW(index),
+			   (val & 0xFF));
+	if (ret)
+		return ret;
+
+	return regmap_write(state->regmap, AD8460_HVDAC_DATA_WORD_HIGH(index),
+			    ((val >> 8) & 0xFF));
+}
+
+static int ad8460_set_sample(struct ad8460_state *state, int val)
+{
+	int ret;
+
+	ret = ad8460_enable_apg_mode(state, 1);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&state->lock);
+	ret = ad8460_set_hvdac_byte(state, 0, val);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(state->regmap,
+				  AD8460_CTRL_REG(0x02),
+				  AD8460_PATTERN_DEPTH_MSK,
+				  FIELD_PREP(AD8460_PATTERN_DEPTH_MSK, 0));
+}
+
+static int ad8460_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val,
+			    int val2,
+			    long mask)
+{
+	struct ad8460_state *state = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
+			return ad8460_set_sample(state, val);
+		unreachable();
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad8460_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long mask)
+{
+	struct ad8460_state *state = iio_priv(indio_dev);
+	unsigned int num, denom;
+	int data, ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		scoped_guard(mutex, &state->lock) {
+			ret = ad8460_get_hvdac_byte(state, 0, &data);
+			if (ret)
+				return ret;
+		}
+		*val = data;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = clk_get_rate(state->sync_clk);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		/* vCONV = vNOMINAL_SPAN * (DAC_CODE / 2**14) - 40V
+		 * vMAX  = vNOMINAL_SPAN * (2**14 / 2**14) - 40V
+		 * vMIN  = vNOMINAL_SPAN * (0 / 2**14) - 40V
+		 * vADJ  = vCONV * (2000 / rSET) * (vREF / 1.2)
+		 * vSPAN = vADJ_MAX - vADJ_MIN
+		 * See datasheet page 49, section FULL-SCALE REDUCTION
+		 */
+		num = AD8460_NOMINAL_VOLTAGE_SPAN * 2000 * state->vref_mv;
+		denom = state->rset_ohms * 1200;
+		*val = DIV_ROUND_CLOSEST_ULL(num, denom);
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad8460_reg_access(struct iio_dev *indio_dev,
+			     unsigned int reg, unsigned int writeval,
+			     unsigned int *readval)
+{
+	struct ad8460_state *state = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(state->regmap, reg, readval);
+
+	return regmap_write(state->regmap, reg, writeval);
+}
+
+static int ad8460_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ad8460_state *state = iio_priv(indio_dev);
+
+	return ad8460_enable_apg_mode(state, 0);
+}
+
+static int ad8460_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad8460_state *state = iio_priv(indio_dev);
+
+	return ad8460_enable_apg_mode(state, 1);
+}
+
+static const struct iio_buffer_setup_ops ad8460_buffer_setup_ops = {
+	.preenable = &ad8460_buffer_preenable,
+	.postdisable = &ad8460_buffer_postdisable,
+};
+
+static const struct iio_info ad8460_info = {
+	.read_raw = &ad8460_read_raw,
+	.write_raw = &ad8460_write_raw,
+	.debugfs_reg_access = &ad8460_reg_access,
+};
+
+static const struct iio_enum ad8460_powerdown_mode_enum = {
+	.items = ad8460_powerdown_modes,
+	.num_items = ARRAY_SIZE(ad8460_powerdown_modes),
+	.get = ad8460_get_powerdown_mode,
+	.set = ad8460_set_powerdown_mode,
+};
+
+#define AD8460_CHAN_EXT_INFO(_name, _what, _shared, _read, _write) {	\
+	.name = _name,							\
+	.read = (_read),						\
+	.write = (_write),						\
+	.private = (_what),						\
+	.shared = (_shared),						\
+}
+
+static struct iio_chan_spec_ext_info ad8460_ext_info[] = {
+	AD8460_CHAN_EXT_INFO("powerdown", 0, IIO_SEPARATE,
+			     ad8460_read_powerdown, ad8460_write_powerdown),
+	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad8460_powerdown_mode_enum),
+	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
+			   &ad8460_powerdown_mode_enum),
+	{}
+};
+
+#define AD8460_ALTVOLTAGE_CHAN(_chan) {				\
+	.type = IIO_ALTVOLTAGE,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
+			      BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
+	.output = 1,						\
+	.indexed = 1,						\
+	.channel = (_chan),					\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = 14,					\
+		.storagebits = 16,				\
+		.endianness = IIO_LE,				\
+	},                                                      \
+	.ext_info = ad8460_ext_info,                            \
+}
+
+static const struct iio_chan_spec ad8460_channels[] = {
+	AD8460_ALTVOLTAGE_CHAN(0),
+};
+
+static const struct regmap_config ad8460_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x7F,
+};
+
+static void ad8460_regulator_disable(void *data)
+{
+	regulator_disable(data);
+}
+
+static int ad8460_set_apg_pattern_depth(void *arg, u64 val)
+{
+	struct iio_dev *indio_dev = arg;
+
+	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+		struct ad8460_state *state = iio_priv(indio_dev);
+
+		return regmap_update_bits(state->regmap, AD8460_CTRL_REG(0x02),
+					  AD8460_PATTERN_DEPTH_MSK,
+					  FIELD_PREP(AD8460_PATTERN_DEPTH_MSK, val));
+	}
+	unreachable();
+}
+
+static int ad8460_show_apg_pattern_depth(void *arg, u64 *val)
+{
+	struct iio_dev *indio_dev = arg;
+	struct ad8460_state *state = iio_priv(indio_dev);
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_read(state->regmap, AD8460_CTRL_REG(0x02), &reg);
+	if (ret)
+		return ret;
+
+	*val = FIELD_GET(AD8460_PATTERN_DEPTH_MSK, reg);
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(ad8460_apg_pattern_depth_fops,
+			 ad8460_show_apg_pattern_depth,
+			 ad8460_set_apg_pattern_depth, "%llu\n");
+
+static ssize_t ad8460_apg_pattern_memory_write(struct file *file,
+					       const char __user *userbuf,
+					       size_t count, loff_t *ppos)
+{
+	struct iio_dev *indio_dev = file->private_data;
+	struct ad8460_state *state = iio_priv(indio_dev);
+	unsigned int reg;
+	char data[16];
+	int ret, val;
+
+	ret = simple_write_to_buffer(data, sizeof(data) - 1, ppos,
+				     userbuf, count);
+	if (ret <= 0)
+		return ret;
+
+	ret = sscanf(data, "%i 0x%X", &reg, &val);
+
+	switch (ret) {
+	case 1:
+		state->cache_apg_idx = reg;
+		break;
+	case 2:
+		state->cache_apg_idx = reg;
+		scoped_guard(mutex, &state->lock) {
+			ret = ad8460_set_hvdac_byte(state, reg, val);
+			if (ret) {
+				dev_err(indio_dev->dev.parent, "%s: write failed\n",
+					__func__);
+				return ret;
+			}
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static ssize_t ad8460_apg_pattern_memory_read(struct file *file,
+					      char __user *userbuf,
+					      size_t count, loff_t *ppos)
+{
+	struct iio_dev *indio_dev = file->private_data;
+	struct ad8460_state *state = iio_priv(indio_dev);
+	int ret, val;
+	char data[16];
+
+	scoped_guard(mutex, &state->lock) {
+		ret = ad8460_get_hvdac_byte(state, state->cache_apg_idx, &val);
+		if (ret)
+			return ret;
+	}
+
+	ret = scnprintf(data, sizeof(data), "%i 0x%X\n", state->cache_apg_idx, val);
+
+	return simple_read_from_buffer(userbuf, count, ppos, data, ret);
+}
+
+static const struct file_operations ad8460_apg_pattern_memory_fops = {
+	.open = simple_open,
+	.read = ad8460_apg_pattern_memory_read,
+	.write = ad8460_apg_pattern_memory_write,
+};
+
+static int ad8460_show_shutdown_flag(void *arg, u64 *val)
+{
+	struct iio_dev *indio_dev = arg;
+	struct ad8460_state *state = iio_priv(indio_dev);
+
+	return ad8460_read_shutdown_flag(state, val);
+}
+DEFINE_DEBUGFS_ATTRIBUTE(ad8460_shutdown_flag_fops, ad8460_show_shutdown_flag,
+			 NULL, "%llu\n");
+
+static void ad8460_debugfs_init(struct iio_dev *indio_dev)
+{
+	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
+
+	if (!IS_ENABLED(CONFIG_DEBUG_FS))
+		return;
+
+	debugfs_create_file_unsafe("apg_pattern_depth", 0600, d,
+				   indio_dev, &ad8460_apg_pattern_depth_fops);
+	debugfs_create_file_unsafe("shutdown_flag", 0600, d,
+				   indio_dev, &ad8460_shutdown_flag_fops);
+	debugfs_create_file("apg_pattern_memory", 0644, d,
+			    indio_dev, &ad8460_apg_pattern_memory_fops);
+}
+
+static int ad8460_probe(struct spi_device *spi)
+{
+	struct ad8460_state *state;
+	struct iio_dev *indio_dev;
+	struct regulator *vrefio;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	state = iio_priv(indio_dev);
+	mutex_init(&state->lock);
+
+	state->spi = spi;
+
+	state->regmap = devm_regmap_init_spi(spi, &ad8460_regmap_config);
+	if (IS_ERR(state->regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(state->regmap),
+				     "Failed to initialize regmap");
+
+	ret = devm_iio_dmaengine_buffer_setup_ext(&spi->dev, indio_dev, "tx",
+						  IIO_BUFFER_DIRECTION_OUT);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to get DMA buffer\n");
+
+	state->sync_clk = devm_clk_get_enabled(&spi->dev, "sync_clk");
+	if (IS_ERR(state->sync_clk))
+		return dev_err_probe(&spi->dev, PTR_ERR(state->sync_clk),
+				     "Failed to get sync clk\n");
+
+	vrefio = devm_regulator_get_optional(&spi->dev, "vrefio");
+	if (IS_ERR(vrefio)) {
+		if (PTR_ERR(vrefio) != -ENODEV)
+			return dev_err_probe(&spi->dev, PTR_ERR(vrefio),
+					     "Failed to get vref regulator\n");
+
+		state->vref_mv = 1200;
+
+	} else {
+		ret = regulator_enable(vrefio);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to enable vrefio regulator\n");
+
+		ret = devm_add_action_or_reset(&spi->dev,
+					       ad8460_regulator_disable,
+					       vrefio);
+		if (ret)
+			return ret;
+
+		ret = regulator_get_voltage(vrefio);
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to get ref voltage\n");
+
+		if (!in_range(ret, AD8460_MIN_VREFIO_UV, AD8460_MAX_VREFIO_UV))
+			return dev_err_probe(&spi->dev, -EINVAL,
+					     "Invalid ref voltage range(%u) [%u, %u]\n",
+					     ret, AD8460_MIN_VREFIO_UV,
+					     AD8460_MAX_VREFIO_UV);
+
+		state->vref_mv = ret / 1000;
+	}
+
+	ret = device_property_read_u32(&spi->dev, "adi,rset-ohms",
+				       &state->rset_ohms);
+	if (!ret) {
+		if (!in_range(state->rset_ohms, AD8460_MIN_RSET_OHMS,
+			      AD8460_MAX_RSET_OHMS))
+			return dev_err_probe(&spi->dev, -EINVAL,
+					     "Invalid resistor set range(%u) [%u, %u]\n",
+					     state->rset_ohms,
+					     AD8460_MIN_RSET_OHMS,
+					     AD8460_MAX_RSET_OHMS);
+	}
+
+	ret = ad8460_reset(state);
+	if (ret)
+		return ret;
+
+	/* Enables DAC by default */
+	ret = regmap_update_bits(state->regmap, AD8460_CTRL_REG(0x01),
+				 AD8460_HVDAC_SLEEP_MSK,
+				 FIELD_PREP(AD8460_HVDAC_SLEEP_MSK, 0));
+	if (ret)
+		return ret;
+
+	indio_dev->name = "ad8460";
+	indio_dev->info = &ad8460_info;
+	indio_dev->channels = ad8460_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad8460_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_HARDWARE;
+	indio_dev->setup_ops = &ad8460_buffer_setup_ops;
+
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
+	if (ret)
+		return ret;
+
+	ad8460_debugfs_init(indio_dev);
+
+	return 0;
+}
+
+static const struct of_device_id ad8460_of_match[] = {
+	{ .compatible = "adi, ad8460" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ad8460_of_match);
+
+static struct spi_driver ad8460_driver = {
+	.driver = {
+		.name = "ad8460",
+		.of_match_table = ad8460_of_match,
+	},
+	.probe = ad8460_probe,
+};
+module_spi_driver(ad8460_driver);
+
+MODULE_AUTHOR("Mariel Tinaco <mariel.tinaco@analog.com");
+MODULE_DESCRIPTION("AD8460 DAC driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_DMAENGINE_BUFFER);
-- 
2.34.1


