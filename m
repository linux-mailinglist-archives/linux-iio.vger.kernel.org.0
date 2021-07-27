Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395853D83FD
	for <lists+linux-iio@lfdr.de>; Wed, 28 Jul 2021 01:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhG0X32 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Jul 2021 19:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbhG0X3Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jul 2021 19:29:25 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1355AC061765;
        Tue, 27 Jul 2021 16:29:25 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id k7so453692qki.11;
        Tue, 27 Jul 2021 16:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FSgaKBtEbUil0nqgPknIVkWqv8lxcnefPu7nUiuVvbk=;
        b=XLNoVt3ASk7T7Fk3tR000zRe3t5E+DzhV/LxN2CAbtXyEdSkp9nUCjXbLtyi6dWc2Y
         lTmTzmOazHXabvjabWrSw084ZfSnWvFRt6/NeytEGD4C6jIfKZ2i0UrKvDkvbCHysSuB
         gFXbwdQT47ivmZhzVNcEdtvE4ooq6pg9ERIVJvlsmgo8NoO9a2ZxXdwMx+PAtWmJhMiP
         1uRdEZgBpJlTogpzn5Xe8PSTyEbpAg5U7liO9DRpQif8xeckG7ANZe6C7v4p3nYbpXlS
         /P17SipCHovHxbn/f/P4KoxpGL8YBzeXC/YNO+2lOXBR/xBIBjQH1dxP6V9O35E/Ibt3
         cK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FSgaKBtEbUil0nqgPknIVkWqv8lxcnefPu7nUiuVvbk=;
        b=NX0/wS+HBGbMC9zvUsgYDtsIo6Iwlmm3MKeCdLya5UigcKxosjULINJ78K2wGSatQV
         M4ArwgtOM6AtxYR1V2w8jtI3QWmfCEvhak8s7Hlsm8XdvJ60sPQTTf9FRITJAW0KWoKk
         +9TWZnaIwruVA3ml3F9ikxGZViyf2q0C6fbC7cAbbNN4uvr+ZuAjT7FfxNK5uQz9a3gn
         0X3At4Aj/cbtomaZizOB5/M5vo5ln+gCuLAjNQEv7OJLSsocSQVVECnZkkxAD+30BA4U
         NQe7omIuT1G0GnRgbAP9KpOazrvvMl7AGVPqG+xdm/bP+5hD87FI/JPr4FpRnv7cfwGi
         IAyg==
X-Gm-Message-State: AOAM530zPYEeAlCayhQdP1WaF6Dh6HQieY/z1cwKn7ls0ha6xtHrzquu
        b4jr5vojoIAXagECA7g6pVA=
X-Google-Smtp-Source: ABdhPJxRMSNCBX4iZ6KDfPFteKVGp/SsYrelap2aBTVm9rKdiRM7tUFJGe0QHAIrd+dtXhDxKIX1Cg==
X-Received: by 2002:a05:620a:13c8:: with SMTP id g8mr24868815qkl.342.1627428564288;
        Tue, 27 Jul 2021 16:29:24 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id p188sm2380514qka.114.2021.07.27.16.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 16:29:23 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v4 3/5] iio: adc: ad7949: add support for internal vref
Date:   Tue, 27 Jul 2021 19:29:04 -0400
Message-Id: <20210727232906.980769-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210727232906.980769-1-liambeguin@gmail.com>
References: <20210727232906.980769-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Add support for selecting a custom reference voltage from the
devicetree. If an external source is used, a vref regulator should be
defined in the devicetree.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/adc/ad7949.c | 132 +++++++++++++++++++++++++++++++++------
 1 file changed, 114 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index f1702c54c8be..eaea8f5e87d8 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -35,7 +35,11 @@
 
 /* REF: reference/buffer selection */
 #define AD7949_CFG_BIT_REF		GENMASK(5, 3)
-#define AD7949_CFG_VAL_REF_EXT_BUF		7
+#define AD7949_CFG_VAL_REF_EXT_TEMP_BUF		3
+#define AD7949_CFG_VAL_REF_EXT_TEMP		2
+#define AD7949_CFG_VAL_REF_INT_4096		1
+#define AD7949_CFG_VAL_REF_INT_2500		0
+#define AD7949_CFG_VAL_REF_EXTERNAL		BIT(1)
 
 /* SEQ: channel sequencer. Allows for scanning channels */
 #define AD7949_CFG_BIT_SEQ		GENMASK(2, 1)
