Return-Path: <linux-iio+bounces-23346-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16297B3AD5B
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 00:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A331C86BC1
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 22:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FED261B8C;
	Thu, 28 Aug 2025 22:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="SZquaVSv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD5B1E5718;
	Thu, 28 Aug 2025 22:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756419501; cv=none; b=eKMXglBH3EvX1pixB2AyxBY0e7vrfEjTATTDkRfN97Rolhd8MMZYRMqyDMJo5jVwKNhM+1QAp5xl6RW6Qgct/S3EhHz9wynQ8vn+2zaa43IwhtY0UWkdYylVQKg8mqP8E3FX9mJVvUomdLyE6OKuInqzGsovvgHrTVZhetwwsME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756419501; c=relaxed/simple;
	bh=jcdnnbjSXvWiT6xc3O8oRHf14hf0XAa8q1r5iPdNde0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CO/IOUcM4VMMJNdNOTyOCmLTg2GshrrhSNAFQ050UD/K7LTix6utQ9mrMAD+bx+a9dSdUw4+T83H6p59HP0YdLbUpemC+I7H/liFxjXxSnMvKLz6t4iljU2AR2lw4QSWwZI/zUrrg4EokKRWzRiMnN1ILRqMQ34gzvtJd2Qx+sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=SZquaVSv; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=XK37jPsLjfPKYhqnik27VcfWxcLshRevyhE09GgELYA=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1756419476; v=1; x=1756851476;
 b=SZquaVSvwPq1Nvdn6M8PsDkV+b4kv/NGEAfks1KzubSizgK91WiXIMP5d4qz4EcXpOi9Ys4i
 SICSkIGtajQqgrEy21BNCV2r6aHHCQEw4zy1DiesSV9paSxL/PoL5lBWvTeGNpff/j7AIwehyjJ
 +ngUWVq9trfree26EgUE4NI4v6AElBicdxI9YNceb+b232RS4F6Ol1uCFntUrt8i2Y90TOIwoJT
 MQzrZezlf+SSn/dPgU+9sKBXox9yKJYNHbMrWnB5yBjmTNKLRg45FXv52Fkxki7URVSYAwLchMA
 WM/f3ZIHu/c8IsZ0Lu+t44O3lcbmP8DLAmF3FrzenqnPg==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 01c76dca; Fri, 29 Aug 2025 00:17:56 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Fri, 29 Aug 2025 00:17:41 +0200
Subject: [PATCH 1/2] iio: adc: Add driver for Marvell 88PM886 PMIC ADC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250829-88pm886-gpadc-v1-1-f60262266fea@dujemihanovic.xyz>
References: <20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz>
In-Reply-To: <20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>, 
 Lee Jones <lee@kernel.org>
Cc: David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13612;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=jcdnnbjSXvWiT6xc3O8oRHf14hf0XAa8q1r5iPdNde0=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBkbrk5KmJFfnHNlUT0bd5Dck76tPXrSbIkdsfv/ttcYC
 H5W9q/tKGVhEONikBVTZMn973iN97PI1u3Zywxg5rAygQxh4OIUgInsnszwiznPwnfet7Bn/471
 L67vj9q4VHnKhmeiSfJhbRWT7ZYHvmP4K+C7/NIGbz/NY80Jk7OXxH44VFj6bufPXQv4Q0+mn5m
 pxQgA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Marvell's 88PM886 PMIC has a so-called General Purpose ADC used for
monitoring various system voltages and temperatures. Add the relevant
register definitions to the MFD header and a driver for the ADC.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 MAINTAINERS                     |   5 +
 drivers/iio/adc/88pm886-gpadc.c | 352 ++++++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/Kconfig         |  10 ++
 drivers/iio/adc/Makefile        |   1 +
 include/linux/mfd/88pm886.h     |  30 ++++
 5 files changed, 398 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fed6cd812d796a08cebc0c1fd540c8901d1bf448..b362d81e9c1532cc7920f9cec65b1fd1f81471c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14710,6 +14710,11 @@ F:	drivers/regulator/88pm886-regulator.c
 F:	drivers/rtc/rtc-88pm886.c
 F:	include/linux/mfd/88pm886.h
 
