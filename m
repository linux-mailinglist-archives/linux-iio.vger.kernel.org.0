Return-Path: <linux-iio+bounces-6409-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3AF90B9DA
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 20:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A26286605
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 18:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6E0195967;
	Mon, 17 Jun 2024 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="V4wLkj8g"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A59B19409A;
	Mon, 17 Jun 2024 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718649558; cv=none; b=sucIMpgdbu+qmqyKquKadxlFG+9zPh9P6h/mxHukGwCLUhRWacXqMxaF1nGqfb8gumVVTRByG382unno6S7SRFOrHOGVKb+Ql7CdlUG3Stt07JFc2DpK8pZuSSmEF8m2BKomICAXZwCMAIZpUiE7mTuwWChp4l6Q/yPuQK0IvPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718649558; c=relaxed/simple;
	bh=4qRBp9h17rBOwdTUD6mQ9QEw/zM5QAkk6qO1yqe+v5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXn/e4QvoV4KRHEsVIbumhB9lkz0s9/4yWuRO88yhMfFyQu0GQLYWYNtXusQ5FRUjIur/pNQMPjY+qNZCfavWURiuk8+lfz5N2RtaRSoGDE0SoaUhiw+pIf2930uK9EtKPxhj5z4/5RIK1vauo6kU8G/5e7B44pgXmKbvPuuwpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=V4wLkj8g; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id E86E41F83F;
	Mon, 17 Jun 2024 20:39:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1718649553;
	bh=n5PIH7s62oS9j3Ewuga+ovScNKCoPHXaf9x5RswSBFg=; h=From:To:Subject;
	b=V4wLkj8gz2oxrj9t4x4eAIhTuL/CB+epl2LdwUXJo063xER+nRhSd2xEW9GQpUIfl
	 Q7cABEx6PSA9TKjN5txkZH6uUYcJ0uEvlm5PfRs1B2noC+3yMtyM+u7Y069yLACe6F
	 Ad74vL6HtQJBzWwhyYFXco5qn6IoNdzTzm0wCCCzLbkyBcFDVYztJkpKOYmKZu4lbF
	 VRkM0GX3D9Kl41RRrrN9CD8tt1G+NOH4ZOQYuek17cOHHoUE8F3qv8DUFqPu+kIHaS
	 youn6XHvg+TEYKLe7LcE3ldbgQSums95yqHnyIDaV9TO6IDPnWh9f9sLvLvY4IdkI/
	 3c7zmu7lVUxtA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Francesco Dolcini <francesco@dolcini.it>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v3 2/2] iio: adc: ti-ads1119: Add driver
Date: Mon, 17 Jun 2024 20:39:05 +0200
Message-Id: <20240617183905.4685-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240617183215.4080-1-francesco@dolcini.it>
References: <20240617183215.4080-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

The ADS1119 is a precision, 16-bit, analog-to-digital converter (ADC)
that features two differential or four single-ended inputs through a
flexible input multiplexer (MUX), rail-to-rail input
buffers, a programmable gain stage, a voltage reference, and an
oscillator.

Apart from normal single conversion, the driver also supports
continuous conversion mode using a triggered buffer. However, in this
mode only one channel can be scanned at a time.

Datasheet: https://www.ti.com/lit/gpn/ads1119
Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v3:
 - add MICRO constant on necessary places 
 - add devm_regulator_bulk_get_enable() to handle avdd/dvdd supplies
 - add power down action with devm_add_action_or_reset()
 - add buffer setup functions
 - add iio_validate_scan_mask_onehot() to guarantee only one scan channels
 - add support to other triggers than only the adc irq
 - add device check to adc irq trigger to guarantee associating it only its own device
 - add a cached value for the config register
 - change ads1119_get_hw_datarate() return  
 - change return location in read_raw() and write_raw() 
 - change return location in ads1119_read_data() 
 - change the scan buf to a local struct with correct size and alignment
 - change ads1119_update_config_reg() to ads1119_upd_cfg_reg()
 - fix over wrap in read_poll_timeout() 
 - remove unnecessary goto label in ads1119_single_conversion() 
 - remove unnecessary empty lines 
 - remove scan mask from the driver state
 - remove ads1119_validate_gain() and call it inline in write_raw()
 - remove all ads1119_cmd functions and use i2c_smbus inline

