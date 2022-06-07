Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82A5538EEA
	for <lists+linux-iio@lfdr.de>; Tue, 31 May 2022 12:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245732AbiEaK3v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 May 2022 06:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240566AbiEaK3u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 May 2022 06:29:50 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F41299822;
        Tue, 31 May 2022 03:29:49 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m14-20020a17090a414e00b001df77d29587so2189876pjg.2;
        Tue, 31 May 2022 03:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SkB25f3Zqc7wiMdR8YRJzsTcyth+4OQXoMwAgvK1QoA=;
        b=WaZkqw/nAE0btfMkw5k3uEASutkitZDpjyRZtRR+DynB3G+o+yWrWBW6xJFhMG1UZo
         tDh9p5viNQpKLRuxqsgSGnStKUmoFrlye4bmAa7YefdYjjmenqPkQe8QQdwtwUcce9P2
         Hsf+AVNAY6QR2iNFRZOQSxNmYZBBQ8EfBnenX+EeI1sZ9c/hELvDKUOWW0fhAq4GXEJ3
         Ue67IkuVuNAlb8goTGteaTlKyKSqogGa7DNtVQftkKV5X/qFXq7H/M2eHeFIS7iDU09g
         MNb7MyJeu/Tkjt8qCxmbg6V8Z8D5CCzRsEj7m8EOnsMbymSSW41Gmzzgh8JbibcVEyFX
         8KpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SkB25f3Zqc7wiMdR8YRJzsTcyth+4OQXoMwAgvK1QoA=;
        b=pyFwsI2MdVYimaU25sy7vrIKmG8Ip7KY015RffmVla90PexFzrNOTBIbb7vVoQvGEZ
         piO9O7be/ScZHWq7UQoMIEjszGUrWDbmulc/6TgNZ7Wp3G/Pq04wzsClwVF2Vj4l5uMw
         GDfZyerHcqCXz3yKElxCNMQnYxFsLHDgNuY4I27LcauXgGTZjm1Ha1jSHC49JvuJ3+wB
         1j3z4dokkgGRgOsgI6fQp1mrilwZzMcwwZorxQVcoyKsvupnmeRnNQppI8l0cMiiTriM
         JeEhZcioHBttpd0wEYck4dFTj/4lz9SSnr3M8I2RTeQw1qJ5mZyXLrYcWeKXlzHP3p01
         QQNg==
X-Gm-Message-State: AOAM531DfxtionkcnjNaBr5PdeJEXl1ReLF6V3qP62bF5stxEAdUMHHP
        pTVJEHiBJHJRIWBihtnCYMo=
X-Google-Smtp-Source: ABdhPJzxNeCb7FAuinaV1iwx5abtVAnOKPGuzTJDEo6Rosg3S5MXFzK5UduScyddMaXRXxyUZJwz/g==
X-Received: by 2002:a17:902:6505:b0:163:b040:829b with SMTP id b5-20020a170902650500b00163b040829bmr15948554plk.173.1653992988766;
        Tue, 31 May 2022 03:29:48 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-220-172.emome-ip.hinet.net. [42.72.220.172])
        by smtp.gmail.com with ESMTPSA id c1-20020a63d501000000b003c14af50631sm10216519pgg.73.2022.05.31.03.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:29:48 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     cy_huang@richtek.com, alice_chen@richtek.com,
        chiaen_wu@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 04/14] iio: adc: mt6370: Add Mediatek MT6370 support
Date:   Tue, 31 May 2022 18:27:59 +0800
Message-Id: <20220531102809.11976-5-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220531102809.11976-1-peterwu.pub@gmail.com>
References: <20220531102809.11976-1-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: ChiaEn Wu <chiaen_wu@richtek.com>

Add Mediatek MT6370 ADC support.

Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 drivers/iio/adc/Kconfig      |   9 ++
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/mt6370-adc.c | 257 +++++++++++++++++++++++++++++++++++
 3 files changed, 267 insertions(+)
 create mode 100644 drivers/iio/adc/mt6370-adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 71ab0a06aa82..d7932dd9b773 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -737,6 +737,15 @@ config MEDIATEK_MT6360_ADC
 	  is used in smartphones and tablets and supports a 11 channel
 	  general purpose ADC.
 
+config MEDIATEK_MT6370_ADC
+	tristate "Mediatek MT6370 ADC driver"
+	depends on MFD_MT6370
+	help
+	  Say Y here to enable MT6370 ADC support.
+	  Integrated for System Monitoring includes
+	  is used in smartphones and tablets and supports a 9 channel
+	  general purpose ADC.
+
 config MEDIATEK_MT6577_AUXADC
 	tristate "MediaTek AUXADC driver"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 39d806f6d457..0ce285c7e2d0 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_MCP320X) += mcp320x.o
 obj-$(CONFIG_MCP3422) += mcp3422.o
 obj-$(CONFIG_MCP3911) += mcp3911.o
 obj-$(CONFIG_MEDIATEK_MT6360_ADC) += mt6360-adc.o
