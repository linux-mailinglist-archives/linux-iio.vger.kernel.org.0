Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCE23ECB6C
	for <lists+linux-iio@lfdr.de>; Sun, 15 Aug 2021 23:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhHOVfM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Aug 2021 17:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbhHOVfK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Aug 2021 17:35:10 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19262C0612AD;
        Sun, 15 Aug 2021 14:33:56 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id r21so4836549qtw.11;
        Sun, 15 Aug 2021 14:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AvJsB1BkWZx9lTAEPjdxbCIvMQFklGOpCGlQcz/H3is=;
        b=h+buDFz8UwV9gLQcWkGJMxpI7jiKb/AYbi6I+JdZ9PsR2wvN6CGSvW1psN6MuQMxKn
         qOaCU/aW1U1Jv7xPcTbIE1x4hWsOoxKXGvPgeTM6+sojJIQZGmOPOQTbVbD3Nq4c8bTW
         ya8hSeSi6yhVd3bRU3ZDxQdAfGTkPArvtf5nJ/63F5/veiRSD6hcbZl4cwUusD2y9Rwm
         shouYmUG8R5gzZfpnShqQK73o6GXnfQx8nobgCIpo06XK3VXQFayUAiL5ReTjn/wTZZd
         qds4PUVrqLLX+76Q6O4htujDwTd0hC4phvPcCYR9gFMs1WPDgLif9sVOLQQBAxBFP3ZT
         GMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AvJsB1BkWZx9lTAEPjdxbCIvMQFklGOpCGlQcz/H3is=;
        b=ZEPyt23TCCPfJ7B5eConAJKFpdUkRXdwHvKC+koJAih8GpgSt6boGekH/X8MCcY5D0
         32X2qKPmv3SpIIU4urTUsi7XxoJ0Mr3+n9lpfz8qsqNEiml99cuyNWalTBKIGLk1LRqU
         2J6eUKXTHLKvtlyIWgyrqVh0h0VOziR9nliA/4JqklOlPpxyXuL7Zuf5I/RveBx9YGQk
         An9kU6ZdFmBusj07BBim3CKsXIP6GK2bPhFPWvfaD7PEqQ8r2Fx8dSWjgCdsG+37KyjS
         WotAWbd5/x27Mio8uWR5Re1RrQOF4vQKkWllCiou51f1+J3jQERXGTxECAjpFlJXQAhj
         QcpA==
X-Gm-Message-State: AOAM532MhAyX/cvJPL75t7+fnB3hK4z15gXSmehydxZAfp3LgbJPvCQa
        SflFpIRmUcEcD8pDxyvSgxs=
X-Google-Smtp-Source: ABdhPJz16QratxfqStXTmCsCYXjOptWzAeNqPjf1vNy2iNTysbFsjlzK9gq5vjBRdl4yCi5G2LGgOA==
X-Received: by 2002:ac8:5984:: with SMTP id e4mr11409562qte.228.1629063235277;
        Sun, 15 Aug 2021 14:33:55 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id u19sm3870988qtx.48.2021.08.15.14.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 14:33:54 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v6 3/5] iio: adc: ad7949: add vref selection support
Date:   Sun, 15 Aug 2021 17:33:07 -0400
Message-Id: <20210815213309.2847711-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20210815213309.2847711-1-liambeguin@gmail.com>
References: <20210815213309.2847711-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Add support for selecting the voltage reference from the devicetree.

This change is required to get valid readings with all three
vref hardware configurations supported by the ADC.

For instance if the ADC isn't provided with an external reference,
the sample request must specify an internal voltage reference to get a
valid reading.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/adc/ad7949.c | 96 +++++++++++++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index a263d0fcec75..5168d687687d 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -35,7 +35,11 @@
 
 /* REF: reference/buffer selection */
 #define AD7949_CFG_MASK_REF		GENMASK(5, 3)
-#define AD7949_CFG_VAL_REF_EXT_BUF		7
+#define AD7949_CFG_VAL_REF_EXT_TEMP_BUF		3
+#define AD7949_CFG_VAL_REF_EXT_TEMP		2
+#define AD7949_CFG_VAL_REF_INT_4096		1
+#define AD7949_CFG_VAL_REF_INT_2500		0
+#define AD7949_CFG_VAL_REF_EXTERNAL		BIT(1)
 
 /* SEQ: channel sequencer. Allows for scanning channels */
 #define AD7949_CFG_MASK_SEQ		GENMASK(2, 1)
