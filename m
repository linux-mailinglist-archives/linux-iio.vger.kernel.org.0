Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 898793C2727
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 17:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhGIQB7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 12:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbhGIQB4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jul 2021 12:01:56 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DAAC0613DD;
        Fri,  9 Jul 2021 08:59:11 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id j184so9768954qkd.6;
        Fri, 09 Jul 2021 08:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jnVWARWTCSXZft0d/rvK/it2ULZETAzN1k/HpOM9luE=;
        b=QuItFyaXIDP1Wy63yXLUUYeD3/IbdF8l98rgt0ILvQdPziBRRtyqN6UxI2v41bdB0P
         hFmDhjh/6s/0ifQnmPFua+y+DQ9s2+g8KIEXcfo6KvimbJL3gXaFYhl+FZlzWEMTS/O0
         UURlf48pEZLVOWOT8RalKkeIM2ERfKWsUSJT4UhZspmRkSxHFWnlyfBRIhDDiwrkhhDX
         c5lOGV1eiO17UqqOzC7LWU+kIrD3F2H7/e/38VvI2b/d4JnHHSAwQ22ADuZ1ohNO1iKy
         F5rra/+O0ejlSp98iyYbJaMJ8yDKFcMzRquL4A3XGQuqa+doxo1OQSEBKDCAinV+g25K
         dxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jnVWARWTCSXZft0d/rvK/it2ULZETAzN1k/HpOM9luE=;
        b=Mydfq3VaNgK9J8N5QTHQ96U9vyCx+vA0444j5OcOdViwps1Bffu9cDVQOQzHhVGiY1
         p0E1ZSg0N24nrhNSRlNPmCnbcF7ct3ZXSqQtuBr1G8ZlVbIxQDrNZ/WGOsK1C2HLpg8m
         5sOeNmo9tIFa215BdfM/kmvfyKL50cHw+V+94YSjkgtf+gXZl8avXnz8/hHLJRsBQy2G
         4YFg2qcz9PW6phfV/qpjD08BETEnY3ehpsp5J2dFVsu6JzBbFBRleVe7IkuBsnIXEeN/
         MUtMV91EEq6xVI5IooFp96GE7SfGQ0ZEdz1U8ge8eDdMY+5S00ZHCHJ0dy2SILKRbsRx
         WlzA==
X-Gm-Message-State: AOAM532q9QfMX4A3y6zioMwFsfnuqSf/O1qobMYLTgXi/mkZfJbK5IxE
        Yjmk0b+lJlubxMNE6VUDJ9g=
X-Google-Smtp-Source: ABdhPJwogphgM3LF0u6Q8D1F0RyYVVrr/f3ky/UsP+vf5XBOr27AhlTyC05P8D2oK96tPdYxa9ahZQ==
X-Received: by 2002:a37:a8cc:: with SMTP id r195mr31261770qke.174.1625846350594;
        Fri, 09 Jul 2021 08:59:10 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id x15sm2606071qkm.66.2021.07.09.08.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 08:59:10 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com, Nuno.Sa@analog.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v2 3/4] iio: adc: ad7949: add support for internal vref
Date:   Fri,  9 Jul 2021 11:58:55 -0400
Message-Id: <20210709155856.1732245-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210709155856.1732245-1-liambeguin@gmail.com>
References: <20210709155856.1732245-1-liambeguin@gmail.com>
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
 drivers/iio/adc/ad7949.c | 94 ++++++++++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index 770112ac820f..a20fd81a0830 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -31,6 +31,7 @@
 #define AD7949_CFG_VAL_BW_FULL			1
 #define AD7949_CFG_VAL_BW_QUARTER		0
 #define AD7949_CFG_BIT_REF		GENMASK(5, 3)
+#define AD7949_CFG_VAL_REF_EXTERNAL		BIT(1)
 #define AD7949_CFG_BIT_SEQ		GENMASK(2, 1)
 #define AD7949_CFG_BIT_RBN		BIT(0)
 
@@ -40,6 +41,33 @@ enum {
 	ID_AD7689,
 };
 