+obj-$(CONFIG_MEDIATEK_MT6370_ADC) += mt6370-adc.o
 obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
 obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
 obj-$(CONFIG_MESON_SARADC) += meson_saradc.o
diff --git a/drivers/iio/adc/mt6370-adc.c b/drivers/iio/adc/mt6370-adc.c
new file mode 100644
index 000000000000..3320ebca17ad
--- /dev/null
+++ b/drivers/iio/adc/mt6370-adc.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/iio/adc/mediatek,mt6370_adc.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/iio/iio.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#define MT6370_REG_CHG_CTRL3		0x113 /* AICR */
+#define MT6370_REG_CHG_CTRL7		0x117 /* ICHG */
+#define MT6370_REG_CHG_ADC		0x121
+#define MT6370_REG_ADC_DATA_H		0x14C
+
+#define MT6370_ADC_START_MASK		BIT(0)
+#define MT6370_ADC_IN_SEL_MASK		GENMASK(7, 4)
+#define MT6370_AICR_ICHG_MASK		GENMASK(7, 2)
+
+#define MT6370_ADC_CHAN_SHIFT		4
+
+#define MT6370_AICR_400MA		0x6
+#define MT6370_ICHG_500MA		0x4
+#define MT6370_ICHG_900MA		0x8
+
+#define ADC_CONV_TIME_US		35000
+#define ADC_CONV_POLLING_TIME		1000
+
+struct mt6370_adc_data {
+	struct device *dev;
+	struct regmap *regmap;
+	struct mutex lock;
+};
+
+static int mt6370_adc_read_channel(struct mt6370_adc_data *priv, int chan,
+				   unsigned long addr, int *val)
+{
+	__be16 be_val;
+	unsigned int reg_val;
+	int ret;
+
+	mutex_lock(&priv->lock);
+
+	reg_val = MT6370_ADC_START_MASK | (addr << MT6370_ADC_CHAN_SHIFT);
+	ret = regmap_write(priv->regmap, MT6370_REG_CHG_ADC, reg_val);
+	if (ret)
+		goto adc_unlock;
+
+	msleep(ADC_CONV_TIME_US / 1000);
+
+	ret = regmap_read_poll_timeout(priv->regmap,
+				       MT6370_REG_CHG_ADC, reg_val,
+				       !(reg_val & MT6370_ADC_START_MASK),
+				       ADC_CONV_POLLING_TIME,
+				       ADC_CONV_TIME_US * 3);
+	if (ret) {
+		if (ret == -ETIMEDOUT)
+			dev_err(priv->dev, "Failed to wait adc conversion\n");
+		goto adc_unlock;
+	}
+
+	ret = regmap_raw_read(priv->regmap, MT6370_REG_ADC_DATA_H,
+			      &be_val, sizeof(be_val));
+	if (ret)
+		goto adc_unlock;
+
+	*val = be16_to_cpu(be_val);
+	ret = IIO_VAL_INT;
+
+adc_unlock:
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
+static int mt6370_adc_read_scale(struct mt6370_adc_data *priv,
+				 int chan, int *val1, int *val2)
+{
+	unsigned int reg_val;
+	int ret;
+
+	switch (chan) {
+	case MT6370_CHAN_VBAT:
+	case MT6370_CHAN_VSYS:
+	case MT6370_CHAN_CHG_VDDP:
+		*val1 = 5000;
+		return IIO_VAL_INT;
+	case MT6370_CHAN_IBUS:
+		ret = regmap_read(priv->regmap, MT6370_REG_CHG_CTRL3, &reg_val);
+		if (ret)
+			return ret;
+
+		reg_val = FIELD_GET(MT6370_AICR_ICHG_MASK, reg_val);
+		if (reg_val < MT6370_AICR_400MA)
+			*val1 = 33500;
+		else
+			*val1 = 50000;
+
+		return IIO_VAL_INT;
+	case MT6370_CHAN_IBAT:
+		ret = regmap_read(priv->regmap, MT6370_REG_CHG_CTRL7, &reg_val);
+		if (ret)
+			return ret;
+
+		reg_val = FIELD_GET(MT6370_AICR_ICHG_MASK, reg_val);
+		if (reg_val < MT6370_ICHG_500MA)
+			*val1 = 23750;
+		else if (reg_val >= MT6370_ICHG_500MA &&
+			 reg_val < MT6370_ICHG_900MA)
+			*val1 = 26800;
+		else
+			*val1 = 50000;
+
+		return IIO_VAL_INT;
+	case MT6370_CHAN_VBUSDIV5:
+		*val1 = 25000;
+		return IIO_VAL_INT;
+	case MT6370_CHAN_VBUSDIV2:
+		*val1 = 50000;
+		return IIO_VAL_INT;
+	case MT6370_CHAN_TS_BAT:
+		*val1 = 25;
+		*val2 = 10000;
+		return IIO_VAL_FRACTIONAL;
+	case MT6370_CHAN_TEMP_JC:
+		*val1 = 2;
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int mt6370_adc_read_offset(struct mt6370_adc_data *priv,
+				  int chan, int *val)
+{
+	*val = (chan == MT6370_CHAN_TEMP_JC) ? -20 : 0;
+	return IIO_VAL_INT;
+}
+
+static int mt6370_adc_read_raw(struct iio_dev *iio_dev,
+			       const struct iio_chan_spec *chan,
+			       int *val, int *val2, long mask)
+{
+	struct mt6370_adc_data *priv = iio_priv(iio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return mt6370_adc_read_channel(priv, chan->channel,
+					       chan->address, val);
+	case IIO_CHAN_INFO_SCALE:
+		return mt6370_adc_read_scale(priv, chan->channel, val, val2);
+	case IIO_CHAN_INFO_OFFSET:
+		return mt6370_adc_read_offset(priv, chan->channel, val);
+	}
+
+	return -EINVAL;
+}
+
+static const char * const mt6370_channel_labels[MT6370_CHAN_MAX] = {
+	"vbusdiv5", "vbusdiv2", "vsys", "vbat",
+	"ts_bat", "ibus", "ibat", "chg_vddp",
+	"temp_jc",
+};
+
+static int mt6370_adc_read_label(struct iio_dev *iio_dev,
+				 struct iio_chan_spec const *chan, char *label)
+{
+	return snprintf(label, PAGE_SIZE, "%s\n",
+			mt6370_channel_labels[chan->channel]);
+}
+
+static const struct iio_info mt6370_adc_iio_info = {
+	.read_raw = mt6370_adc_read_raw,
+	.read_label = mt6370_adc_read_label,
+};
+
+#define MT6370_ADC_CHAN(_idx, _type, _addr) {			\
+	.type = _type,						\
+	.channel = MT6370_CHAN_##_idx,				\
+	.address = _addr,					\
+	.scan_index = MT6370_CHAN_##_idx,			\
+	.indexed = 1,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE) |	\
+			      BIT(IIO_CHAN_INFO_OFFSET),	\
+}
+
+static const struct iio_chan_spec mt6370_adc_channels[] = {
+	MT6370_ADC_CHAN(VBUSDIV5, IIO_VOLTAGE, 1),
+	MT6370_ADC_CHAN(VBUSDIV2, IIO_VOLTAGE, 2),
+	MT6370_ADC_CHAN(VSYS, IIO_VOLTAGE, 3),
+	MT6370_ADC_CHAN(VBAT, IIO_VOLTAGE, 4),
+	MT6370_ADC_CHAN(TS_BAT, IIO_VOLTAGE, 6),
+	MT6370_ADC_CHAN(IBUS, IIO_CURRENT, 8),
+	MT6370_ADC_CHAN(IBAT, IIO_CURRENT, 9),
+	MT6370_ADC_CHAN(CHG_VDDP, IIO_VOLTAGE, 11),
+	MT6370_ADC_CHAN(TEMP_JC, IIO_TEMP, 12),
+};
+
+static int mt6370_adc_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct mt6370_adc_data *priv;
+	struct regmap *regmap;
+	struct iio_dev *indio_dev;
+
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap) {
+		dev_err(&pdev->dev, "Failed to get regmap\n");
+		return -ENODEV;
+	}
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	priv = iio_priv(indio_dev);
+	priv->dev = &pdev->dev;
+	priv->regmap = regmap;
+	mutex_init(&priv->lock);
+
+	ret = regmap_write(priv->regmap, MT6370_REG_CHG_ADC, 0);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to reset adc\n");
+		return ret;
+	}
+
+	indio_dev->name = dev_name(&pdev->dev);
+	indio_dev->info = &mt6370_adc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = mt6370_adc_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mt6370_adc_channels);
+
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+}
+
+static const struct of_device_id mt6370_adc_of_id[] = {
+	{ .compatible = "mediatek,mt6370-adc", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mt6370_adc_of_id);
+
+static struct platform_driver mt6370_adc_driver = {
+	.driver = {
+		.name = "mt6370-adc",
+		.of_match_table = mt6370_adc_of_id,
+	},
+	.probe = mt6370_adc_probe,
+};
+module_platform_driver(mt6370_adc_driver);
+
+MODULE_AUTHOR("ChiaEn Wu <chiaen_wu@richtek.com>");
+MODULE_DESCRIPTION("MT6370 ADC Drvier");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