v2:
 - add 2 functions to wr/rd regs values: ads1119_update_config_reg and ads1119_data_ready
 - add FIELD(PREP, GET) for bitmasks
 - add driver string inline
 - add devm_regulator_get_enable_read_voltage to handle external vref
 - add comment for resume function
 - add userspace configuration of gain/datarate
 - changed bitmasks names to FIELD suffix
 - changed channel allocation to handle diff-channels/single-channel
 - changed single conversion to power down on error
 - changed to create scan masks dynamically to avoid warnings
 - fix ret=0 in ads1119_read_data()
 - fix irq trigger handler error handling order
 - removed regmap from code and KCONFIG
 - removed of_match_ptr()
 - removed ads1119_get_configs() and put inlined on probe
 - removed static allocation of iio channels
 - removed ads1119_set_power() and called it inline on necessary places
 - removed not necessary bitmasks and macros
 - removed match data struct
 - removed set mux/gain/datarate functions and called them inline
---
 MAINTAINERS                  |   1 +
 drivers/iio/adc/Kconfig      |  12 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/ti-ads1119.c | 839 +++++++++++++++++++++++++++++++++++
 4 files changed, 853 insertions(+)
 create mode 100644 drivers/iio/adc/ti-ads1119.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8acc2c83605c..7f3d6edb1f16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22396,6 +22396,7 @@ M:	João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
+F:	drivers/iio/adc/ti-ads1119.c
 
 TI ADS7924 ADC DRIVER
 M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 5030319249c5..6ad181cf315b 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1350,6 +1350,18 @@ config TI_ADS1015
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads1015.
 
+config TI_ADS1119
+       tristate "Texas Instruments ADS1119 ADC"
+       depends on I2C
+       select IIO_BUFFER
+       select IIO_TRIGGERED_BUFFER
+       help
+         If you say yes here you get support for Texas Instruments ADS1119
+         ADC chip.
+
+         This driver can also be built as a module. If so, the module will be
+         called ti-ads1119.
+
 config TI_ADS7924
 	tristate "Texas Instruments ADS7924 ADC"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 37ac689a0209..51298c52b223 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -121,6 +121,7 @@ obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
 obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
 obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
 obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
+obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
 obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
 obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
 obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
