Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1D85CDEE1
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 12:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfJGKLI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 06:11:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33758 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfJGKLH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2019 06:11:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id i76so757474pgc.0
        for <linux-iio@vger.kernel.org>; Mon, 07 Oct 2019 03:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4q8eOKFIGwAgsdFZc76YNlb0szGETNfMPddqk/7qw5w=;
        b=uwrNa65xZTPtpDbRVFGfTAW9NAGMf/kE/SExQeS/+2ajEs7ayP/3eTen1J8IxIl+sr
         GtwarLNOe422+yDbtUJ0azuKyqk8LgaWTWbhIbqc1pcRFS8M59Aozj5lEC0lZ2DI+oOR
         mQfp/fPnYlvasEi3eafzpbUR5BJUCIAxjzvObWiXuRUv5Ku2Cuw7IinEs07xnB17zcSN
         VdW80nbOv7vy4pzRL6snqUD5QJ2oeJUpSP6/wCF+Bb2xb9Duo9IIs21235u5FqdFye60
         ci6sOvPcy4+Hb3TSIPZ3u/wn1HgfO/s6DlK5VYNkhEUqtgCL2yz9gHpPyiD0dnGVF8c2
         mB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4q8eOKFIGwAgsdFZc76YNlb0szGETNfMPddqk/7qw5w=;
        b=H3VHd9fOOAA6Bfon27yKUkxAYn/zUcpBFGf5D4ZZeBfPkRMEIXH1K71K8Q8nkvyUF5
         usfmTZcTwFhUqM97RmKHnQz6+UiYGZoY8L4y5UQ9oxG7uF/k3a8lxp2X6MjCpkPSLx/2
         OblwQGB9KcMVXQguQAWXn5F9tyDo4us9hrmLeFBOtGri9u9tHWdLmO5lEAAG9TNKbtzB
         9+atYvhPpFLhe5simH9fBpcLDOsYEYxuH4dkW8yof3c9B2oQC3gK7b4lsNeS1m/k+2Rx
         tb4D8xRUkD3UtjDk+lFc7ZqotFCaj7eQuWjcjPVJvf2aAZ4cFghnjdXm9cJriooiwil8
         jkwg==
X-Gm-Message-State: APjAAAXhlr+qsBki96ejo+upe4Dsjr9c+5IQPX7ANGj+pk8CiO9igggS
        FnHRPYAObiNCyOD/aJJ9TZfl
X-Google-Smtp-Source: APXvYqyyA5/uifsW41jsXlmkTL+yyru4S2bYWcGAyXQZ4T5Wb3qnQ6ZDXGLZ0iQvCQbJ/DdRup2Scw==
X-Received: by 2002:a63:1765:: with SMTP id 37mr29671070pgx.121.1570443064943;
        Mon, 07 Oct 2019 03:11:04 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:801:5b45:54fa:fc3f:2c55:c2df])
        by smtp.gmail.com with ESMTPSA id z4sm17465132pfn.45.2019.10.07.03.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 03:11:04 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/2] iio: light: Add support for ADUX1020 sensor
Date:   Mon,  7 Oct 2019 15:40:27 +0530
Message-Id: <20191007101027.8383-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007101027.8383-1-manivannan.sadhasivam@linaro.org>
References: <20191007101027.8383-1-manivannan.sadhasivam@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add initial support for Analog Devices ADUX1020 Photometric sensor.
Only proximity mode has been enabled for now.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/iio/light/Kconfig    |  11 +
 drivers/iio/light/Makefile   |   1 +
 drivers/iio/light/adux1020.c | 783 +++++++++++++++++++++++++++++++++++
 3 files changed, 795 insertions(+)
 create mode 100644 drivers/iio/light/adux1020.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 08d7e1ef2186..3f8c8689cd89 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -32,6 +32,17 @@ config ADJD_S311
 	  This driver can also be built as a module.  If so, the module
 	  will be called adjd_s311.
 
+config ADUX1020
+	tristate "ADUX1020 photometric sensor"
+	select REGMAP_I2C
+	depends on I2C
+	help
+	 Say Y here if you want to build a driver for the Analog Devices
+	 ADUX1020 photometric sensor.
+
+	 To compile this driver as a module, choose M here: the
+	 module will be called adux1020.
+
 config AL3320A
 	tristate "AL3320A ambient light sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 00d1f9b98f39..5d650ce46a40 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -6,6 +6,7 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ACPI_ALS)		+= acpi-als.o
 obj-$(CONFIG_ADJD_S311)		+= adjd_s311.o
