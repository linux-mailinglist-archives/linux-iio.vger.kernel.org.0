Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0386F27E43D
	for <lists+linux-iio@lfdr.de>; Wed, 30 Sep 2020 10:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgI3Iyn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Sep 2020 04:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbgI3Iym (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Sep 2020 04:54:42 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B532C061755;
        Wed, 30 Sep 2020 01:54:42 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x123so714967pfc.7;
        Wed, 30 Sep 2020 01:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qiPbojcx0TjS38HJapNBJ2TC3es49rjrSpjTWXOUrCM=;
        b=fXXSgXFVwUjsOyP4i1iO7nEf/BPWxCXqMAIq1FzGOc/R2uKmkbcqAn8K3KZnmVdDvc
         ZT5NZIuoGoG3adq1srbMl4iMhKt2FJrFtfDbAcGPVpHL7BMPaJizeNW2bilw5MrNIEfl
         8qbujvj9EzseG7eBE2+V2j0sYma6NWpFjEgn4dLozyqxhkrypM4tgren4VAyxWACWL00
         qmkb0HOgeWrakNfs7o9YsOSsmUY7o8N4ZLf+q1V1OYVuWkDe8XIP9IhH4Y2PTiqjVzyt
         m0aJ7Sg7KDYMJ/ddCiirJ0MPbbDlZ0Sglt2n/NBc1DLH98o1xfuDB0T/5EDUriiCKzJp
         XYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qiPbojcx0TjS38HJapNBJ2TC3es49rjrSpjTWXOUrCM=;
        b=QHp6m02qMYPBNGKVPcGLLV9NSjCHyhUTPRMwE2WChrewK5qc1YkwAcA41c9L/j539L
         rbiQKDWVEMWSEHtK/y/vru2vgH5pXrK/JDea7jCyqKmd/GPbr77J+UAznA+WMRI49knK
         AsMx+BVKhr0kT+yYK0WkC2fgA3iS8N/gK2TiIwZ+VXZKLgnOLivbenxXvB3GvWFdciA3
         kiacqoBuGI6PNGp3NbLWkq4o+ETqEeALlwTKJSRq5kJ26KbOSzUsJ+Tv4RzD03CbcHC0
         JQzGBJRGM1JxXqu+tqf9SwlAhKWf6E4AQE/W2HEqDStvuU79hbX5IXK7j0KNzItcyqGg
         HXcA==
X-Gm-Message-State: AOAM533o4PGRILXDgsLdtlrwQdbkhimjLjR7wUbQTNmHBlaLaCy3kyOs
        o5uXdWkqe/GbgXKLPyIjdMY=
X-Google-Smtp-Source: ABdhPJx136A36VgY17hzSZhSQSRaYBuxXeC1Lb9HyAp6fxE/UvxYujAPjILi3/9gCBrsuxImxzhiwQ==
X-Received: by 2002:a62:1dcb:0:b029:13e:d13d:a131 with SMTP id d194-20020a621dcb0000b029013ed13da131mr1669219pfd.25.1601456081361;
        Wed, 30 Sep 2020 01:54:41 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:56b:d17:8c76:3dc4:5429:d7e4])
        by smtp.gmail.com with ESMTPSA id x13sm1513938pff.152.2020.09.30.01.54.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Sep 2020 01:54:40 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org, matthias.bgg@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: [PATCH v6 3/3] iio: adc: mt6360: Add ADC driver for MT6360
Date:   Thu,  1 Oct 2020 16:54:08 +0800
Message-Id: <1601542448-7433-4-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601542448-7433-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1601542448-7433-1-git-send-email-gene.chen.richtek@gmail.com>
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
 drivers/iio/adc/mt6360-adc.c | 362 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 374 insertions(+)
 create mode 100644 drivers/iio/adc/mt6360-adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index d94dc80..a135ada 100644
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
index 0000000..092dcd8
--- /dev/null
+++ b/drivers/iio/adc/mt6360-adc.c
@@ -0,0 +1,362 @@
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
+	/* Due to only one set of ADC control, this lock is used to prevent the race condition */
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
+	ret = regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG, &adc_enable, sizeof(adc_enable));
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
+	*val = rpt[1] << 8 | rpt[2];
+	ret = IIO_VAL_INT;
+
+out_adc_conv:
+	/* Only keep ADC enable */
+	adc_enable = cpu_to_be16(MT6360_ADCEN_MASK);
+	regmap_raw_write(mad->regmap, MT6360_REG_PMUADCCFG, &adc_enable, sizeof(adc_enable));
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
+	case MT6360_CHAN_VSYS:
+	case MT6360_CHAN_VBAT:
+	case MT6360_CHAN_CHG_VDDP:
+	case MT6360_CHAN_VREF_TS:
+	case MT6360_CHAN_TS:
+		*val = 1250;
+		return IIO_VAL_INT;
+	case MT6360_CHAN_VBUSDIV5:
+		*val = 6250;
+		return IIO_VAL_INT;
+	case MT6360_CHAN_VBUSDIV2:
+	case MT6360_CHAN_IBUS:
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
+static const char *mt6360_channel_labels[MT6360_CHAN_MAX] = {
+	"usbid", "vbusdiv5", "vbusdiv2", "vsys", "vbat", "ibus", "ibat", "chg_vddp", "temp_jc",
+	"vref_ts", "ts"
+};
+
+static int mt6360_adc_read_label(struct iio_dev *iio_dev, const struct iio_chan_spec *chan,
+				 char *label)
+{
+	return snprintf(label, PAGE_SIZE, "%s\n", mt6360_channel_labels[chan->channel]);
+}
+
+static const struct iio_info mt6360_adc_iio_info = {
+	.read_raw = mt6360_adc_read_raw,
+	.read_label = mt6360_adc_read_label,
+};
+
+#define MT6360_ADC_CHAN(_idx, _type) {				\
+	.type = _type,						\
+	.channel = MT6360_CHAN_##_idx,				\
+	.scan_index = MT6360_CHAN_##_idx,			\
+	.datasheet_name = #_idx,				\
+	.scan_type =  {						\
+		.sign = 'u',					\
+		.realbits = 16,					\
+		.storagebits = 16,				\
+		.endianness = IIO_CPU,				\
+	},							\
+	.indexed = 1,						\
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
+	} data __aligned(8);
+	int i = 0, bit, val, ret;
+
+	memset(&data, 0, sizeof(data));
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
+	ret = regmap_raw_write(info->regmap, MT6360_REG_PMUADCCFG, &adc_enable, sizeof(adc_enable));
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