@@ -60,6 +64,14 @@ static const struct ad7949_adc_spec ad7949_adc_spec[] = {
 	[ID_AD7689] = { .num_channels = 8, .resolution = 16 },
 };
 
+/**
+ * struct ad7949_channel - ADC Channel parameters
+ * @refsel: reference selection
+ */
+struct ad7949_channel {
+	u32 refsel;
+};
+
 /**
  * struct ad7949_adc_chip - AD ADC chip
  * @lock: protects write sequences
@@ -77,6 +89,7 @@ struct ad7949_adc_chip {
 	struct regulator *vref;
 	struct iio_dev *indio_dev;
 	struct spi_device *spi;
+	struct ad7949_channel *channels;
 	u8 resolution;
 	u8 bits_per_word;
 	u16 cfg;
@@ -133,6 +146,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 	int ret;
 	int i;
 	struct spi_message msg;
+	struct ad7949_channel *ad7949_chan = &ad7949_adc->channels[channel];
 	struct spi_transfer tx[] = {
 		{
 			.rx_buf = &ad7949_adc->buffer,
@@ -149,8 +163,9 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 	 */
 	for (i = 0; i < 2; i++) {
 		ret = ad7949_spi_write_cfg(ad7949_adc,
-					   FIELD_PREP(AD7949_CFG_BIT_INX, channel),
-					   AD7949_CFG_BIT_INX);
+					   FIELD_PREP(AD7949_CFG_BIT_INX, channel) |
+					   FIELD_PREP(AD7949_CFG_BIT_REF, ad7949_chan->refsel),
+					   AD7949_CFG_BIT_INX | AD7949_CFG_BIT_REF);
 		if (ret)
 			return ret;
 		if (channel == ad7949_adc->current_channel)
@@ -219,6 +234,7 @@ static int ad7949_spi_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long mask)
 {
 	struct ad7949_adc_chip *ad7949_adc = iio_priv(indio_dev);
+	struct ad7949_channel *ad7949_chan = &ad7949_adc->channels[chan->channel];
 	int ret;
 
 	if (!val)
@@ -236,12 +252,26 @@ static int ad7949_spi_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-		ret = regulator_get_voltage(ad7949_adc->vref);
-		if (ret < 0)
-			return ret;
+		switch (ad7949_chan->refsel) {
+		case AD7949_CFG_VAL_REF_INT_2500:
+			*val = 2500;
+			break;
+		case AD7949_CFG_VAL_REF_INT_4096:
+			*val = 4096;
+			break;
+		case AD7949_CFG_VAL_REF_EXT_TEMP:
+		case AD7949_CFG_VAL_REF_EXT_TEMP_BUF:
+			ret = regulator_get_voltage(ad7949_adc->vref);
+			if (ret < 0)
+				return ret;
+
+			/* convert value back to mV */
+			*val = ret / 1000;
+			break;
+		}
 
-		*val = ret / 5000;
-		return IIO_VAL_INT;
+		*val2 = (1 << ad7949_adc->resolution) - 1;
+		return IIO_VAL_FRACTIONAL;
 	}
 
 	return -EINVAL;
@@ -280,7 +310,7 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
 		FIELD_PREP(AD7949_CFG_BIT_INCC, AD7949_CFG_VAL_INCC_UNIPOLAR_GND) |
 		FIELD_PREP(AD7949_CFG_BIT_INX, ad7949_adc->current_channel) |
 		FIELD_PREP(AD7949_CFG_BIT_BW_FULL, 1) |
-		FIELD_PREP(AD7949_CFG_BIT_REF, AD7949_CFG_VAL_REF_EXT_BUF) |
+		FIELD_PREP(AD7949_CFG_BIT_REF, ad7949_adc->channels[0].refsel) |
 		FIELD_PREP(AD7949_CFG_BIT_SEQ, 0x0) |
 		FIELD_PREP(AD7949_CFG_BIT_RBN, 1);
 
@@ -296,14 +326,24 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
 	return ret;
 }
 
