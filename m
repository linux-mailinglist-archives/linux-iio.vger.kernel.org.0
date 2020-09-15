Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9258826AC41
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 20:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgIOSk2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 14:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgIORhm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 13:37:42 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A02C061354;
        Tue, 15 Sep 2020 10:36:25 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a9so161997pjg.1;
        Tue, 15 Sep 2020 10:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EZpaJy+eVZz8Zx7f1Sp6TL0BpxAimVWK2qha8KHGSW8=;
        b=KxtHn4Bp/P1iUByN/6QJJ6ViinQQKIGp4ORo5PbJX3jKLX+fC3nnQ9v/F/Idw4oSzR
         P+KGUYMB7/O63Rjz/gvVg5T3dKeB5va+/hyjlaD5TKyrBEJckC9A7+UCQAFoOIOTnX1i
         GcDVrp5G1ml1hU0W3QFO4Cl3sbxIHdFgeueFGL0JN3ItqIqUYrfPGAold+5zyTyN1oym
         s2Cr6zq/tRpLaE6PUiD3ViRS+B+uY8uBrpJAfJcEVClp1ciWxz6L01ZFMytEu10Ugu8W
         AYCUaDecnBNk8p4KLwdcSHvcX5Qbis9SIvdn9f9pr/Srqm4A8R0iqd63RJpfKU3hco4u
         E8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EZpaJy+eVZz8Zx7f1Sp6TL0BpxAimVWK2qha8KHGSW8=;
        b=SLWhcFfLPDyhZDiQI4mIDwcPjsAMAQ4jVsJsZFh4qx0DELSoV56irq7Ez3l1/DIFi6
         1ai+ED0wYVC8zQMTvMeCSJqXZsLTg7IOWYy5eEaySUO/d+jMXwnoYojRkB2PuByrNwjd
         AXlnf0Ku2fJWmKDCcLO5bK1koLeaWpuxqvcsbqt8utQjBLAYVWCKGRxP1Msa091wq8FW
         CpM62SLB2HEGvVhkIGY8N2NdbRIt4AbWsNqdE7jYzex4ECbD/u9Hj3ZukEfsPorNIzhw
         hewKXBVBxPNmWq0jUFCrvEy7OJxWgrqF+dL7xw2MVKc5LcLeFrQdOoHqnRjTG5IyDk9D
         Bf3A==
X-Gm-Message-State: AOAM531rCrpYjiyf5HeNd9E4iaZy+6jo/5EUoEuZTm6cJO1x+r0DyU2i
        vFSpCRbdlCUXLmLvLV7vHL4=
X-Google-Smtp-Source: ABdhPJxd3a/uX3P3IXohuv78T/PRNEQynLTpFMbiL2B3pRuIO59qNOJE1nrDSD0ajLqX9XugSMKapA==
X-Received: by 2002:a17:90a:77c1:: with SMTP id e1mr396084pjs.39.1600191384890;
        Tue, 15 Sep 2020 10:36:24 -0700 (PDT)
Received: from localhost.localdomain ([123.110.251.138])
        by smtp.gmail.com with ESMTPSA id x3sm14025926pfq.49.2020.09.15.10.36.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 10:36:24 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     jic23@kernel.org, matthias.bgg@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v4 3/3] iio: adc: mt6360: Add ADC driver for MT6360
Date:   Wed, 16 Sep 2020 01:36:09 +0800
Message-Id: <1600191369-28040-4-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600191369-28040-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1600191369-28040-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add MT6360 ADC driver include Charger Current, Voltage, and
Temperature.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/iio/adc/Kconfig      |  11 ++
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/mt6360-adc.c | 357 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 369 insertions(+)
 create mode 100644 drivers/iio/adc/mt6360-adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 66d9cc0..8d36b66 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -703,6 +703,17 @@ config MCP3911
 	  This driver can also be built as a module. If so, the module will be
 	  called mcp3911.
 
+config MEDIATEK_MT6360_ADC
+	tristate "Mediatek MT6360 ADC driver"
+	depends on MFD_MT6360
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say Y here to enable MT6360 ADC support.
+	  Integrated for System Monitoring includes
+	  is used in smartphones and tablets and supports a 11 channel
+	  general purpose ADC.
+
 config MEDIATEK_MT6577_AUXADC
 	tristate "MediaTek AUXADC driver"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 90f94ad..5fca90a 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_MAX9611) += max9611.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
 obj-$(CONFIG_MCP3422) += mcp3422.o
 obj-$(CONFIG_MCP3911) += mcp3911.o
