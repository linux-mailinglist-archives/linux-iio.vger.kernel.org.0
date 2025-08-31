Return-Path: <linux-iio+bounces-23516-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB052B3D224
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 12:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD1743B536A
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 10:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B9C255F27;
	Sun, 31 Aug 2025 10:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="ceBGeT8Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B0623ABBF;
	Sun, 31 Aug 2025 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756636422; cv=none; b=E+OOnUhoSxz+aW+TonCgNxCQi8eu83J55sTOVkb3Gg58lj9lF6kcvG4KyuCFo15JRoP+lgvc49eNNXHcr9zA4Bl2Qa9WyaovLJfSpmbnUW8IznA0mg+P4n9Z6aEyXkL9cCEsQr8YR/FiXOIoOFJ+MtIj6hE1Xf9v43tFgPUVWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756636422; c=relaxed/simple;
	bh=aFuYIkR//cUq0RJAwIKx08u39tiL5jBfJxbdUHDyT1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fHc/QqZ2fmphXN/CSEnI0YsFr/D8olheBk4qkCDvS4Deeq6nkoZwlPlhK8LMFzrN7cyqEGf3Z0r5l/hHPhEzumbLHDwX8LCK4IwE27U1QBaTlvyheK6RaI3lZ29bry+qsrAbM9g+qgeNnEi9rs+VEHuAd/T+JUfBfAJywhhmPMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=ceBGeT8Y; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=0beVqiAHiGGTNrgmpnQZOFk6EzeD3sKNG7jS5aY5Lgo=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1756636410; v=1; x=1757068410;
 b=ceBGeT8YXT71ppuRngC0QKa5Xrv3oiz0gwAwAHF6YvS4veiAPoOaJF9UENHBQpwV7UTfaquq
 pqn6Tp0er+X99xgs11mGZsr/6KCj0Mxavhycd1dWmIIel3q+vuPQP+Tn6JEi2bHN0WiwNMKJJNe
 AfrO7Jegy4mfOH7panh1Xe8iCNa4nf46dV/xf3fv0+FvcbJWKmk0WtKmhlePO/vMsdY14oeOHVG
 kbn4hamjNRnVAqA1Q5AgOCpyhm6XX46yUZnt7NqE5BszWr++ZtHXzaU6CZqfPL11arggUDVISgF
 DhNvW6eMPH9NtPjIzit75s5FNBtSna/CDyp0uQaVThLxQ==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 5d29aea7; Sun, 31 Aug 2025 12:33:30 +0200
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Date: Sun, 31 Aug 2025 12:33:05 +0200
Subject: [PATCH v2 2/3] iio: adc: Add driver for Marvell 88PM886 PMIC ADC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250831-88pm886-gpadc-v2-2-759c1e14d95f@dujemihanovic.xyz>
References: <20250831-88pm886-gpadc-v2-0-759c1e14d95f@dujemihanovic.xyz>
In-Reply-To: <20250831-88pm886-gpadc-v2-0-759c1e14d95f@dujemihanovic.xyz>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=16589;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=aFuYIkR//cUq0RJAwIKx08u39tiL5jBfJxbdUHDyT1Y=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBlbVL7XdaYfOG0frvP4363d5qLeBybHrfWTjX2uts7/t
 tePissnO0pZGMS4GGTFFFly/zte4/0ssnV79jIDmDmsTCBDGLg4BWAidUqMDPvf1pWLTn8ZOFXl
 j5Zg5nR9x2sJMpvfVtxc22jw91vkvhKG/0FPourFeJY9ON/KHd2544yc06LPsSu2fcuM5753XyL
 6GD8A
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

Marvell's 88PM886 PMIC has a so-called General Purpose ADC used for
monitoring various system voltages and temperatures. Add the relevant
register definitions to the MFD header and a driver for the ADC.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
v2:
- default MFD_88PM886_PMIC
- u8[2] -> __be16
- Drop kernel.h include
- Add pm886_gpadc struct
- Reorder channel enum
- Drop GPADC voltage channels
- Drop unnecessary masking in gpadc_get_raw()
- Extend gpadc_enable_bias() to allow disabling bias
- usleep_range() -> fsleep()
- PM wrapper for pm886_gpadc_read_raw()
- Proper channel info: voltage is RAW | SCALE, temperature is RAW |
  OFFSET | SCALE, resistance is PROCESSED