new file mode 100644
index 000000000000..ccf259ebae08
--- /dev/null
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -0,0 +1,839 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Texas Instruments ADS1119 ADC driver.
+ *
+ * Copyright 2024 Toradex
+ */
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+
+#define ADS1119_CMD_RESET		0x06
+#define ADS1119_CMD_POWERDOWN		0x02
+#define ADS1119_CMD_START_SYNC		0x08
+#define ADS1119_CMD_RDATA		0x10
+#define ADS1119_CMD_RREG_CONFIG		0x20
+#define ADS1119_CMD_RREG_STATUS		0x24
+#define ADS1119_CMD_WREG		0x40
+
+#define ADS1119_CMD_RREG(reg)		(0x20 | (reg) << 2)
+
+/* Config register */
+#define ADS1119_REG_CONFIG	0x00
+#define ADS1119_CONFIG_VREF_FIELD	BIT(0)
+#define ADS1119_CONFIG_CM_FIELD		BIT(1)
+#define ADS1119_CONFIG_DR_FIELD		GENMASK(3, 2)
+#define ADS1119_CONFIG_GAIN_FIELD	BIT(4)
+#define ADS1119_CONFIG_MUX_FIELD	GENMASK(7, 5)
+
+#define ADS1119_VREF_INTERNAL	0
+#define ADS1119_VREF_EXTERNAL	1
+#define ADS1119_VREF_INTERNAL_VAL 2048000
+
+#define ADS1119_CM_SINGLE	0
+#define ADS1119_CM_CONTINUOUS	1
+
+#define ADS1119_DR_20_SPS	0
+#define ADS1119_DR_90_SPS	1
+#define ADS1119_DR_330_SPS	2
+#define ADS1119_DR_1000_SPS	3
+
+#define ADS1119_GAIN_1	0
+#define ADS1119_GAIN_4	1
+
+#define ADS1119_MUX_AIN0_AIN1	0
+#define ADS1119_MUX_AIN2_AIN3	1
+#define ADS1119_MUX_AIN1_AIN2	2
+#define ADS1119_MUX_AIN0	3
+#define ADS1119_MUX_AIN1	4
+#define ADS1119_MUX_AIN2	5
+#define ADS1119_MUX_AIN3	6
+#define ADS1119_MUX_SHORTED	7
+
+/* Status register */
+#define ADS1119_REG_STATUS	0x01
+#define ADS1119_STATUS_DRDY_FIELD	BIT(7)
+
+#define ADS1119_DEFAULT_GAIN		1
+#define ADS1119_DEFAULT_DATARATE	20
+
+#define ADS1119_SUSPEND_DELAY		2000
+
+/* Timeout based on the minimum sample rate of 20 SPS (50000us) */
+#define ADS1119_MAX_DRDY_TIMEOUT	85000
+
+#define ADS1119_MAX_CHANNELS		7
+#define ADS1119_MAX_SINGLE_CHANNELS	4
+
+#define ADS1119_V_CHAN(_chan, _chan2, _addr) {			\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.address = _addr,					\
+	.channel = _chan,					\
+	.channel2 = _chan2,					\
+	.info_mask_separate =					\
+		BIT(IIO_CHAN_INFO_RAW) |			\
+		BIT(IIO_CHAN_INFO_SCALE) |			\
+		BIT(IIO_CHAN_INFO_OFFSET) |			\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.info_mask_shared_by_all_available =			\
+		BIT(IIO_CHAN_INFO_SCALE) |			\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.scan_index = _addr,					\
+	.scan_type = {						\
+		.sign = 's',					\
+		.realbits = 16,					\
+		.storagebits = 16,				\
+		.endianness = IIO_CPU,				\
+	},							\
+}
+
+struct ads1119_channel_config {
+	int gain;
+	int datarate;
+	int mux;
+};
+
+struct ads1119_state {
+	struct completion completion;
+	struct i2c_client *client;
+	struct gpio_desc *reset_gpio;
+	struct iio_trigger *trig;
+	struct ads1119_channel_config *channels_cfg;
+	unsigned int num_channels_cfg;
+	unsigned int cached_config;
+	int vref_uV;
+};
+
+static const char * const ads1119_power_supplies[] = {
+	"avdd", "dvdd"
+};
+
+static const int ads1119_available_datarates[] = {
+	20, 90, 330, 1000,
+};
+
+static const int ads1119_available_gains[] = {
+	1, 1,
+	1, 4,
+};
+
+static int ads1119_upd_cfg_reg(struct ads1119_state *st, unsigned int fields,
+			       unsigned int val)
+{
+	unsigned int config = st->cached_config;
+	int ret;
+
+	config &= ~fields;
+	config |= val;
+
+	ret = i2c_smbus_write_byte_data(st->client, ADS1119_CMD_WREG, config);
+	if (ret)
+		return ret;
+
+	st->cached_config = config;
+
+	return 0;
+}
+
+static bool ads1119_data_ready(struct ads1119_state *st)
+{
+	int status;
+
+	status = i2c_smbus_read_byte_data(st->client, ADS1119_CMD_RREG_STATUS);
+	if (status < 0)
+		return false;
+
+	return !!FIELD_GET(ADS1119_STATUS_DRDY_FIELD, status);
+}
+
+static int ads1119_reset(struct ads1119_state *st)
+{
+	st->cached_config = 0;
+
+	if (!st->reset_gpio)
+		return i2c_smbus_write_byte(st->client, ADS1119_CMD_RESET);
+
+	gpiod_set_value_cansleep(st->reset_gpio, 1);
+	udelay(1);
+	gpiod_set_value_cansleep(st->reset_gpio, 0);
+	udelay(1);
+
+	return 0;
+}
+
+static int ads1119_set_conv_mode(struct ads1119_state *st, bool continuous)
+{
+	unsigned int mode;
+
+	if (continuous)
+		mode = ADS1119_CM_CONTINUOUS;
+	else
+		mode = ADS1119_CM_SINGLE;
+
+	return ads1119_upd_cfg_reg(st, ADS1119_CONFIG_CM_FIELD,
+				   FIELD_PREP(ADS1119_CONFIG_CM_FIELD, mode));
+}
+
+static int ads1119_get_hw_gain(int gain)
+{
+	if (gain == 4)
+		return ADS1119_GAIN_4;
+	else
+		return ADS1119_GAIN_1;
+}
+
+static int ads1119_get_hw_datarate(int datarate)
+{
+	switch (datarate) {
+	case 90:
+		return ADS1119_DR_90_SPS;
+	case 330:
+		return ADS1119_DR_330_SPS;
+	case 1000:
+		return ADS1119_DR_1000_SPS;
+	case 20:
+	default:
+		return ADS1119_DR_20_SPS;
+	}
+}
+
+static int ads1119_configure_channel(struct ads1119_state *st, int mux,
+				     int gain, int datarate)
+{
+	int ret;
+
+	ret = ads1119_upd_cfg_reg(st, ADS1119_CONFIG_MUX_FIELD,
+				  FIELD_PREP(ADS1119_CONFIG_MUX_FIELD, mux));
+	if (ret)
+		return ret;
+
+	ret = ads1119_upd_cfg_reg(st, ADS1119_CONFIG_GAIN_FIELD,
+				  FIELD_PREP(ADS1119_CONFIG_GAIN_FIELD,
+				  ads1119_get_hw_gain(gain)));
+	if (ret)
+		return ret;
+
+	return ads1119_upd_cfg_reg(st, ADS1119_CONFIG_DR_FIELD,
+				   FIELD_PREP(ADS1119_CONFIG_DR_FIELD,
+				   ads1119_get_hw_datarate(datarate)));
+}
+
+static int ads1119_poll_data_ready(struct ads1119_state *st,
+				   struct iio_chan_spec const *chan)
+{
+	unsigned int datarate = st->channels_cfg[chan->address].datarate;
+	unsigned long wait_time;
+	bool data_ready;
+
+	/* Poll 5 times more than the data rate */
+	wait_time = DIV_ROUND_CLOSEST(MICRO, 5 * datarate);
+
+	return read_poll_timeout(ads1119_data_ready, data_ready,
+				 data_ready == true, wait_time,
+				 ADS1119_MAX_DRDY_TIMEOUT, false, st);
+}
+
+static int ads1119_read_data(struct ads1119_state *st,
+			     struct iio_chan_spec const *chan,
+			     unsigned int *val)
+{
+	unsigned int timeout;
+	int ret = 0;
+
+	timeout = msecs_to_jiffies(ADS1119_MAX_DRDY_TIMEOUT);
+
+	if (!st->client->irq) {
+		ret = ads1119_poll_data_ready(st, chan);
+		if (ret)
+			return ret;
+	} else if (!wait_for_completion_timeout(&st->completion, timeout)) {
+		return -ETIMEDOUT;
+	}
+
+	ret = i2c_smbus_read_word_swapped(st->client, ADS1119_CMD_RDATA);
+	if (ret < 0)
+		return ret;
+
+	*val = ret;
+
+	return 0;
+}
+
+static int ads1119_single_conversion(struct ads1119_state *st,
+				     struct iio_chan_spec const *chan,
+				     int *val,
+				     bool calib_offset)
+{
+	struct device *dev = &st->client->dev;
+	int mux, gain, datarate;
+	unsigned int sample;
+	int ret;
+
+	mux = st->channels_cfg[chan->address].mux;
+	gain = st->channels_cfg[chan->address].gain;
+	datarate = st->channels_cfg[chan->address].datarate;
+
+	if (calib_offset)
+		mux = ADS1119_MUX_SHORTED;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		goto pdown;
+
+	ret = ads1119_configure_channel(st, mux, gain, datarate);
+	if (ret)
+		goto pdown;
+
+	ret = i2c_smbus_write_byte(st->client, ADS1119_CMD_START_SYNC);
+	if (ret)
+		goto pdown;
+
+	ret = ads1119_read_data(st, chan, &sample);
+	if (ret)
+		goto pdown;
+
+	*val = sign_extend32(sample, chan->scan_type.realbits - 1);
+	ret = IIO_VAL_INT;
+pdown:
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	return ret;
+}
+
+static int ads1119_validate_datarate(struct ads1119_state *st, int datarate)
+{
+	switch (datarate) {
+	case 20:
+	case 90:
+	case 330:
+	case 1000:
+		return datarate;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads1119_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*type = IIO_VAL_FRACTIONAL;
+		*vals = ads1119_available_gains;
+		*length = ARRAY_SIZE(ads1119_available_gains);
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type = IIO_VAL_INT;
+		*vals = ads1119_available_datarates;
+		*length = ARRAY_SIZE(ads1119_available_datarates);
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads1119_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct ads1119_state *st = iio_priv(indio_dev);
+	unsigned int index = chan->address;
+
+	if (index >= st->num_channels_cfg)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
+			return ads1119_single_conversion(st, chan, val, false);
+		unreachable();
+	case IIO_CHAN_INFO_OFFSET:
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
+			return ads1119_single_conversion(st, chan, val, true);
+		unreachable();
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->vref_uV / 1000;
+		*val /= st->channels_cfg[index].gain;
+		*val2 = chan->scan_type.realbits - 1;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->channels_cfg[index].datarate;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads1119_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct ads1119_state *st = iio_priv(indio_dev);
+	unsigned int index = chan->address;
+	int ret;
+
+	if (index >= st->num_channels_cfg)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		ret = MICRO / ((val * MICRO) + val2);
+		if (ret != 1 && ret != 4)
+			return -EINVAL;
+
+		st->channels_cfg[index].gain = ret;
+		return 0;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = ads1119_validate_datarate(st, val);
+		if (ret < 0)
+			return ret;
+
+		st->channels_cfg[index].datarate = ret;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads1119_debugfs_reg_access(struct iio_dev *indio_dev,
+				      unsigned int reg, unsigned int writeval,
+				      unsigned int *readval)
+{
+	struct ads1119_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (reg > ADS1119_REG_STATUS)
+		return -EINVAL;
+
+	if (readval) {
+		ret = i2c_smbus_read_byte_data(st->client,
+					       ADS1119_CMD_RREG(reg));
+		if (ret < 0)
+			return ret;
+
+		*readval = ret;
+		return 0;
+	}
+
+	if (reg > ADS1119_REG_CONFIG)
+		return -EINVAL;
+
+	return i2c_smbus_write_byte_data(st->client, ADS1119_CMD_WREG,
+					 writeval);
+}
+
+static const struct iio_info ads1119_info = {
+	.read_avail = ads1119_read_avail,
+	.read_raw = ads1119_read_raw,
+	.write_raw = ads1119_write_raw,
+	.debugfs_reg_access = ads1119_debugfs_reg_access,
+};
+
+static int ads1119_triggered_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ads1119_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->client->dev;
+	unsigned int index;
+	int ret;
+
+	index = find_first_bit(indio_dev->active_scan_mask,
+			       indio_dev->masklength);
+
+	ret = ads1119_set_conv_mode(st, true);
+	if (ret)
+		return ret;
+
+	ret = ads1119_configure_channel(st,
+					st->channels_cfg[index].mux,
+					st->channels_cfg[index].gain,
+					st->channels_cfg[index].datarate);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	return i2c_smbus_write_byte(st->client, ADS1119_CMD_START_SYNC);
+}
+
+static int ads1119_triggered_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ads1119_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->client->dev;
+	int ret;
+
+	ret = ads1119_set_conv_mode(st, false);
+	if (ret)
+		return ret;
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ads1119_buffer_setup_ops = {
+	.preenable = ads1119_triggered_buffer_preenable,
+	.postdisable = ads1119_triggered_buffer_postdisable,
+	.validate_scan_mask = &iio_validate_scan_mask_onehot,
+};
+
+static const struct iio_trigger_ops ads1119_trigger_ops = {
+	.validate_device = &iio_trigger_validate_own_device,
+};
+
+static irqreturn_t ads1119_irq_handler(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev = dev_id;
+	struct ads1119_state *st = iio_priv(indio_dev);
+
+	if (iio_buffer_enabled(indio_dev) && iio_trigger_using_own(indio_dev))
+		iio_trigger_poll(indio_dev->trig);
+	else
+		complete(&st->completion);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ads1119_trigger_handler(int irq, void *private)
+{
+	struct iio_poll_func *pf = private;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ads1119_state *st = iio_priv(indio_dev);
+	struct {
+		unsigned int sample;
+		s64 timestamp __aligned(8);
+	} scan;
+	unsigned int index;
+	int ret;
+
+	if (!iio_trigger_using_own(indio_dev)) {
+		index = find_first_bit(indio_dev->active_scan_mask,
+				       indio_dev->masklength);
+
+		ret = ads1119_poll_data_ready(st, &indio_dev->channels[index]);
+		if (ret) {
+			dev_err(&st->client->dev,
+				"Failed to poll data on trigger (%d)\n", ret);
+			goto done;
+		}
+	}
+
+	ret = i2c_smbus_read_word_swapped(st->client, ADS1119_CMD_RDATA);
+	if (ret < 0) {
+		dev_err(&st->client->dev,
+			"Failed to read data on trigger (%d)\n", ret);
+		goto done;
+	}
+
+	scan.sample = ret;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
+					   iio_get_time_ns(indio_dev));
+done:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+static int ads1119_init(struct ads1119_state *st, bool vref_external)
+{
+	int ret;
+
+	ret = ads1119_reset(st);
+	if (ret)
+		return ret;
+
+	if (vref_external)
+		return ads1119_upd_cfg_reg(st,
+					   ADS1119_CONFIG_VREF_FIELD,
+					   FIELD_PREP(ADS1119_CONFIG_VREF_FIELD,
+					   ADS1119_VREF_EXTERNAL));
+	return 0;
+}
+
+static int ads1119_map_analog_inputs_mux(int ain_pos, int ain_neg,
+					 bool differential)
+{
+	if (ain_pos >= ADS1119_MAX_SINGLE_CHANNELS)
+		return -EINVAL;
+
+	if (!differential)
+		return ADS1119_MUX_AIN0 + ain_pos;
+
+	if (ain_pos == 0 && ain_neg == 1)
+		return ADS1119_MUX_AIN0_AIN1;
+	else if (ain_pos == 1 && ain_neg == 2)
+		return ADS1119_MUX_AIN1_AIN2;
+	else if (ain_pos == 2 && ain_neg == 3)
+		return ADS1119_MUX_AIN2_AIN3;
+
+	return -EINVAL;
+}
+
+static int ads1119_alloc_and_config_channels(struct iio_dev *indio_dev)
+{
+	const struct iio_chan_spec ads1119_channel = ADS1119_V_CHAN(0, 0, 0);
+	const struct iio_chan_spec ads1119_ts = IIO_CHAN_SOFT_TIMESTAMP(0);
+	struct ads1119_state *st = iio_priv(indio_dev);
+	struct iio_chan_spec *iio_channels, *chan;
+	struct device *dev = &st->client->dev;
+	unsigned int num_channels, i;
+	bool differential;
+	u32 ain[2];
+	int ret;
+
+	st->num_channels_cfg = device_get_child_node_count(dev);
+	if (st->num_channels_cfg > ADS1119_MAX_CHANNELS)
+		return dev_err_probe(dev, -EINVAL,
+				     "Too many channels %d, max is %d\n",
+				     st->num_channels_cfg,
+				     ADS1119_MAX_CHANNELS);
+
+	st->channels_cfg = devm_kcalloc(dev, st->num_channels_cfg,
+					sizeof(*st->channels_cfg), GFP_KERNEL);
+	if (!st->channels_cfg)
+		return -ENOMEM;
+
+	/* Allocate one more iio channel for the timestamp */
+	num_channels = st->num_channels_cfg + 1;
+	iio_channels = devm_kcalloc(dev, num_channels,
+				    sizeof(*iio_channels),
+				    GFP_KERNEL);
+	if (!iio_channels)
+		return -ENOMEM;
+
+	i = 0;
+
+	device_for_each_child_node_scoped(dev, child) {
+		chan = &iio_channels[i];
+
+		differential = fwnode_property_present(child, "diff-channels");
+		if (differential)
+			ret = fwnode_property_read_u32_array(child,
+							     "diff-channels",
+							     ain, 2);
+		else
+			ret = fwnode_property_read_u32(child, "single-channel",
+						       &ain[0]);
+
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to get channel property\n");
+
+		ret = ads1119_map_analog_inputs_mux(ain[0], ain[1],
+						    differential);
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "Invalid channel value\n");
+
+		st->channels_cfg[i].mux = ret;
+		st->channels_cfg[i].gain = ADS1119_DEFAULT_GAIN;
+		st->channels_cfg[i].datarate = ADS1119_DEFAULT_DATARATE;
+
+		*chan = ads1119_channel;
+		chan->channel = ain[0];
+		chan->address = i;
+		chan->scan_index = i;
+
+		if (differential) {
+			chan->channel2 = ain[1];
+			chan->differential = 1;
+		}
+
+		dev_dbg(dev, "channel: index %d, mux %d\n", i,
+			st->channels_cfg[i].mux);
+
+		i++;
+	}
+
+	iio_channels[i] = ads1119_ts;
+	iio_channels[i].address = i;
+	iio_channels[i].scan_index = i;
+
+	indio_dev->channels = iio_channels;
+	indio_dev->num_channels = num_channels;
+
+	return 0;
+}
+
+static void ads1119_powerdown(void *data)
+{
+	struct ads1119_state *st = data;
+
+	i2c_smbus_write_byte(st->client, ADS1119_CMD_POWERDOWN);
+}
+
+static int ads1119_probe(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct ads1119_state *st;
+	struct device *dev = &client->dev;
+	bool vref_external = true;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return dev_err_probe(dev, -ENOMEM,
+				     "Failed to allocate IIO device\n");
+
+	st = iio_priv(indio_dev);
+	st->client = client;
+
+	indio_dev->name = "ads1119";
+	indio_dev->info = &ads1119_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	i2c_set_clientdata(client, indio_dev);
+
+	ret = devm_regulator_bulk_get_enable(dev,
+					     ARRAY_SIZE(ads1119_power_supplies),
+					     ads1119_power_supplies);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to get and enable supplies\n");
+
+	st->vref_uV = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (st->vref_uV == -ENODEV) {
+		vref_external = false;
+		st->vref_uV = ADS1119_VREF_INTERNAL_VAL;
+	} else if (st->vref_uV < 0) {
+		return dev_err_probe(dev, st->vref_uV, "Failed to get vref\n");
+	}
+
+	st->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(st->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->reset_gpio),
+				     "Failed to get reset gpio\n");
+
+	ret = ads1119_alloc_and_config_channels(indio_dev);
+	if (ret)
+		return ret;
+
+	init_completion(&st->completion);
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      ads1119_trigger_handler,
+					      &ads1119_buffer_setup_ops);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to setup IIO buffer\n");
+
+	if (client->irq > 0) {
+		ret = devm_request_threaded_irq(dev,
+						client->irq,
+						ads1119_irq_handler,
+						NULL,
+						IRQF_TRIGGER_FALLING,
+						"ads1119",
+						indio_dev);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to allocate irq\n");
+
+		st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
+						  indio_dev->name,
+						  iio_device_id(indio_dev));
+		if (!st->trig)
+			return dev_err_probe(dev, -ENOMEM,
+					     "Failed to allocate IIO trigger\n");
+
+		st->trig->ops = &ads1119_trigger_ops;
+		iio_trigger_set_drvdata(st->trig, indio_dev);
+
+		ret = devm_iio_trigger_register(dev, st->trig);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to register IIO trigger\n");
+	}
+
+	ret = ads1119_init(st, vref_external);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to initialize device\n");
+
+	pm_runtime_set_autosuspend_delay(dev, ADS1119_SUSPEND_DELAY);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_set_active(dev);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable pm runtime\n");
+
+	ret = devm_add_action_or_reset(dev, ads1119_powerdown, st);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to add powerdown action\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int ads1119_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct ads1119_state *st = iio_priv(indio_dev);
+
+	return i2c_smbus_write_byte(st->client, ADS1119_CMD_POWERDOWN);
+}
+
+/*
+ * The ADS1119 does not require a resume function because it automatically
+ * powers on after a reset.
+ * After a power down command, the ADS1119 can still communicate but turns off
+ * its analog parts. To resume from power down, the device will power up again
+ * upon receiving a start/sync command.
+ */
+static DEFINE_RUNTIME_DEV_PM_OPS(ads1119_pm_ops,
+				 ads1119_runtime_suspend,
+				 NULL,
+				 NULL);
+
+static const struct of_device_id __maybe_unused ads1119_of_match[] = {
+	{ .compatible = "ti,ads1119" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ads1119_of_match);
+
+static const struct i2c_device_id ads1119_id[] = {
+	{ "ads1119", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ads1119_id);
+
+static struct i2c_driver ads1119_driver = {
+	.driver = {
+		.name = "ads1119",
+		.of_match_table = ads1119_of_match,
+		.pm = pm_ptr(&ads1119_pm_ops),
+	},
+	.probe = ads1119_probe,
+	.id_table = ads1119_id,
+};
+module_i2c_driver(ads1119_driver);
+
+MODULE_AUTHOR("João Paulo Gonçalves <joao.goncalves@toradex.com>");
+MODULE_DESCRIPTION("Texas Instruments ADS1119 ADC Driver");
+MODULE_LICENSE("GPL");
-- 
2.39.2