+obj-$(CONFIG_ADUX1020)		+= adux1020.o
 obj-$(CONFIG_AL3320A)		+= al3320a.o
 obj-$(CONFIG_APDS9300)		+= apds9300.o
 obj-$(CONFIG_APDS9960)		+= apds9960.o
diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
new file mode 100644
index 000000000000..d0b76e5b44f1
--- /dev/null
+++ b/drivers/iio/light/adux1020.c
@@ -0,0 +1,783 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * adux1020.c - Support for Analog Devices ADUX1020 photometric sensor
+ *
+ * Copyright (C) 2019 Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ *
+ * TODO: Triggered buffer support
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
+
+#define ADUX1020_REGMAP_NAME		"adux1020_regmap"
+#define ADUX1020_DRV_NAME		"adux1020"
+
+/* System registers */
+#define ADUX1020_REG_CHIP_ID		0x08
+#define ADUX1020_REG_SLAVE_ADDRESS	0x09
+
+#define ADUX1020_REG_SW_RESET		0x0f
+#define ADUX1020_REG_INT_ENABLE		0x1c
+#define ADUX1020_REG_INT_POLARITY	0x1d
+#define ADUX1020_REG_PROX_TH_ON1	0x2a
+#define ADUX1020_REG_PROX_TH_OFF1	0x2b
+#define	ADUX1020_REG_PROX_TYPE		0x2f
+#define	ADUX1020_REG_TEST_MODES_3	0x32
+#define	ADUX1020_REG_FORCE_MODE		0x33
+#define	ADUX1020_REG_FREQUENCY		0x40
+#define ADUX1020_REG_LED_CURRENT	0x41
+#define	ADUX1020_REG_OP_MODE		0x45
+#define	ADUX1020_REG_INT_MASK		0x48
+#define	ADUX1020_REG_INT_STATUS		0x49
+#define	ADUX1020_REG_DATA_BUFFER	0x60
+
+/* Chip ID bits */
+#define ADUX1020_CHIP_ID_MASK		GENMASK(11, 0)
+#define ADUX1020_CHIP_ID		0x03fc
+
+#define ADUX1020_MODE_OUT_SHIFT		4
+#define ADUX1020_MODE_OUT_PROX_I	1
+#define ADUX1020_MODE_OUT_PROX_XY	3
+
+#define ADUX1020_SW_RESET		BIT(1)
+#define ADUX1020_FIFO_FLUSH		BIT(15)
+#define ADUX1020_OP_MODE_MASK		GENMASK(3, 0)
+#define ADUX1020_DATA_OUT_MODE_MASK	GENMASK(7, 4)
+
+#define ADUX1020_MODE_INT_MASK		GENMASK(7, 0)
+#define ADUX1020_INT_ENABLE		0x2096
+#define ADUX1020_INT_DISABLE		0x2090
+#define ADUX1020_PROX_INT_ENABLE	0x00f0
+#define ADUX1020_PROX_ON1_INT		BIT(0)
+#define ADUX1020_PROX_OFF1_INT		BIT(1)
+#define ADUX1020_FIFO_INT_ENABLE	0x7f
+#define ADUX1020_MODE_INT_DISABLE	0xff
+#define ADUX1020_MODE_INT_STATUS_MASK	GENMASK(7, 0)
+#define ADUX1020_FIFO_STATUS_MASK	GENMASK(15, 8)
+#define ADUX1020_PROX_TYPE		BIT(15)
+
+#define ADUX1020_INT_PROX_ON1		BIT(0)
+#define ADUX1020_INT_PROX_OFF1		BIT(1)
+
+#define	ADUX1020_FORCE_CLOCK_ON		0x0f4f
+#define	ADUX1020_FORCE_CLOCK_RESET	0x0040
+#define ADUX1020_ACTIVE_4_STATE		0x0008
+
+#define ADUX1020_PROX_FREQ_MASK		GENMASK(7, 4)
+#define ADUX1020_PROX_FREQ_SHIFT	4
+
+#define ADUX1020_LED_CURRENT_MASK	GENMASK(3, 0)
+#define ADUX1020_LED_PIREF_EN		BIT(12)
+
+/* Operating modes */
+enum adux1020_op_modes {
+	ADUX1020_MODE_STANDBY,
+	ADUX1020_MODE_PROX_I,
+	ADUX1020_MODE_PROX_XY,
+	ADUX1020_MODE_GEST,
+	ADUX1020_MODE_SAMPLE,
+	ADUX1020_MODE_FORCE = 0x0e,
+	ADUX1020_MODE_IDLE = 0x0f,
+};
+
+struct adux1020_data {
+	struct i2c_client *client;
+	struct iio_dev *indio_dev;
+	struct mutex lock;
+	struct regmap *regmap;
+};
+
+struct adux1020_mode_data {
+	u8 bytes;
+	u8 buf_len;
+	u16 int_en;
+};
+
+static const struct adux1020_mode_data adux1020_modes[] = {
+	[ADUX1020_MODE_PROX_I] = {
+		.bytes = 2,
+		.buf_len = 1,
+		.int_en = ADUX1020_PROX_INT_ENABLE,
+	},
+};
+
+static const struct regmap_config adux1020_regmap_config = {
+	.name = ADUX1020_REGMAP_NAME,
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = 0x6F,
+	.cache_type = REGCACHE_NONE,
+};
+
+static const int adux1020_def_conf[][2] = {
+	{ 0x000c, 0x000f },
+	{ 0x0010, 0x1010 },
+	{ 0x0011, 0x004c },
+	{ 0x0012, 0x5f0c },
+	{ 0x0013, 0xada5 },
+	{ 0x0014, 0x0080 },
+	{ 0x0015, 0x0000 },
+	{ 0x0016, 0x0600 },
+	{ 0x0017, 0x0000 },
+	{ 0x0018, 0x2693 },
+	{ 0x0019, 0x0004 },
+	{ 0x001a, 0x4280 },
+	{ 0x001b, 0x0060 },
+	{ 0x001c, 0x2094 },
+	{ 0x001d, 0x0020 },
+	{ 0x001e, 0x0001 },
+	{ 0x001f, 0x0100 },
+	{ 0x0020, 0x0320 },
+	{ 0x0021, 0x0A13 },
+	{ 0x0022, 0x0320 },
+	{ 0x0023, 0x0113 },
+	{ 0x0024, 0x0000 },
+	{ 0x0025, 0x2412 },
+	{ 0x0026, 0x2412 },
+	{ 0x0027, 0x0022 },
+	{ 0x0028, 0x0000 },
+	{ 0x0029, 0x0300 },
+	{ 0x002a, 0x0700 },
+	{ 0x002b, 0x0600 },
+	{ 0x002c, 0x6000 },
+	{ 0x002d, 0x4000 },
+	{ 0x002e, 0x0000 },
+	{ 0x002f, 0x0000 },
+	{ 0x0030, 0x0000 },
+	{ 0x0031, 0x0000 },
+	{ 0x0032, 0x0040 },
+	{ 0x0033, 0x0008 },
+	{ 0x0034, 0xE400 },
+	{ 0x0038, 0x8080 },
+	{ 0x0039, 0x8080 },
+	{ 0x003a, 0x2000 },
+	{ 0x003b, 0x1f00 },
+	{ 0x003c, 0x2000 },
+	{ 0x003d, 0x2000 },
+	{ 0x003e, 0x0000 },
+	{ 0x0040, 0x8069 },
+	{ 0x0041, 0x1f2f },
+	{ 0x0042, 0x4000 },
+	{ 0x0043, 0x0000 },
+	{ 0x0044, 0x0008 },
+	{ 0x0046, 0x0000 },
+	{ 0x0048, 0x00ef },
+	{ 0x0049, 0x0000 },
+	{ 0x0045, 0x0000 },
+};
+
+static const int adux1020_rate[][2] = {
+	{ 0, 100000 },
+	{ 0, 200000 },
+	{ 0, 500000 },
+	{ 1, 0 },
+	{ 2, 0 },
+	{ 5, 0 },
+	{ 10, 0 },
+	{ 20, 0 },
+	{ 50, 0 },
+	{ 100, 0 },
+	{ 190, 0 },
+	{ 450, 0 },
+	{ 820, 0 },
+	{ 1400, 0 },
+};
+
+static const int adux1020_led_current[][2] = {
+	{ 0, 25000 },
+	{ 0, 40000 },
+	{ 0, 55000 },
+	{ 0, 70000 },
+	{ 0, 85000 },
+	{ 0, 100000 },
+	{ 0, 115000 },
+	{ 0, 130000 },
+	{ 0, 145000 },
+	{ 0, 160000 },
+	{ 0, 175000 },
+	{ 0, 190000 },
+	{ 0, 205000 },
+	{ 0, 220000 },
+	{ 0, 235000 },
+	{ 0, 250000 },
+};
+
+static void adux1020_flush_fifo(struct adux1020_data *data)
+{
+	/* Force Idle mode */
+	regmap_write(data->regmap, ADUX1020_REG_FORCE_MODE,
+		     ADUX1020_ACTIVE_4_STATE);
+	regmap_update_bits(data->regmap, ADUX1020_REG_OP_MODE,
+			   ADUX1020_OP_MODE_MASK, ADUX1020_MODE_FORCE);
+	regmap_update_bits(data->regmap, ADUX1020_REG_OP_MODE,
+			   ADUX1020_OP_MODE_MASK, ADUX1020_MODE_IDLE);
+
+	/* Flush FIFO */
+	regmap_write(data->regmap, ADUX1020_REG_TEST_MODES_3,
+		     ADUX1020_FORCE_CLOCK_ON);
+	regmap_write(data->regmap, ADUX1020_REG_INT_STATUS,
+		     ADUX1020_FIFO_FLUSH);
+	regmap_write(data->regmap, ADUX1020_REG_TEST_MODES_3,
+		     ADUX1020_FORCE_CLOCK_RESET);
+}
+
+static int adux1020_read_fifo(struct adux1020_data *data, u16 *buf, u8 buf_len)
+{
+	int i, ret = -EINVAL;
+	unsigned int regval;
+
+	/* Enable 32MHz clock */
+	regmap_write(data->regmap, ADUX1020_REG_TEST_MODES_3,
+		     ADUX1020_FORCE_CLOCK_ON);
+
+	for (i = 0; i < buf_len; i++) {
+		ret = regmap_read(data->regmap, ADUX1020_REG_DATA_BUFFER,
+				      &regval);
+		if (ret < 0)
+			goto err_out;
+
+		buf[i] = regval;
+	}
+
+	/* Set 32MHz clock to be controlled by internal state machine */
+	regmap_write(data->regmap, ADUX1020_REG_TEST_MODES_3,
+		     ADUX1020_FORCE_CLOCK_RESET);
+
+err_out:
+	return ret;
+}
+
+static void adux1020_set_mode(struct adux1020_data *data,
+			      enum adux1020_op_modes mode)
+{
+	/* Switch to standby mode before changing the mode */
+	regmap_write(data->regmap, ADUX1020_REG_OP_MODE, ADUX1020_MODE_STANDBY);
+
+	/* Set data out and switch to the desired mode */
+	if (mode == ADUX1020_MODE_PROX_I) {
+		regmap_update_bits(data->regmap, ADUX1020_REG_OP_MODE,
+			ADUX1020_DATA_OUT_MODE_MASK,
+			ADUX1020_MODE_OUT_PROX_I << ADUX1020_MODE_OUT_SHIFT);
+		regmap_update_bits(data->regmap, ADUX1020_REG_OP_MODE,
+			ADUX1020_OP_MODE_MASK, ADUX1020_MODE_PROX_I);
+	}
+}
+
+static int adux1020_measure(struct adux1020_data *data,
+			    enum adux1020_op_modes mode,
+			    u16 *val)
+{
+	int ret, tries = 50;
+	unsigned int status;
+
+	mutex_lock(&data->lock);
+
+	/* Disable INT pin as polling is going to be used */
+	regmap_write(data->regmap, ADUX1020_REG_INT_ENABLE,
+		     ADUX1020_INT_DISABLE);
+
+	/* Enable mode interrupt */
+	regmap_update_bits(data->regmap, ADUX1020_REG_INT_MASK,
+			   ADUX1020_MODE_INT_MASK,
+			   adux1020_modes[mode].int_en);
+
+	while (tries--) {
+		ret = regmap_read(data->regmap, ADUX1020_REG_INT_STATUS,
+				  &status);
+		if (ret < 0)
+			goto fail;
+
+		status &= ADUX1020_FIFO_STATUS_MASK;
+		if (status >= adux1020_modes[mode].bytes)
+			break;
+		msleep(20);
+	}
+
+	if (tries < 0) {
+		ret = -EIO;
+		goto fail;
+	}
+
+	ret = adux1020_read_fifo(data, val, adux1020_modes[mode].buf_len);
+	if (ret < 0)
+		goto fail;
+
+	/* Clear mode interrupt */
+	regmap_write(data->regmap, ADUX1020_REG_INT_STATUS,
+			   (~adux1020_modes[mode].int_en));
+	/* Disable mode interrupts */
+	regmap_update_bits(data->regmap, ADUX1020_REG_INT_MASK,
+			   ADUX1020_MODE_INT_MASK, ADUX1020_MODE_INT_DISABLE);
+
+fail:
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int adux1020_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct adux1020_data *data = iio_priv(indio_dev);
+	u16 buf[3];
+	int ret = -EINVAL;
+	unsigned int regval;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			adux1020_set_mode(data, ADUX1020_MODE_PROX_I);
+			ret = adux1020_measure(data, ADUX1020_MODE_PROX_I, buf);
+			if (ret < 0)
+				return ret;
+
+			*val = buf[0];
+			ret = IIO_VAL_INT;
+			break;
+		default:
+			break;
+		}
+		break;
+	case IIO_CHAN_INFO_PROCESSED:
+		switch (chan->type) {
+		case IIO_CURRENT:
+			ret = regmap_read(data->regmap,
+					  ADUX1020_REG_LED_CURRENT, &regval);
+			if (ret < 0)
+				return ret;
+
+			regval = regval & ADUX1020_LED_CURRENT_MASK;
+
+			*val = adux1020_led_current[regval][0];
+			*val2 = adux1020_led_current[regval][1];
+
+			ret = IIO_VAL_INT_PLUS_MICRO;
+			break;
+		default:
+			break;
+		}
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			ret = regmap_read(data->regmap, ADUX1020_REG_FREQUENCY,
+					  &regval);
+			if (ret < 0)
+				return ret;
+
+			regval = (regval & ADUX1020_PROX_FREQ_MASK) >>
+				  ADUX1020_PROX_FREQ_SHIFT;
+
+			*val = adux1020_rate[regval][0];
+			*val2 = adux1020_rate[regval][1];
+
+			ret = IIO_VAL_INT_PLUS_MICRO;
+			break;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+};
+
+static int adux1020_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct adux1020_data *data = iio_priv(indio_dev);
+	int i, ret = -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (chan->type == IIO_PROXIMITY) {
+			for (i = 0; i < ARRAY_SIZE(adux1020_rate); i++) {
+				if ((val == adux1020_rate[i][0]) &&
+				     (val2 == adux1020_rate[i][1])) {
+					ret = regmap_update_bits(data->regmap,
+						ADUX1020_REG_FREQUENCY,
+						ADUX1020_PROX_FREQ_MASK,
+						i << ADUX1020_PROX_FREQ_SHIFT);
+				}
+			}
+		}
+		break;
+	case IIO_CHAN_INFO_PROCESSED:
+		if (chan->type == IIO_CURRENT) {
+			for (i = 0; i < ARRAY_SIZE(adux1020_led_current); i++) {
+				if ((val == adux1020_led_current[i][0]) &&
+				     (val2 == adux1020_led_current[i][1])) {
+					ret = regmap_update_bits(data->regmap,
+						ADUX1020_REG_LED_CURRENT,
+						ADUX1020_LED_CURRENT_MASK, i);
+				}
+			}
+		}
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int adux1020_write_event_config(struct iio_dev *indio_dev,
+		const struct iio_chan_spec *chan, enum iio_event_type type,
+		enum iio_event_direction dir, int state)
+{
+	struct adux1020_data *data = iio_priv(indio_dev);
+
+	regmap_write(data->regmap, ADUX1020_REG_INT_ENABLE,
+		     ADUX1020_INT_ENABLE);
+
+	regmap_write(data->regmap, ADUX1020_REG_INT_POLARITY, 0);
+
+	switch (chan->type) {
+	case IIO_PROXIMITY:
+		if (dir == IIO_EV_DIR_RISING) {
+			regmap_update_bits(data->regmap, ADUX1020_REG_INT_MASK,
+					   ADUX1020_PROX_ON1_INT,
+					   state ? 0 : ADUX1020_PROX_ON1_INT);
+		} else {
+			regmap_update_bits(data->regmap, ADUX1020_REG_INT_MASK,
+					   ADUX1020_PROX_OFF1_INT,
+					   state ? 0 : ADUX1020_PROX_OFF1_INT);
+		}
+
+		/*
+		 * Trigger proximity interrupt when the intensity is above
+		 * or below threshold
+		 */
+		regmap_update_bits(data->regmap, ADUX1020_REG_PROX_TYPE,
+				   ADUX1020_PROX_TYPE, ADUX1020_PROX_TYPE);
+
+		/* Set proximity mode */
+		adux1020_set_mode(data, ADUX1020_MODE_PROX_I);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int adux1020_read_event_config(struct iio_dev *indio_dev,
+		const struct iio_chan_spec *chan, enum iio_event_type type,
+		enum iio_event_direction dir)
+{
+	struct adux1020_data *data = iio_priv(indio_dev);
+	int ret, mask;
+	unsigned int regval;
+
+	switch (chan->type) {
+	case IIO_PROXIMITY:
+		if (dir == IIO_EV_DIR_RISING)
+			mask = ADUX1020_PROX_ON1_INT;
+		else
+			mask = ADUX1020_PROX_OFF1_INT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_read(data->regmap, ADUX1020_REG_INT_MASK, &regval);
+	if (ret < 0)
+		return ret;
+
+	return !(regval & mask);
+}
+
+static int adux1020_read_thresh(struct iio_dev *indio_dev,
+		const struct iio_chan_spec *chan, enum iio_event_type type,
+		enum iio_event_direction dir, enum iio_event_info info,
+		int *val, int *val2)
+{
+	struct adux1020_data *data = iio_priv(indio_dev);
+	u8 reg;
+	int ret;
+	unsigned int regval;
+
+	switch (chan->type) {
+	case IIO_PROXIMITY:
+		if (dir == IIO_EV_DIR_RISING)
+			reg = ADUX1020_REG_PROX_TH_ON1;
+		else
+			reg = ADUX1020_REG_PROX_TH_OFF1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_read(data->regmap, reg, &regval);
+	if (ret < 0)
+		return ret;
+
+	*val = regval;
+
+	return IIO_VAL_INT;
+}
+
+static int adux1020_write_thresh(struct iio_dev *indio_dev,
+		const struct iio_chan_spec *chan, enum iio_event_type type,
+		enum iio_event_direction dir, enum iio_event_info info,
+		int val, int val2)
+{
+	struct adux1020_data *data = iio_priv(indio_dev);
+	u8 reg;
+
+	switch (chan->type) {
+	case IIO_PROXIMITY:
+		if (dir == IIO_EV_DIR_RISING)
+			reg = ADUX1020_REG_PROX_TH_ON1;
+		else
+			reg = ADUX1020_REG_PROX_TH_OFF1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Full scale threshold value is 0-65535  */
+	if (val < 0 || val > 65535)
+		return -EINVAL;
+
+	return regmap_write(data->regmap, reg, val);
+}
+
+static const struct iio_event_spec adux1020_proximity_event[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec adux1020_channels[] = {
+	{
+		.type = IIO_PROXIMITY,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.event_spec = adux1020_proximity_event,
+		.num_event_specs = ARRAY_SIZE(adux1020_proximity_event),
+	},
+	{
+		.type = IIO_CURRENT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.extend_name = "led",
+	},
+};
+
+static IIO_CONST_ATTR(sampling_frequency_available,
+		      "0.1 0.2 0.5 1 2 5 10 20 50 100 190 450 820 1400");
+
+static struct attribute *adux1020_attributes[] = {
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group adux1020_attribute_group = {
+	.attrs = adux1020_attributes,
+};
+
+static const struct iio_info adux1020_info = {
+	.attrs = &adux1020_attribute_group,
+	.read_raw = adux1020_read_raw,
+	.write_raw = adux1020_write_raw,
+	.read_event_config = adux1020_read_event_config,
+	.write_event_config = adux1020_write_event_config,
+	.read_event_value = adux1020_read_thresh,
+	.write_event_value = adux1020_write_thresh,
+};
+
+static irqreturn_t adux1020_interrupt_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct adux1020_data *data = iio_priv(indio_dev);
+	int ret, status;
+
+	ret = regmap_read(data->regmap, ADUX1020_REG_INT_STATUS, &status);
+	if (ret < 0)
+		return ret;
+
+	status &= ADUX1020_MODE_INT_STATUS_MASK;
+
+	if (status & ADUX1020_INT_PROX_ON1) {
+		iio_push_event(indio_dev,
+				IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
+					IIO_EV_TYPE_THRESH,
+					IIO_EV_DIR_RISING),
+				iio_get_time_ns(indio_dev));
+	}
+
+	if (status & ADUX1020_INT_PROX_OFF1) {
+		iio_push_event(indio_dev,
+				IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
+					IIO_EV_TYPE_THRESH,
+					IIO_EV_DIR_FALLING),
+				iio_get_time_ns(indio_dev));
+	}
+
+	regmap_update_bits(data->regmap, ADUX1020_REG_INT_STATUS,
+			   ADUX1020_MODE_INT_MASK, status);
+
+	return IRQ_HANDLED;
+}
+
+static int adux1020_chip_init(struct adux1020_data *data)
+{
+	struct i2c_client *client = data->client;
+	int ret, i;
+	unsigned int val;
+
+	ret = regmap_read(data->regmap, ADUX1020_REG_CHIP_ID, &val);
+	if (ret < 0)
+		return ret;
+
+	val &= ADUX1020_CHIP_ID_MASK;
+
+	if (val != ADUX1020_CHIP_ID) {
+		dev_err(&client->dev, "invalid chip id 0x%04x\n", val);
+		return -ENODEV;
+	};
+
+	dev_dbg(&client->dev, "Detected ADUX1020 with chip id: 0x%04x\n", val);
+
+	/* Perform software reset */
+	regmap_update_bits(data->regmap, ADUX1020_REG_SW_RESET,
+			   ADUX1020_SW_RESET, ADUX1020_SW_RESET);
+
+	/* Load default configuration */
+	for (i = 0; i < ARRAY_SIZE(adux1020_def_conf); i++)
+		regmap_write(data->regmap, adux1020_def_conf[i][0],
+			     adux1020_def_conf[i][1]);
+
+	adux1020_flush_fifo(data);
+
+	/* Use LED_IREF for proximity mode */
+	regmap_update_bits(data->regmap, ADUX1020_REG_LED_CURRENT,
+			   ADUX1020_LED_PIREF_EN, 0);
+
+	/* Mask all interrupts */
+	regmap_update_bits(data->regmap, ADUX1020_REG_INT_MASK,
+			   ADUX1020_MODE_INT_MASK, ADUX1020_MODE_INT_DISABLE);
+
+	return 0;
+}
+
+static int adux1020_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct adux1020_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &adux1020_info;
+	indio_dev->name = ADUX1020_DRV_NAME;
+	indio_dev->channels = adux1020_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adux1020_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+
+	data->regmap = devm_regmap_init_i2c(client, &adux1020_regmap_config);
+	if (IS_ERR(data->regmap)) {
+		dev_err(&client->dev, "regmap initialization failed.\n");
+		return PTR_ERR(data->regmap);
+	}
+
+	data->client = client;
+	data->indio_dev = indio_dev;
+	mutex_init(&data->lock);
+
+	ret = adux1020_chip_init(data);
+	if (ret)
+		goto err_out;
+
+	if (client->irq) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+				NULL, adux1020_interrupt_handler,
+				IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+				ADUX1020_DRV_NAME, indio_dev);
+		if (ret) {
+			dev_err(&client->dev, "irq request error %d\n", -ret);
+			goto err_out;
+		}
+	}
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(&client->dev, "Failed to register IIO device\n");
+		goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	return ret;
+}
+
+static int adux1020_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+
+	return 0;
+}
+
+static const struct i2c_device_id adux1020_id[] = {
+	{ "adux1020", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, adux1020_id);
+
+static const struct of_device_id adux1020_of_match[] = {
+	{ .compatible = "adi,adux1020" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adux1020_of_match);
+
+static struct i2c_driver adux1020_driver = {
+	.driver = {
+		.name	= ADUX1020_DRV_NAME,
+		.of_match_table = adux1020_of_match,
+	},
+	.probe		= adux1020_probe,
+	.remove		= adux1020_remove,
+	.id_table	= adux1020_id,
+};
+module_i2c_driver(adux1020_driver);
+
+MODULE_AUTHOR("Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>");
+MODULE_DESCRIPTION("ADUX1020 photometric sensor");
+MODULE_LICENSE("GPL");
-- 
2.17.1