@@ -66,6 +70,7 @@ static const struct ad7949_adc_spec ad7949_adc_spec[] = {
  * @vref: regulator generating Vref
  * @indio_dev: reference to iio structure
  * @spi: reference to spi structure
+ * @refsel: reference selection
  * @resolution: resolution of the chip
  * @cfg: copy of the configuration register
  * @current_channel: current channel in use
@@ -77,6 +82,7 @@ struct ad7949_adc_chip {
 	struct regulator *vref;
 	struct iio_dev *indio_dev;
 	struct spi_device *spi;
+	u32 refsel;
 	u8 resolution;
 	u16 cfg;
 	unsigned int current_channel;
@@ -221,12 +227,26 @@ static int ad7949_spi_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-		ret = regulator_get_voltage(ad7949_adc->vref);
-		if (ret < 0)
-			return ret;
+		switch (ad7949_adc->refsel) {
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
@@ -265,7 +285,7 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
 		FIELD_PREP(AD7949_CFG_MASK_INCC, AD7949_CFG_VAL_INCC_UNIPOLAR_GND) |
 		FIELD_PREP(AD7949_CFG_MASK_INX, ad7949_adc->current_channel) |
 		FIELD_PREP(AD7949_CFG_MASK_BW_FULL, 1) |
-		FIELD_PREP(AD7949_CFG_MASK_REF, AD7949_CFG_VAL_REF_EXT_BUF) |
+		FIELD_PREP(AD7949_CFG_MASK_REF, ad7949_adc->refsel) |
 		FIELD_PREP(AD7949_CFG_MASK_SEQ, 0x0) |
 		FIELD_PREP(AD7949_CFG_MASK_RBN, 1);
 
@@ -281,6 +301,11 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
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
@@ -288,6 +313,7 @@ static int ad7949_spi_probe(struct spi_device *spi)
 	const struct ad7949_adc_spec *spec;
 	struct ad7949_adc_chip *ad7949_adc;
 	struct iio_dev *indio_dev;
+	u32 tmp;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*ad7949_adc));
@@ -322,16 +348,56 @@ static int ad7949_spi_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	ad7949_adc->vref = devm_regulator_get(dev, "vref");
+	/* Setup internal voltage reference */
+	tmp = 4096000;
+	ret = device_property_read_u32(dev, "adi,internal-ref-microvolt", &tmp);
+	if (ret < 0 && ret != -EINVAL) {
+		dev_err(dev, "invalid value for adi,internal-ref-microvolt\n");
+		return ret;
+	}
+
+	switch (tmp) {
+	case 2500000:
+		ad7949_adc->refsel = AD7949_CFG_VAL_REF_INT_2500;
+		break;
+	case 4096000:
+		ad7949_adc->refsel = AD7949_CFG_VAL_REF_INT_4096;
+		break;
+	default:
+		dev_err(dev, "unsupported internal voltage reference\n");
+		return -EINVAL;
+	}
+
+	/* Setup external voltage reference, buffered? */
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
+		} else {
+			ad7949_adc->refsel = AD7949_CFG_VAL_REF_EXT_TEMP;
+		}
+	} else {
+		ad7949_adc->refsel = AD7949_CFG_VAL_REF_EXT_TEMP_BUF;
 	}
 
-	ret = regulator_enable(ad7949_adc->vref);
-	if (ret < 0) {
-		dev_err(dev, "fail to enable regulator\n");
-		return ret;
+	if (ad7949_adc->refsel & AD7949_CFG_VAL_REF_EXTERNAL) {
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
 	}
 
 	mutex_init(&ad7949_adc->lock);
@@ -352,7 +418,6 @@ static int ad7949_spi_probe(struct spi_device *spi)
 
 err:
 	mutex_destroy(&ad7949_adc->lock);
-	regulator_disable(ad7949_adc->vref);
 
 	return ret;
 }
@@ -364,7 +429,6 @@ static int ad7949_spi_remove(struct spi_device *spi)
 
 	iio_device_unregister(indio_dev);
 	mutex_destroy(&ad7949_adc->lock);
-	regulator_disable(ad7949_adc->vref);
 
 	return 0;
 }
-- 
2.32.0.452.g940fe202adcb