+MARVELL 88PM886 PMIC GPADC DRIVER
+M:	Duje Mihanović <duje@dujemihanovic.xyz>
+S:	Maintained
+F:	drivers/iio/adc/88pm886-gpadc.c
+
 MARVELL ARMADA 3700 PHY DRIVERS
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 S:	Maintained
diff --git a/drivers/iio/adc/88pm886-gpadc.c b/drivers/iio/adc/88pm886-gpadc.c
new file mode 100644
index 0000000000000000000000000000000000000000..129cff48641f1505175e64cf7dbdd0133f265ce8
--- /dev/null
+++ b/drivers/iio/adc/88pm886-gpadc.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2025, Duje Mihanović <duje@dujemihanovic.xyz>
+ */
+
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/iio/driver.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include <linux/mfd/88pm886.h>
+
+static const int regs[] = {
+	PM886_REG_GPADC_VSC,
+	PM886_REG_GPADC_VCHG_PWR,
+	PM886_REG_GPADC_VCF_OUT,
+	PM886_REG_GPADC_TINT,
+
+	PM886_REG_GPADC_GPADC0,
+	PM886_REG_GPADC_GPADC1,
+	PM886_REG_GPADC_GPADC2,
+
+	PM886_REG_GPADC_VBAT,
+	PM886_REG_GPADC_GNDDET1,
+	PM886_REG_GPADC_GNDDET2,
+	PM886_REG_GPADC_VBUS,
+	PM886_REG_GPADC_GPADC3,
+
+	PM886_REG_GPADC_MIC_DET,
+	PM886_REG_GPADC_VBAT_SLP,
+};
+
+enum pm886_gpadc_channel {
+	VSC_CHAN,
+	VCHG_PWR_CHAN,
+	VCF_OUT_CHAN,
+	TINT_CHAN,
+
+	GPADC0_CHAN,
+	GPADC1_CHAN,
+	GPADC2_CHAN,
+
+	VBAT_CHAN,
+	GNDDET1_CHAN,
+	GNDDET2_CHAN,
+	VBUS_CHAN,
+	GPADC3_CHAN,
+
+	MIC_DET_CHAN,
+	VBAT_SLP_CHAN,
+
+	GPADC0_RES_CHAN,
+	GPADC1_RES_CHAN,
+	GPADC2_RES_CHAN,
+	GPADC3_RES_CHAN,
+};
+
+#define ADC_CHANNEL(index, lsb, _type, name) {	\
+	.type = _type, \
+	.indexed = 1, \
+	.channel = index, \
+	.address = lsb, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			      BIT(IIO_CHAN_INFO_PROCESSED), \
+	.datasheet_name = name, \
+}
+
+static const struct iio_chan_spec pm886_adc_channels[] = {
+	ADC_CHANNEL(VSC_CHAN, 1367, IIO_VOLTAGE, "vsc"),
+	ADC_CHANNEL(VCHG_PWR_CHAN, 1709, IIO_VOLTAGE, "vchg_pwr"),
+	ADC_CHANNEL(VCF_OUT_CHAN, 1367, IIO_VOLTAGE, "vcf_out"),
+	ADC_CHANNEL(TINT_CHAN, 104, IIO_TEMP, "tint"),
+
+	ADC_CHANNEL(GPADC0_CHAN, 342, IIO_VOLTAGE, "gpadc0"),
+	ADC_CHANNEL(GPADC1_CHAN, 342, IIO_VOLTAGE, "gpadc1"),
+	ADC_CHANNEL(GPADC2_CHAN, 342, IIO_VOLTAGE, "gpadc2"),
+
+	ADC_CHANNEL(VBAT_CHAN, 1367, IIO_VOLTAGE, "vbat"),
+	ADC_CHANNEL(GNDDET1_CHAN, 342, IIO_VOLTAGE, "gnddet1"),
+	ADC_CHANNEL(GNDDET2_CHAN, 342, IIO_VOLTAGE, "gnddet2"),
+	ADC_CHANNEL(VBUS_CHAN, 1709, IIO_VOLTAGE, "vbus"),
+	ADC_CHANNEL(GPADC3_CHAN, 342, IIO_VOLTAGE, "gpadc3"),
+	ADC_CHANNEL(MIC_DET_CHAN, 1367, IIO_VOLTAGE, "mic_det"),
+	ADC_CHANNEL(VBAT_SLP_CHAN, 1367, IIO_VOLTAGE, "vbat_slp"),
+
+	ADC_CHANNEL(GPADC0_RES_CHAN, 342, IIO_RESISTANCE, "gpadc0_res"),
+	ADC_CHANNEL(GPADC1_RES_CHAN, 342, IIO_RESISTANCE, "gpadc1_res"),
+	ADC_CHANNEL(GPADC2_RES_CHAN, 342, IIO_RESISTANCE, "gpadc2_res"),
+	ADC_CHANNEL(GPADC3_RES_CHAN, 342, IIO_RESISTANCE, "gpadc3_res"),
+};
+
+static const struct regmap_config pm886_gpadc_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = PM886_REG_GPADC_VBAT_SLP + 1,
+};
+
+static int gpadc_get_raw(struct iio_dev *iio, enum pm886_gpadc_channel chan)
+{
+	struct regmap **map = iio_priv(iio);
+	int val, ret;
+	u8 buf[2];
+
+	if (chan >= GPADC0_RES_CHAN)
+		/* Resistor voltage drops are read from the corresponding voltage channel */
+		chan -= GPADC0_RES_CHAN - GPADC0_CHAN;
+
+	ret = regmap_bulk_read(*map, regs[chan], buf, 2);
+
+	if (ret)
+		return ret;
+
+	val = ((buf[0] & 0xff) << 4) | (buf[1] & 0xf);
+	val &= 0xfff;
+
+	return val;
+}
+
+static int gpadc_enable_bias(struct regmap *map, enum pm886_gpadc_channel chan)
+{
+	int adcnum = chan - GPADC0_RES_CHAN, bits;
+
+	if (adcnum < 0 || adcnum > 3)
+		return -EINVAL;
+
+	bits = BIT(adcnum + 4) | BIT(adcnum);
+
+	return regmap_set_bits(map, PM886_REG_GPADC_CONFIG20, bits);
+}
+
+static int
+gpadc_find_bias_current(struct iio_dev *iio, struct iio_chan_spec const *chan, int *volt,
+			int *amp)
+{
+	struct regmap **map = iio_priv(iio);
+	int adcnum = chan->channel - GPADC0_RES_CHAN;
+	int reg = PM886_REG_GPADC_CONFIG11 + adcnum;
+	int ret;
+
+	for (int i = 0; i < 16; i++) {
+		ret = regmap_update_bits(*map, reg, 0xf, i);
+		if (ret)
+			return ret;
+
+		usleep_range(5000, 10000);
+
+		*amp = 1 + i * 5;
+		*volt = gpadc_get_raw(iio, chan->channel) * chan->address;
+
+		/* Measured voltage should never exceed 1.25V */
+		if (WARN_ON(*volt > 1250000))
+			return -EIO;
+
+		if (*volt < 300000) {
+			dev_dbg(&iio->dev, "bad bias for chan %d: %duA @ %duV\n", chan->channel,
+				*amp, *volt);
+		} else {
+			dev_dbg(&iio->dev, "good bias for chan %d: %duA @ %duV\n", chan->channel,
+				*amp, *volt);
+			return 0;
+		}
+	}
+
+	dev_err(&iio->dev, "failed to find good bias for chan %d\n", chan->channel);
+	return -EINVAL;
+}
+
+static int
+gpadc_get_resistor(struct iio_dev *iio, struct iio_chan_spec const *chan)
+{
+	struct regmap **map = iio_priv(iio);
+	int ret, volt, amp;
+
+	ret = gpadc_enable_bias(*map, chan->channel);
+	if (ret)
+		return ret;
+
+	ret = gpadc_find_bias_current(iio, chan, &volt, &amp);
+	if (ret)
+		return ret;
+
+	return DIV_ROUND_CLOSEST(volt, amp);
+}
+
+static int
+pm886_gpadc_read_raw(struct iio_dev *iio, struct iio_chan_spec const *chan, int *val, int *val2,
+		     long mask)
+{
+	struct device *dev = iio->dev.parent;
+	int raw, ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	if (chan->type == IIO_RESISTANCE) {
+		raw = gpadc_get_resistor(iio, chan);
+		if (raw < 0) {
+			ret = raw;
+			goto out;
+		}
+
+		*val = raw;
+		dev_dbg(&iio->dev, "chan: %d, %d Ohm\n", chan->channel, *val);
+		ret = IIO_VAL_INT;
+		goto out;
+	}
+
+	raw = gpadc_get_raw(iio, chan->channel);
+	if (raw < 0) {
+		ret = raw;
+		goto out;
+	}
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*val = raw;
+		dev_dbg(&iio->dev, "chan: %d, raw: %d\n", chan->channel, *val);
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_PROCESSED: {
+		*val = raw * chan->address;
+		ret = IIO_VAL_INT;
+
+		/*
+		 * Voltage measurements are scaled into uV. Scale them back
+		 * into the mV dimension.
+		 */
+		if (chan->type == IIO_VOLTAGE)
+			*val = DIV_ROUND_CLOSEST(*val, 1000);
+
+		dev_dbg(&iio->dev, "chan: %d, raw: %d, processed: %d\n", chan->channel, raw, *val);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	}
+
+out:
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+	return ret;
+}
+
+static int pm886_gpadc_setup(struct regmap *map, bool enable)
+{
+	const u8 config[] = {0xff, 0xfd, 0x1};
+	int ret;
+
+	/* Enable/disable the ADC block */
+	ret = regmap_assign_bits(map, PM886_REG_GPADC_CONFIG6, BIT(0), enable);
+	if (ret || !enable)
+		return ret;
+
+	/* If enabling, enable each individual ADC */
+	return regmap_bulk_write(map, PM886_REG_GPADC_CONFIG1, config, ARRAY_SIZE(config));
+}
+
+static const struct iio_info pm886_gpadc_iio_info = {
+	.read_raw = pm886_gpadc_read_raw,
+};
+
+static int pm886_gpadc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev, *parent = dev->parent;
+	struct pm886_chip *chip = dev_get_drvdata(parent);
+	struct i2c_client *client = chip->client, *page;
+	struct regmap **map;
+	struct iio_dev *iio;
+	int ret;
+
+	iio = devm_iio_device_alloc(dev, sizeof(*map));
+	if (!iio)
+		return -ENOMEM;
+	map = iio_priv(iio);
+
+	dev_set_drvdata(dev, iio);
+
+	page = devm_i2c_new_dummy_device(dev, client->adapter,
+					 client->addr + PM886_PAGE_OFFSET_GPADC);
+	if (IS_ERR(page))
+		return dev_err_probe(dev, PTR_ERR(page), "Failed to initialize GPADC page\n");
+
+	*map = devm_regmap_init_i2c(page, &pm886_gpadc_regmap_config);
+	if (IS_ERR(*map))
+		return dev_err_probe(dev, PTR_ERR(*map),
+				     "Failed to initialize GPADC regmap\n");
+
+	iio->name = "88pm886-gpadc";
+	iio->dev.parent = dev;
+	iio->dev.of_node = parent->of_node;
+	iio->modes = INDIO_DIRECT_MODE;
+	iio->info = &pm886_gpadc_iio_info;
+	iio->channels = pm886_adc_channels;
+	iio->num_channels = ARRAY_SIZE(pm886_adc_channels);
+
+	devm_pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, 50);
+	pm_runtime_use_autosuspend(dev);
+
+	ret = devm_iio_device_register(dev, iio);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register ADC\n");
+
+	return 0;
+}
+
+static int pm886_gpadc_runtime_resume(struct device *dev)
+{
+	struct iio_dev *iio = dev_get_drvdata(dev);
+	struct regmap **map = iio_priv(iio);
+
+	return pm886_gpadc_setup(*map, true);
+}
+
+static int pm886_gpadc_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *iio = dev_get_drvdata(dev);
+	struct regmap **map = iio_priv(iio);
+
+	return pm886_gpadc_setup(*map, false);
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(pm886_gpadc_pm_ops,
+				 pm886_gpadc_runtime_suspend,
+				 pm886_gpadc_runtime_resume, NULL);
+
+static const struct platform_device_id pm886_gpadc_id[] = {
+	{ "88pm886-gpadc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, pm886_gpadc_id);
+
+static struct platform_driver pm886_gpadc_driver = {
+	.driver = {
+		.name = "88pm886-gpadc",
+		.pm = pm_ptr(&pm886_gpadc_pm_ops),
+	},
+	.probe = pm886_gpadc_probe,
+	.id_table = pm886_gpadc_id,
+};
+module_platform_driver(pm886_gpadc_driver);
+
+MODULE_AUTHOR("Duje Mihanović <duje@dujemihanovic.xyz>");
+MODULE_DESCRIPTION("Marvell 88PM886 GPADC driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 24f2572c487ea3db2abec3283ebd93357c08baab..708a4f9b7b70b5044d070a8526a014c4bd362a10 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -9,6 +9,16 @@ menu "Analog to digital converters"
 config IIO_ADC_HELPER
 	tristate
 
+config 88PM886_GPADC
+	tristate "Marvell 88PM886 GPADC driver"
+	depends on MFD_88PM886_PMIC
+	default y
+	help
+	  Say Y here to enable support for the GPADC (General Purpose ADC)
+	  found on the Marvell 88PM886 PMIC. The GPADC measures various
+	  internal voltages and temperatures, including (but not limited to)
+	  system, battery and USB.
+
 config AB8500_GPADC
 	bool "ST-Ericsson AB8500 GPADC driver"
 	depends on AB8500_CORE && REGULATOR_AB8500
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 1c6ca5fd4b6db8c4c40a351b231ba0892e8cd70e..64854907bf3bef7da39f95247e4e502d01232af3 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_IIO_ADC_HELPER) += industrialio-adc.o
 
 # When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_88PM886_GPADC) += 88pm886-gpadc.o
 obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
 obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
 obj-$(CONFIG_AD4000) += ad4000.o
diff --git a/include/linux/mfd/88pm886.h b/include/linux/mfd/88pm886.h
index 85eca44f39ab58ba4cb9ec4216118ee9604d021f..44675f762ce6865dd6053b1aed00cc5987a7d5a2 100644
--- a/include/linux/mfd/88pm886.h
+++ b/include/linux/mfd/88pm886.h
@@ -10,6 +10,7 @@
 #define PM886_IRQ_ONKEY			0
 
 #define PM886_PAGE_OFFSET_REGULATORS	1
+#define PM886_PAGE_OFFSET_GPADC		2
 
 #define PM886_REG_ID			0x00
 
@@ -67,6 +68,35 @@
 #define PM886_REG_BUCK4_VOUT		0xcf
 #define PM886_REG_BUCK5_VOUT		0xdd
 
+/* GPADC enable/disable registers */
+#define PM886_REG_GPADC_CONFIG1		0x1
+#define PM886_REG_GPADC_CONFIG2		0x2
+#define PM886_REG_GPADC_CONFIG3		0x3
+#define PM886_REG_GPADC_CONFIG6		0x6
+
+/* GPADC bias current configuration registers */
+#define PM886_REG_GPADC_CONFIG11	0xb
+#define PM886_REG_GPADC_CONFIG12	0xc
+#define PM886_REG_GPADC_CONFIG13	0xd
+#define PM886_REG_GPADC_CONFIG14	0xe
+#define PM886_REG_GPADC_CONFIG20	0x14
+
+/* GPADC channel registers */
+#define PM886_REG_GPADC_VSC		0x40
+#define PM886_REG_GPADC_VCHG_PWR	0x4c
+#define PM886_REG_GPADC_VCF_OUT		0x4e
+#define PM886_REG_GPADC_TINT		0x50
+#define PM886_REG_GPADC_GPADC0		0x54
+#define PM886_REG_GPADC_GPADC1		0x56
+#define PM886_REG_GPADC_GPADC2		0x58
+#define PM886_REG_GPADC_VBAT		0xa0
+#define PM886_REG_GPADC_GNDDET1		0xa4
+#define PM886_REG_GPADC_GNDDET2		0xa6
+#define PM886_REG_GPADC_VBUS		0xa8
+#define PM886_REG_GPADC_GPADC3		0xaa
+#define PM886_REG_GPADC_MIC_DET		0xac
+#define PM886_REG_GPADC_VBAT_SLP	0xb0
+
 #define PM886_LDO_VSEL_MASK		0x0f
 #define PM886_BUCK_VSEL_MASK		0x7f
 

-- 
2.51.0