+static void ad7949_disable_reg(void *reg)
+{
+	regulator_disable(reg);
+}
+
 static int ad7949_spi_probe(struct spi_device *spi)
 {
 	u32 spi_ctrl_mask = spi->controller->bits_per_word_mask;
 	struct device *dev = &spi->dev;
 	const struct ad7949_adc_spec *spec;
 	struct ad7949_adc_chip *ad7949_adc;
+	struct ad7949_channel *ad7949_chan;
+	struct fwnode_handle *child;
 	struct iio_dev *indio_dev;
+	int mode;
+	u32 tmp;
 	int ret;
+	int i;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*ad7949_adc));
 	if (!indio_dev) {
@@ -337,16 +377,74 @@ static int ad7949_spi_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	ad7949_adc->vref = devm_regulator_get(dev, "vref");
+	/* Setup external voltage ref, buffered? */
+	ad7949_adc->vref = devm_regulator_get(dev, "vrefin");
 	if (IS_ERR(ad7949_adc->vref)) {
-		dev_err(dev, "fail to request regulator\n");
-		return PTR_ERR(ad7949_adc->vref);
+		/* unbuffered? */
+		ad7949_adc->vref = devm_regulator_get(dev, "vref");
+		if (IS_ERR(ad7949_adc->vref)) {
+			/* Internal then */
+			mode = AD7949_CFG_VAL_REF_INT_4096;
+		}
+		mode = AD7949_CFG_VAL_REF_EXT_TEMP;
 	}
+	mode = AD7949_CFG_VAL_REF_EXT_TEMP_BUF;
 
-	ret = regulator_enable(ad7949_adc->vref);
-	if (ret < 0) {
-		dev_err(dev, "fail to enable regulator\n");
-		return ret;
+	if (mode & AD7949_CFG_VAL_REF_EXTERNAL) {
+		ret = regulator_enable(ad7949_adc->vref);
+		if (ret < 0) {
+			dev_err(dev, "fail to enable regulator\n");
+			return ret;
+		}
+
+		ret = devm_add_action_or_reset(dev, ad7949_disable_reg,
+					       ad7949_adc->vref);
+		if (ret)
+			return ret;
+	}
+
+	ad7949_adc->channels = devm_kcalloc(dev, spec->num_channels,
+					    sizeof(*ad7949_adc->channels),
+					    GFP_KERNEL);
+	if (!ad7949_adc->channels) {
+		dev_err(dev, "unable to allocate ADC channels\n");
+		return -ENOMEM;
+	}
+
+	/* Initialize all channel structures */
+	for (i = 0; i < spec->num_channels; i++)
+		ad7949_adc->channels[i].refsel = mode;
+
+	/* Read channel specific information form the devicetree */
+	device_for_each_child_node(dev, child) {
+		ret = fwnode_property_read_u32(child, "reg", &i);
+		if (ret) {
+			dev_err(dev, "missing reg property in %pfw\n", child);
+			fwnode_handle_put(child);
+			return ret;
+		}
+
+		ad7949_chan = &ad7949_adc->channels[i];
+
+		ret = fwnode_property_read_u32(child, "adi,internal-ref-microvolt", &tmp);
+		if (ret < 0 && ret != -EINVAL) {
+			dev_err(dev, "invalid internal reference in %pfw\n", child);
+			fwnode_handle_put(child);
+			return ret;
+		}
+
+		switch (tmp) {
+		case 2500000:
+			ad7949_chan->refsel = AD7949_CFG_VAL_REF_INT_2500;
+			break;
+		case 4096000:
+			ad7949_chan->refsel = AD7949_CFG_VAL_REF_INT_4096;
+			break;
+		default:
+			dev_err(dev, "unsupported internal voltage reference\n");
+			fwnode_handle_put(child);
+			return -EINVAL;
+		}
 	}
 
 	mutex_init(&ad7949_adc->lock);
@@ -367,7 +465,6 @@ static int ad7949_spi_probe(struct spi_device *spi)
 
 err:
 	mutex_destroy(&ad7949_adc->lock);
-	regulator_disable(ad7949_adc->vref);
 
 	return ret;
 }
@@ -379,7 +476,6 @@ static int ad7949_spi_remove(struct spi_device *spi)
 
 	iio_device_unregister(indio_dev);
 	mutex_destroy(&ad7949_adc->lock);
-	regulator_disable(ad7949_adc->vref);
 
 	return 0;
 }
-- 
2.30.1.489.g328c10930387