+obj-$(CONFIG_MEDIATEK_MT6360_ADC) += mt6360-adc.o
 obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
 obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
 obj-$(CONFIG_MESON_SARADC) += meson_saradc.o
diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
new file mode 100644
index 0000000..b256d0a
--- /dev/null
+++ b/drivers/iio/adc/mt6360-adc.c
@@ -0,0 +1,357 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/ktime.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define MT6360_REG_PMUCHGCTRL3	0x313
+#define MT6360_REG_PMUADCCFG	0x356
+#define MT6360_REG_PMUADCIDLET	0x358
+#define MT6360_REG_PMUADCRPT1	0x35A
+
+/* PMUCHGCTRL3 0x313 */
+#define MT6360_AICR_MASK	GENMASK(7, 2)
+#define MT6360_AICR_SHFT	2
+#define MT6360_AICR_400MA	0x6
+/* PMUADCCFG 0x356 */
+#define MT6360_ADCEN_MASK	0x8000
+/* PMUADCRPT1 0x35A */
+#define MT6360_PREFERCH_MASK	GENMASK(7, 4)
+#define MT6360_PREFERCH_SHFT	4
+#define MT6360_RPTCH_MASK	GENMASK(3, 0)
+#define MT6360_NO_PREFER	15
+
+/* Time in ms */
+#define ADC_WAIT_TIME_MS	25
+
+enum {
+	MT6360_CHAN_USBID = 0,
+	MT6360_CHAN_VBUSDIV5,
+	MT6360_CHAN_VBUSDIV2,
+	MT6360_CHAN_VSYS,
+	MT6360_CHAN_VBAT,
+	MT6360_CHAN_IBUS,
+	MT6360_CHAN_IBAT,
+	MT6360_CHAN_CHG_VDDP,
+	MT6360_CHAN_TEMP_JC,
+	MT6360_CHAN_VREF_TS,
+	MT6360_CHAN_TS,
+	MT6360_CHAN_MAX
+};
+
+struct mt6360_adc_data {
+	struct device *dev;
+	struct regmap *regmap;
+	struct mutex adc_lock;
+	ktime_t last_off_timestamps[MT6360_CHAN_MAX];
+};
+
+static int mt6360_adc_read_channel(struct mt6360_adc_data *mad, int channel, int *val)
+{
+	__be16 adc_enable;
+	u8 rpt[3];
+	ktime_t start_t, predict_end_t;
+	unsigned int pre_wait_time;
+	int ret;
+
+	mutex_lock(&mad->adc_lock);
+
+	/* Select the preferred ADC channel */
+	ret = regmap_update_bits(mad->regmap, MT6360_REG_PMUADCRPT1, MT6360_PREFERCH_MASK,
+				 channel << MT6360_PREFERCH_SHFT);
+	if (ret)
+		goto out_adc_lock;
+
+	adc_enable = cpu_to_be16(MT6360_ADCEN_MASK | BIT(channel));
+	ret = regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG, (void *)&adc_enable,
+			       sizeof(__be16));
+	if (ret)
+		goto out_adc_lock;
+
+	start_t = ktime_get();
+	predict_end_t = ktime_add_ms(mad->last_off_timestamps[channel], 2 * ADC_WAIT_TIME_MS);
+
+	if (ktime_after(start_t, predict_end_t))
+		pre_wait_time = ADC_WAIT_TIME_MS;
+	else
+		pre_wait_time = 3 * ADC_WAIT_TIME_MS;
+
+	msleep(pre_wait_time);
+
+	while (true) {
+		ret = regmap_raw_read(mad->regmap, MT6360_REG_PMUADCRPT1, rpt, sizeof(rpt));
+		if (ret)
+			goto out_adc_conv;
+
+		/*
+		 * There are two functions, ZCV and TypeC OTP, running ADC VBAT and TS in
+		 * background, and ADC samples are taken on a fixed frequency no matter read the
+		 * previous one or not.
+		 * To avoid conflict, We set minimum time threshold after enable ADC and
+		 * check report channel is the same.
+		 * The worst case is run the same ADC twice and background function is also running,
+		 * ADC conversion sequence is desire channel before start ADC, background ADC,
+		 * desire channel after start ADC.
+		 * So the minimum correct data is three times of typical conversion time.
+		 */
+		if ((rpt[0] & MT6360_RPTCH_MASK) == channel)
+			break;
+
+		msleep(ADC_WAIT_TIME_MS);
+	}
+
+	/* rpt[1]: ADC_HI_BYTE, rpt[2]: ADC_LOW_BYTE */
+	*val = be16_to_cpup((__be16 *)(rpt + 1));
+	ret = IIO_VAL_INT;
+
+out_adc_conv:
+	/* Only keep ADC enable */
+	adc_enable = cpu_to_be16(MT6360_ADCEN_MASK);
+	regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG, (void *)&adc_enable, sizeof(__be16));
+	mad->last_off_timestamps[channel] = ktime_get();
+	/* Config prefer channel to NO_PREFER */
+	regmap_update_bits(mad->regmap, MT6360_REG_PMUADCRPT1, MT6360_PREFERCH_MASK,
+			   MT6360_NO_PREFER << MT6360_PREFERCH_SHFT);
+out_adc_lock:
+	mutex_unlock(&mad->adc_lock);
+
+	return ret;
+}
+
+static int mt6360_adc_read_scale(struct mt6360_adc_data *mad, int channel, int *val, int *val2)
+{
+	unsigned int regval;
+	int ret;
+
+	switch (channel) {
+	case MT6360_CHAN_USBID:
+		fallthrough;
+	case MT6360_CHAN_VSYS:
+		fallthrough;
+	case MT6360_CHAN_VBAT:
+		fallthrough;
+	case MT6360_CHAN_CHG_VDDP:
+		fallthrough;
+	case MT6360_CHAN_VREF_TS:
+		fallthrough;
+	case MT6360_CHAN_TS:
+		*val = 1250;
+		return IIO_VAL_INT;
+	case MT6360_CHAN_VBUSDIV5:
+		*val = 6250;
+		return IIO_VAL_INT;
+	case MT6360_CHAN_VBUSDIV2:
+		fallthrough;
+	case MT6360_CHAN_IBUS:
+		fallthrough;
+	case MT6360_CHAN_IBAT:
+		*val = 2500;
+
+		if (channel == MT6360_CHAN_IBUS) {
+			/* IBUS will be affected by input current limit for the different Ron */
+			/* Check whether the config is <400mA or not */
+			ret = regmap_read(mad->regmap, MT6360_REG_PMUCHGCTRL3, &regval);
+			if (ret)
+				return ret;
+
+			regval = (regval & MT6360_AICR_MASK) >> MT6360_AICR_SHFT;
+			if (regval < MT6360_AICR_400MA)
+				*val = 1900;
+		}
+
+		return IIO_VAL_INT;
+	case MT6360_CHAN_TEMP_JC:
+		*val = 105;
+		*val2 = 100;
+		return IIO_VAL_FRACTIONAL;
+	}
+
+	return -EINVAL;
+}
+
+static int mt6360_adc_read_offset(struct mt6360_adc_data *mad, int channel, int *val)
+{
+	*val = (channel == MT6360_CHAN_TEMP_JC) ? -80 : 0;
+	return IIO_VAL_INT;
+
+}
+
+static int mt6360_adc_read_raw(struct iio_dev *iio_dev, const struct iio_chan_spec *chan,
+			       int *val, int *val2, long mask)
+{
+	struct mt6360_adc_data *mad = iio_priv(iio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return mt6360_adc_read_channel(mad, chan->channel, val);
+	case IIO_CHAN_INFO_SCALE:
+		return mt6360_adc_read_scale(mad, chan->channel, val, val2);
+	case IIO_CHAN_INFO_OFFSET:
+		return mt6360_adc_read_offset(mad, chan->channel, val);
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info mt6360_adc_iio_info = {
+	.read_raw = mt6360_adc_read_raw,
+};
+
+#define MT6360_ADC_CHAN(_idx, _type) {				\
+	.type = _type,						\
+	.channel = MT6360_CHAN_##_idx,				\
+	.scan_index = MT6360_CHAN_##_idx,			\
+	.extend_name = #_idx,					\
+	.datasheet_name = #_idx,				\
+	.scan_type =  {						\
+		.sign = 'u',					\
+		.realbits = 16,					\
+		.storagebits = 16,				\
+		.endianness = IIO_CPU,				\
+	},							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+				BIT(IIO_CHAN_INFO_SCALE) |	\
+				BIT(IIO_CHAN_INFO_OFFSET),	\
+}
+
+static const struct iio_chan_spec mt6360_adc_channels[] = {
+	MT6360_ADC_CHAN(USBID, IIO_VOLTAGE),
+	MT6360_ADC_CHAN(VBUSDIV5, IIO_VOLTAGE),
+	MT6360_ADC_CHAN(VBUSDIV2, IIO_VOLTAGE),
+	MT6360_ADC_CHAN(VSYS, IIO_VOLTAGE),
+	MT6360_ADC_CHAN(VBAT, IIO_VOLTAGE),
+	MT6360_ADC_CHAN(IBUS, IIO_CURRENT),
+	MT6360_ADC_CHAN(IBAT, IIO_CURRENT),
+	MT6360_ADC_CHAN(CHG_VDDP, IIO_VOLTAGE),
+	MT6360_ADC_CHAN(TEMP_JC, IIO_TEMP),
+	MT6360_ADC_CHAN(VREF_TS, IIO_VOLTAGE),
+	MT6360_ADC_CHAN(TS, IIO_VOLTAGE),
+	IIO_CHAN_SOFT_TIMESTAMP(MT6360_CHAN_MAX),
+};
+
+static irqreturn_t mt6360_adc_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct mt6360_adc_data *mad = iio_priv(indio_dev);
+	struct {
+		u16 values[MT6360_CHAN_MAX];
+		int64_t timestamp;
+	} data;
+	int i = 0, bit, val, ret;
+
+	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength) {
+		ret = mt6360_adc_read_channel(mad, bit, &val);
+		if (ret < 0) {
+			dev_warn(&indio_dev->dev, "Failed to get channel %d conversion val\n", bit);
+			goto out;
+		}
+
+		data.values[i++] = val;
+	}
+	iio_push_to_buffers_with_timestamp(indio_dev, &data, iio_get_time_ns(indio_dev));
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static inline int mt6360_adc_reset(struct mt6360_adc_data *info)
+{
+	__be16 adc_enable;
+	ktime_t all_off_time;
+	int i, ret;
+
+	/* Clear ADC idle wait time to 0 */
+	ret = regmap_write(info->regmap, MT6360_REG_PMUADCIDLET, 0);
+	if (ret)
+		return ret;
+
+	/* Only keep ADC enable, but keep all channels off */
+	adc_enable = cpu_to_be16(MT6360_ADCEN_MASK);
+	ret = regmap_raw_write(info->regmap, MT6360_REG_PMUADCCFG, (void *)&adc_enable,
+			       sizeof(__be16));
+	if (ret)
+		return ret;
+
+	/* Reset all channel off time to the current one */
+	all_off_time = ktime_get();
+	for (i = 0; i < MT6360_CHAN_MAX; i++)
+		info->last_off_timestamps[i] = all_off_time;
+
+	return 0;
+}
+
+static int mt6360_adc_probe(struct platform_device *pdev)
+{
+	struct mt6360_adc_data *mad;
+	struct regmap *regmap;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap) {
+		dev_err(&pdev->dev, "Failed to get parent regmap\n");
+		return -ENODEV;
+	}
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*mad));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	mad = iio_priv(indio_dev);
+	mad->dev = &pdev->dev;
+	mad->regmap = regmap;
+	mutex_init(&mad->adc_lock);
+
+	ret = mt6360_adc_reset(mad);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to reset adc\n");
+		return ret;
+	}
+
+	indio_dev->name = dev_name(&pdev->dev);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->info = &mt6360_adc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = mt6360_adc_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mt6360_adc_channels);
+
+	ret = devm_iio_triggered_buffer_setup(&pdev->dev, indio_dev, NULL,
+					      mt6360_adc_trigger_handler, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to allocate iio trigger buffer\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+}
+
+static const struct of_device_id __maybe_unused mt6360_adc_of_id[] = {
+	{ .compatible = "mediatek,mt6360-adc", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mt6360_adc_of_id);
+
+static struct platform_driver mt6360_adc_driver = {
+	.driver = {
+		.name = "mt6360-adc",
+		.of_match_table = mt6360_adc_of_id,
+	},
+	.probe = mt6360_adc_probe,
+};
+module_platform_driver(mt6360_adc_driver);
+
+MODULE_AUTHOR("Gene Chen <gene_chen@richtek.com>");
+MODULE_DESCRIPTION("MT6360 ADC Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