+/**
+ * enum ad7949_ref - Reference selection
+ *
+ * AD7949_REF_INT_2500:     Internal reference and temperature sensor enabled.
+ *                          Vref=2.5V, buffered output
+ * AD7949_REF_INT_4096:     Internal reference and temperature sensor enabled.
+ *                          Vref=4.096V, buffered output
+ * AD7949_REF_EXT_TEMP:     Use external reference, temperature sensor enabled.
+ *                          Internal buffer disabled
+ * AD7949_REF_EXT_TEMP_BUF: Use external reference, internal buffer and
+ *                          temperature sensor enabled.
+ * AD7949_REF_RSRV_4:       Do not use
+ * AD7949_REF_RSRV_5:       Do not use
+ * AD7949_REF_EXT:          Use external reference, internal buffer and
+ *                          temperature sensor disabled.
+ * AD7949_REF_EXT_BUF:      Use external reference, internal buffer enabled.
+ *                          Internal reference and temperature sensor disabled.
+ */
+enum ad7949_ref {
+	AD7949_REF_INT_2500 = 0,
+	AD7949_REF_INT_4096,
+	AD7949_REF_EXT_TEMP,
+	AD7949_REF_EXT_TEMP_BUF,
+	AD7949_REF_EXT = 6,
+	AD7949_REF_EXT_BUF,
+};
+
 struct ad7949_adc_spec {
 	u8 num_channels;
 	u8 resolution;
@@ -55,6 +83,7 @@ static const struct ad7949_adc_spec ad7949_adc_spec[] = {
  * struct ad7949_adc_chip - AD ADC chip
  * @lock: protects write sequences
  * @vref: regulator generating Vref
+ * @refsel: reference selection
  * @indio_dev: reference to iio structure
  * @spi: reference to spi structure
  * @resolution: resolution of the chip
@@ -66,6 +95,7 @@ static const struct ad7949_adc_spec ad7949_adc_spec[] = {
 struct ad7949_adc_chip {
 	struct mutex lock;
 	struct regulator *vref;
+	enum ad7949_ref refsel;
 	struct iio_dev *indio_dev;
 	struct spi_device *spi;
 	u8 resolution;
@@ -243,12 +273,28 @@ static int ad7949_spi_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-		ret = regulator_get_voltage(ad7949_adc->vref);
-		if (ret < 0)
-			return ret;
+		switch (ad7949_adc->refsel) {
+		case AD7949_REF_INT_2500:
+			*val = 2500;
+			break;
+		case AD7949_REF_INT_4096:
+			*val = 4096;
+			break;
+		case AD7949_REF_EXT_TEMP:
+		case AD7949_REF_EXT_TEMP_BUF:
+		case AD7949_REF_EXT:
+		case AD7949_REF_EXT_BUF:
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
@@ -287,7 +333,7 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
 		FIELD_PREP(AD7949_CFG_BIT_INCC, AD7949_CFG_VAL_INCC_UNIPOLAR_GND) |
 		FIELD_PREP(AD7949_CFG_BIT_INX, ad7949_adc->current_channel) |
 		FIELD_PREP(AD7949_CFG_BIT_BW, AD7949_CFG_VAL_BW_FULL) |
-		FIELD_PREP(AD7949_CFG_BIT_REF, AD7949_REF_EXT_BUF) |
+		FIELD_PREP(AD7949_CFG_BIT_REF, ad7949_adc->refsel) |
 		FIELD_PREP(AD7949_CFG_BIT_SEQ, 0x0) |
 		FIELD_PREP(AD7949_CFG_BIT_RBN, 1);
 
@@ -306,6 +352,7 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
 static int ad7949_spi_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
+	struct device_node *np = dev->of_node;
 	const struct ad7949_adc_spec *spec;
 	struct ad7949_adc_chip *ad7949_adc;
 	struct iio_dev *indio_dev;
@@ -332,16 +379,35 @@ static int ad7949_spi_probe(struct spi_device *spi)
 	ad7949_adc->resolution = spec->resolution;
 	ad7949_set_bits_per_word(ad7949_adc);
 
-	ad7949_adc->vref = devm_regulator_get(dev, "vref");
-	if (IS_ERR(ad7949_adc->vref)) {
-		dev_err(dev, "fail to request regulator\n");
-		return PTR_ERR(ad7949_adc->vref);
+	/* Set default devicetree parameters */
+	ad7949_adc->refsel = AD7949_REF_EXT_BUF;
+	of_property_read_u32(np, "adi,reference-select", &ad7949_adc->refsel);
+	switch (ad7949_adc->refsel) {
+	case AD7949_REF_INT_2500:
+	case AD7949_REF_INT_4096:
+	case AD7949_REF_EXT_TEMP:
+	case AD7949_REF_EXT_TEMP_BUF:
+	case AD7949_REF_EXT:
+	case AD7949_REF_EXT_BUF:
+		break;
+	default:
+		dev_err(dev, "invalid adi,reference-select value (%d)\n",
+			ad7949_adc->refsel);
+		return -EINVAL;
 	}
 
-	ret = regulator_enable(ad7949_adc->vref);
-	if (ret < 0) {
-		dev_err(dev, "fail to enable regulator\n");
-		return ret;
+	if (ad7949_adc->refsel & AD7949_CFG_VAL_REF_EXTERNAL) {
+		ad7949_adc->vref = devm_regulator_get(dev, "vref");
+		if (IS_ERR(ad7949_adc->vref)) {
+			dev_err(dev, "fail to request regulator\n");
+			return PTR_ERR(ad7949_adc->vref);
+		}
+
+		ret = regulator_enable(ad7949_adc->vref);
+		if (ret < 0) {
+			dev_err(dev, "fail to enable regulator\n");
+			return ret;
+		}
 	}
 
 	mutex_init(&ad7949_adc->lock);
-- 
2.30.1.489.g328c10930387