- Explicitly define channels to en/disable in pm886_gpadc_setup()
- Don't explicitly set iio->dev.parent
- Miscellaneous style changes
---
 MAINTAINERS                     |   5 +
 drivers/iio/adc/88pm886-gpadc.c | 383 ++++++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/Kconfig         |  13 ++
 drivers/iio/adc/Makefile        |   1 +
 include/linux/mfd/88pm886.h     |  54 ++++++
 5 files changed, 456 insertions(+)

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
index 0000000000000000000000000000000000000000..4622d2525e0edeed89c6e6d43336b177590aa885
--- /dev/null
+++ b/drivers/iio/adc/88pm886-gpadc.c
@@ -0,0 +1,383 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2025, Duje Mihanović <duje@dujemihanovic.xyz>
+ */
+
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+
+#include <linux/mfd/88pm886.h>
+
+struct pm886_gpadc {
+	struct regmap *map;
+};
+
+static const int pm886_gpadc_regs[] = {
+	PM886_REG_GPADC_VSC,
+	PM886_REG_GPADC_VCHG_PWR,
+	PM886_REG_GPADC_VCF_OUT,
+	PM886_REG_GPADC_VBAT,
+	PM886_REG_GPADC_VBAT_SLP,
+	PM886_REG_GPADC_VBUS,
+
+	PM886_REG_GPADC_GPADC0,
+	PM886_REG_GPADC_GPADC1,
+	PM886_REG_GPADC_GPADC2,
+	PM886_REG_GPADC_GPADC3,
+
+	PM886_REG_GPADC_GND_DET1,
+	PM886_REG_GPADC_GND_DET2,
+	PM886_REG_GPADC_MIC_DET,
+
+	PM886_REG_GPADC_TINT,
+};
+
+/* Must be kept in sync with the table above */
+enum pm886_gpadc_channel {
+	VSC_CHAN,
+	VCHG_PWR_CHAN,
+	VCF_OUT_CHAN,
+	VBAT_CHAN,
+	VBAT_SLP_CHAN,
+	VBUS_CHAN,
+
+	GPADC0_CHAN,
+	GPADC1_CHAN,
+	GPADC2_CHAN,
+	GPADC3_CHAN,
+
+	GND_DET1_CHAN,
+	GND_DET2_CHAN,
+	MIC_DET_CHAN,
+
+	TINT_CHAN,
+};
+
+#define ADC_CHANNEL_VOLTAGE(index, lsb, name) {	\
+	.type = IIO_VOLTAGE, \
+	.indexed = 1, \
+	.channel = index, \
+	.address = lsb, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			      BIT(IIO_CHAN_INFO_SCALE), \
+	.datasheet_name = name, \
+}
+
+#define ADC_CHANNEL_RESISTANCE(index, lsb, name) { \
+	.type = IIO_RESISTANCE, \
+	.indexed = 1, \
+	.channel = index, \
+	.address = lsb, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), \
+	.datasheet_name = name, \
+}
+
+#define ADC_CHANNEL_TEMPERATURE(index, lsb, name) { \
+	.type = IIO_TEMP, \
+	.indexed = 1, \
+	.channel = index, \
+	.address = lsb, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			      BIT(IIO_CHAN_INFO_SCALE) | \
+			      BIT(IIO_CHAN_INFO_OFFSET), \
+	.datasheet_name = name, \
+}
+
+static const struct iio_chan_spec pm886_gpadc_channels[] = {
+	ADC_CHANNEL_VOLTAGE(VSC_CHAN, 1367, "vsc"),
+	ADC_CHANNEL_VOLTAGE(VCHG_PWR_CHAN, 1709, "vchg_pwr"),
+	ADC_CHANNEL_VOLTAGE(VCF_OUT_CHAN, 1367, "vcf_out"),
+	ADC_CHANNEL_VOLTAGE(VBAT_CHAN, 1367, "vbat"),
+	ADC_CHANNEL_VOLTAGE(VBAT_SLP_CHAN, 1367, "vbat_slp"),
+	ADC_CHANNEL_VOLTAGE(VBUS_CHAN, 1709, "vbus"),
+
+	ADC_CHANNEL_RESISTANCE(GPADC0_CHAN, 342, "gpadc0"),
+	ADC_CHANNEL_RESISTANCE(GPADC1_CHAN, 342, "gpadc1"),
+	ADC_CHANNEL_RESISTANCE(GPADC2_CHAN, 342, "gpadc2"),
+	ADC_CHANNEL_RESISTANCE(GPADC3_CHAN, 342, "gpadc3"),
+
+	ADC_CHANNEL_VOLTAGE(GND_DET1_CHAN, 342, "gnddet1"),
+	ADC_CHANNEL_VOLTAGE(GND_DET2_CHAN, 342, "gnddet2"),
+	ADC_CHANNEL_VOLTAGE(MIC_DET_CHAN, 1367, "mic_det"),
+
+	ADC_CHANNEL_TEMPERATURE(TINT_CHAN, 104, "tint"),
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
+	struct pm886_gpadc *gpadc = iio_priv(iio);
+	__be16 buf;
+	int ret;
+
+	ret = regmap_bulk_read(gpadc->map, pm886_gpadc_regs[chan], &buf, sizeof(buf));
+	return !ret ? be16_to_cpu(buf) >> 4 : ret;
+}
+
+static int
+gpadc_set_bias(struct pm886_gpadc *gpadc, enum pm886_gpadc_channel chan, bool on)
+{
+	unsigned int gpadc_num = chan - GPADC0_CHAN;
+	unsigned int bits = BIT(gpadc_num + 4) | BIT(gpadc_num);
+
+	return regmap_assign_bits(gpadc->map, PM886_REG_GPADC_CONFIG(0x14), bits, on);
+}
+
+static int
+gpadc_find_bias_current(struct iio_dev *iio, struct iio_chan_spec const *chan,
+			unsigned int *raw_uv, unsigned int *raw_ua)
+{
+	struct pm886_gpadc *gpadc = iio_priv(iio);
+	unsigned int gpadc_num = chan->channel - GPADC0_CHAN;
+	unsigned int reg = PM886_REG_GPADC_CONFIG(0xb + gpadc_num);
+	unsigned long lsb = chan->address;
+	int ret;
+
+	for (unsigned int i = 0; i < PM886_GPADC_BIAS_LEVELS; i++) {
+		ret = regmap_update_bits(gpadc->map, reg, GENMASK(3, 0), i);
+		if (ret)
+			return ret;
+
+		fsleep(5000);
+
+		*raw_ua = PM886_GPADC_INDEX_TO_BIAS_UA(i);
+		*raw_uv = gpadc_get_raw(iio, chan->channel) * lsb;
+
+		/*
+		 * Vendor kernel errors out above 1.25V, but testing shows that
+		 * the resistance of the battery detection channel (GPADC2 on
+		 * coreprimevelte) reaches about 1.4Mohm when the battery is
+		 * removed, which can't be measured with such a low upper
+		 * limit. Therefore, to be able to detect the battery without
+		 * ugly externs as used in the vendor fuelgauge driver,
+		 * increase this limit a bit.
+		 */
+		if (WARN_ON(*raw_uv > 1500 * (MICRO / MILLI)))
+			return -EIO;
+
+		/*
+		 * Vendor kernel errors out under 300mV, but for the same
+		 * reason as above (except the channel hovers around 3.5kohm
+		 * with battery present) reduce this limit.
+		 */
+		if (*raw_uv < 200 * (MICRO / MILLI)) {
+			dev_dbg(&iio->dev, "bad bias for chan %d: %duA @ %duV\n", chan->channel,
+				*raw_ua, *raw_uv);
+			continue;
+		}
+
+		dev_dbg(&iio->dev, "good bias for chan %d: %duA @ %duV\n", chan->channel,
+			*raw_ua, *raw_uv);
+		return 0;
+	}
+
+	dev_err(&iio->dev, "failed to find good bias for chan %d\n", chan->channel);
+	return -EINVAL;
+}
+
+static int
+gpadc_get_resistance_ohm(struct iio_dev *iio, struct iio_chan_spec const *chan)
+{
+	struct pm886_gpadc *gpadc = iio_priv(iio);
+	unsigned int raw_uv, raw_ua;
+	int ret;
+
+	ret = gpadc_set_bias(gpadc, chan->channel, true);
+	if (ret)
+		goto err;
+
+	ret = gpadc_find_bias_current(iio, chan, &raw_uv, &raw_ua);
+	if (ret)
+		goto err;
+
+	ret = gpadc_set_bias(gpadc, chan->channel, false);
+	if (ret)
+		return ret;
+
+	return DIV_ROUND_CLOSEST(raw_uv, raw_ua);
+err:
+	gpadc_set_bias(gpadc, chan->channel, false);
+	return ret;
+}
+
+static int
+__pm886_gpadc_read_raw(struct iio_dev *iio, struct iio_chan_spec const *chan,
+		       int *val, int *val2, long mask)
+{
+	unsigned long lsb = chan->address;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*val = gpadc_get_raw(iio, chan->channel);
+		if (*val < 0)
+			return *val;
+
+		dev_dbg(&iio->dev, "chan: %d, raw: %d\n", chan->channel, *val);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = lsb;
+		*val2 = (MICRO / MILLI);
+		return chan->type == IIO_VOLTAGE
+		       ? IIO_VAL_FRACTIONAL
+		       : IIO_VAL_INT;
+	case IIO_CHAN_INFO_OFFSET:
+		/* Raw value is 104 millikelvin/LSB, convert it to 104 millicelsius/LSB */
+		*val = ABSOLUTE_ZERO_MILLICELSIUS;
+		*val2 = lsb;
+		return IIO_VAL_FRACTIONAL;
+	case IIO_CHAN_INFO_PROCESSED:
+		*val = gpadc_get_resistance_ohm(iio, chan);
+		if (*val < 0)
+			return *val;
+
+		dev_dbg(&iio->dev, "chan: %d, %d Ohm\n", chan->channel, *val);
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int pm886_gpadc_read_raw(struct iio_dev *iio, struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct device *dev = iio->dev.parent;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	ret = __pm886_gpadc_read_raw(iio, chan, val, val2, mask);
+
+	pm_runtime_put_autosuspend(dev);
+	return ret;
+}
+
+static int pm886_gpadc_setup(struct regmap *map, bool enable)
+{
+	const u8 config[] = {
+		PM886_GPADC_CONFIG1_EN_ALL,
+		PM886_GPADC_CONFIG2_EN_ALL,
+		PM886_GPADC_GND_DET2_EN
+	};
+	int ret;
+
+	/* Enable/disable the ADC block */
+	ret = regmap_assign_bits(map, PM886_REG_GPADC_CONFIG(0x6), BIT(0), enable);
+	if (ret)
+		return ret;
+
+	if (!enable)
+		return 0;
+
+	/* If enabling, enable all channels */
+	return regmap_bulk_write(map, PM886_REG_GPADC_CONFIG(0x1), config, ARRAY_SIZE(config));
+}
+
+static const struct iio_info pm886_gpadc_iio_info = {
+	.read_raw = pm886_gpadc_read_raw,
+};
+
+static int pm886_gpadc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pm886_chip *chip = dev_get_drvdata(dev->parent);
+	struct i2c_client *client = chip->client;
+	struct pm886_gpadc *gpadc;
+	struct i2c_client *page;
+	struct iio_dev *iio;
+	int ret;
+
+	iio = devm_iio_device_alloc(dev, sizeof(*gpadc));
+	if (!iio)
+		return -ENOMEM;
+
+	gpadc = iio_priv(iio);
+	dev_set_drvdata(dev, iio);
+
+	page = devm_i2c_new_dummy_device(dev, client->adapter,
+					 client->addr + PM886_PAGE_OFFSET_GPADC);
+	if (IS_ERR(page))
+		return dev_err_probe(dev, PTR_ERR(page), "Failed to initialize GPADC page\n");
+
+	gpadc->map = devm_regmap_init_i2c(page, &pm886_gpadc_regmap_config);
+	if (IS_ERR(gpadc->map))
+		return dev_err_probe(dev, PTR_ERR(gpadc->map),
+				     "Failed to initialize GPADC regmap\n");
+
+	iio->name = "88pm886-gpadc";
+	iio->dev.of_node = dev->parent->of_node;
+	iio->modes = INDIO_DIRECT_MODE;
+	iio->info = &pm886_gpadc_iio_info;
+	iio->channels = pm886_gpadc_channels;
+	iio->num_channels = ARRAY_SIZE(pm886_gpadc_channels);
+
+	pm_runtime_set_autosuspend_delay(dev, 50);
+	pm_runtime_use_autosuspend(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
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
+	struct pm886_gpadc *gpadc = iio_priv(iio);
+
+	return pm886_gpadc_setup(gpadc->map, true);
+}
+
+static int pm886_gpadc_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *iio = dev_get_drvdata(dev);
+	struct pm886_gpadc *gpadc = iio_priv(iio);
+
+	return pm886_gpadc_setup(gpadc->map, false);
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
index 24f2572c487ea3db2abec3283ebd93357c08baab..04c8478ff707dd16ec943674ac7f01f33249acf1 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -9,6 +9,19 @@ menu "Analog to digital converters"
 config IIO_ADC_HELPER
 	tristate
 
+config 88PM886_GPADC
+	tristate "Marvell 88PM886 GPADC driver"
+	depends on MFD_88PM886_PMIC
+	default MFD_88PM886_PMIC
+	help
+	  Say Y here to enable support for the GPADC (General Purpose ADC)
+	  found on the Marvell 88PM886 PMIC. The GPADC measures various
+	  internal voltages and temperatures, including (but not limited to)
+	  system, battery and USB Vbus.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called 88pm886-gpadc.
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
index 85eca44f39ab58ba4cb9ec4216118ee9604d021f..85c3c16fb10b7ee6aafdd6e68fd9135d8009eef8 100644
--- a/include/linux/mfd/88pm886.h
+++ b/include/linux/mfd/88pm886.h
@@ -10,6 +10,7 @@
 #define PM886_IRQ_ONKEY			0
 
 #define PM886_PAGE_OFFSET_REGULATORS	1
+#define PM886_PAGE_OFFSET_GPADC		2
 
 #define PM886_REG_ID			0x00
 
@@ -67,6 +68,59 @@
 #define PM886_REG_BUCK4_VOUT		0xcf
 #define PM886_REG_BUCK5_VOUT		0xdd
 
+/* GPADC enable/disable registers */
+#define PM886_REG_GPADC_CONFIG(n)	(n)
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
+#define PM886_REG_GPADC_GND_DET1	0xa4
+#define PM886_REG_GPADC_GND_DET2	0xa6
+#define PM886_REG_GPADC_VBUS		0xa8
+#define PM886_REG_GPADC_GPADC3		0xaa
+#define PM886_REG_GPADC_MIC_DET		0xac
+#define PM886_REG_GPADC_VBAT_SLP	0xb0
+
+/* GPADC channel enable bits */
+#define PM886_GPADC_VSC_EN	BIT(0)
+#define PM886_GPADC_VBAT_EN	BIT(1)
+#define PM886_GPADC_GNDDET1_EN	BIT(3)
+#define PM886_GPADC_VBUS_EN	BIT(4)
+#define PM886_GPADC_VCHG_PWR_EN	BIT(5)
+#define PM886_GPADC_VCF_OUT_EN	BIT(6)
+#define PM886_GPADC_CONFIG1_EN_ALL (PM886_GPADC_VSC_EN | \
+				    PM886_GPADC_VBAT_EN | \
+				    PM886_GPADC_GNDDET1_EN | \
+				    PM886_GPADC_VBUS_EN | \
+				    PM886_GPADC_VCHG_PWR_EN | \
+				    PM886_GPADC_VCF_OUT_EN)
+
+#define PM886_GPADC_TINT_EN	BIT(0)
+#define PM886_GPADC_PMODE_EN	BIT(1)
+#define PM886_GPADC_GPADC0_EN	BIT(2)
+#define PM886_GPADC_GPADC1_EN	BIT(3)
+#define PM886_GPADC_GPADC2_EN	BIT(4)
+#define PM886_GPADC_GPADC3_EN	BIT(5)
+#define PM886_GPADC_MIC_DET_EN	BIT(6)
+#define PM886_GPADC_CONFIG2_EN_ALL (PM886_GPADC_TINT_EN | \
+				    PM886_GPADC_GPADC0_EN | \
+				    PM886_GPADC_GPADC1_EN | \
+				    PM886_GPADC_GPADC2_EN | \
+				    PM886_GPADC_GPADC3_EN | \
+				    PM886_GPADC_MIC_DET_EN)
+
+/* No CONFIG3_EN_ALL because this is the only bit there */
+#define PM886_GPADC_GND_DET2_EN	BIT(0)
+
+#define PM886_GPADC_BIAS_LEVELS		16
+#define PM886_GPADC_INDEX_TO_BIAS_UA(i)	(1 + (i) * 5)
+
 #define PM886_LDO_VSEL_MASK		0x0f
 #define PM886_BUCK_VSEL_MASK		0x7f
 

-- 
2.51.0


