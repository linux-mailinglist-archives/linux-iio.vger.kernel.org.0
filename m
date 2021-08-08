Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9DF3E37DF
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 03:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhHHB5y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Aug 2021 21:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhHHB5x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Aug 2021 21:57:53 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB98FC061760;
        Sat,  7 Aug 2021 18:57:33 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id kl2so7167311qvb.11;
        Sat, 07 Aug 2021 18:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KAnmaLSOpIA5R8atT5gHnvTQogZ7m/KGmpDl3XjQ8RY=;
        b=g4JGRd7v2y11EgQWE8J1MZuD7fqNbD1tnr7qPFNvYqcF1Ry6+VxMOzT93C1TX4rWtB
         joJHnzIcq/FWsohERwxmj/kVUiNpxwI7UK0nsar2VU/HXNW663FQXHaWwxr+6RuMf6rG
         JRCgkSufOznB8rB1mMhHyDGbekpxdm0Wm0rhSB2x+8LF+Nn5YftKOokB4eKL7zzdqqcq
         E5uVFRV+vouFWvSEsJX4zZ856kcmBPgfoMsOTp999aERnC39i1OrqZDq52bob7SVn5gW
         3MQe3j3ubMreG2dQli1l4m2+nG7fa2+P6/peTqA7u8lLi7qQ1Tyef3uCOhKitYTSPahO
         NilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KAnmaLSOpIA5R8atT5gHnvTQogZ7m/KGmpDl3XjQ8RY=;
        b=fhrskXNMoFcnPcBVHTcnQYz6DCMloeu48YoTGbuJsJZh8qX/SAb33Ld2o8TVNlbFxm
         ne047Yd5jzWV8CXn+9j2+mHxLGmfyKLQqKThEtVywdFrzs/Ld/k6WPQkcpQQ/mQcqyy7
         jt3E7CWUvIkOg+6l/aeRWZf4vhzpvDhglO57b1H8q4gqbtud6IDxmrmqhB4aN+w8ioIM
         i2wLzy0ec6EZePZ1LYHiujNiJJ/L33OKnKD0EEWk7s0iIRdYIxPmJO/8yG72uUoB2Ia8
         /YjbjxWfLzTzVDDrUS3ttOQe8momsTpoRC7traWK71u4E36CSxfAvFbnPP2ymefbGT82
         V8Mw==
X-Gm-Message-State: AOAM533xj3eI/rS1btEX2B3t3jG4yEV7j5/m3ACu1pBE3QGd1i603/dy
        W2fkOMYOd5sPyqeQYLW5sok=
X-Google-Smtp-Source: ABdhPJyVKjjTLC+TiAvPH9O7W2CsLPaEKdHX6vfc24T+ys40Hftvn82I8oYKsnVVKUqu5aMMfq+42A==
X-Received: by 2002:a05:6214:1e1:: with SMTP id c1mr18209630qvu.42.1628387853149;
        Sat, 07 Aug 2021 18:57:33 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id k24sm1569612qki.11.2021.08.07.18.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 18:57:32 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v5 3/5] iio: adc: ad7949: add support for internal vref
Date:   Sat,  7 Aug 2021 21:56:57 -0400
Message-Id: <20210808015659.2955443-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20210808015659.2955443-1-liambeguin@gmail.com>
References: <20210808015659.2955443-1-liambeguin@gmail.com>
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
 drivers/iio/adc/ad7949.c | 140 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 122 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 3f94ae639a44..14a7c79d637e 100644
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
@@ -78,6 +90,7 @@ struct ad7949_adc_chip {
 	struct regulator *vref;
 	struct iio_dev *indio_dev;
 	struct spi_device *spi;
+	struct ad7949_channel *channels;
 	u8 resolution;
 	u8 bits_per_word;
 	u16 cfg;
@@ -136,6 +149,7 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
 	int ret;
 	int i;
 	struct spi_message msg;
+	struct ad7949_channel *ad7949_chan = &ad7949_adc->channels[channel];
 	struct spi_transfer tx[] = {
 		{
 			.len = 2,
@@ -156,8 +170,9 @@ static int ad7949_spi_read_channel(struct ad7949_adc_chip *ad7949_adc, int *val,
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
@@ -225,6 +240,7 @@ static int ad7949_spi_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long mask)
 {
 	struct ad7949_adc_chip *ad7949_adc = iio_priv(indio_dev);
+	struct ad7949_channel *ad7949_chan = &ad7949_adc->channels[chan->channel];
 	int ret;
 
 	if (!val)
@@ -242,12 +258,26 @@ static int ad7949_spi_read_raw(struct iio_dev *indio_dev,
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
@@ -286,7 +316,7 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
 		FIELD_PREP(AD7949_CFG_BIT_INCC, AD7949_CFG_VAL_INCC_UNIPOLAR_GND) |
 		FIELD_PREP(AD7949_CFG_BIT_INX, ad7949_adc->current_channel) |
 		FIELD_PREP(AD7949_CFG_BIT_BW_FULL, 1) |
-		FIELD_PREP(AD7949_CFG_BIT_REF, AD7949_CFG_VAL_REF_EXT_BUF) |
+		FIELD_PREP(AD7949_CFG_BIT_REF, ad7949_adc->channels[0].refsel) |
 		FIELD_PREP(AD7949_CFG_BIT_SEQ, 0x0) |
 		FIELD_PREP(AD7949_CFG_BIT_RBN, 1);
 
@@ -302,14 +332,24 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
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
@@ -343,16 +383,82 @@ static int ad7949_spi_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	ad7949_adc->vref = devm_regulator_get(dev, "vref");
+	/* Setup external voltage ref, buffered? */
+	ad7949_adc->vref = devm_regulator_get_optional(dev, "vrefin");
 	if (IS_ERR(ad7949_adc->vref)) {
-		dev_err(dev, "fail to request regulator\n");
-		return PTR_ERR(ad7949_adc->vref);
+		ret = PTR_ERR(ad7949_adc->vref);
+		if (ret != -ENODEV)
+			return ret;
+		/* unbuffered? */
+		ad7949_adc->vref = devm_regulator_get_optional(dev, "vref");
+		if (IS_ERR(ad7949_adc->vref)) {
+			ret = PTR_ERR(ad7949_adc->vref);
+			if (ret != -ENODEV)
+				return ret;
+			/* Internal then */
+			mode = AD7949_CFG_VAL_REF_INT_4096;
+		} else {
+			mode = AD7949_CFG_VAL_REF_EXT_TEMP;
+		}
+	} else {
+		mode = AD7949_CFG_VAL_REF_EXT_TEMP_BUF;
 	}
 
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
@@ -373,7 +479,6 @@ static int ad7949_spi_probe(struct spi_device *spi)
 
 err:
 	mutex_destroy(&ad7949_adc->lock);
-	regulator_disable(ad7949_adc->vref);
 
 	return ret;
 }
@@ -385,7 +490,6 @@ static int ad7949_spi_remove(struct spi_device *spi)
 
 	iio_device_unregister(indio_dev);
 	mutex_destroy(&ad7949_adc->lock);
-	regulator_disable(ad7949_adc->vref);
 
 	return 0;
 }
-- 
2.32.0.452.g940fe202adcb

