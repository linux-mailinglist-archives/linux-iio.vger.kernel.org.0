Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DE43C1C49
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 01:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhGHX7Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Jul 2021 19:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhGHX7U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Jul 2021 19:59:20 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120DFC061760;
        Thu,  8 Jul 2021 16:56:37 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id s6so4715160qkc.8;
        Thu, 08 Jul 2021 16:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z8VFO5fDFedxk49e6pnimZmOf/PgMrAU78eWgI1ryeY=;
        b=XU4admqtTS1o9/3pPA7RYKkYYp5kQEAr1R3xoP5m+vu4F31HHtlyxFodINE4Y+/lFT
         7HLFb4hgtLxDkl+vCakWOBEX7WPJpVaV4PeiBSaprhCJncGBNAZO6vvvlbQ7SAYknQus
         Ccb8xYmkT0A23Qi3kL+0PtMvn9WgcAHRvExKo64hidKNgrtZBIFaLMhQ2hImj8NbDfpr
         fUxTccAxyoFdPJAjRd0XiO+XNsAxwjatKnkWBjeQWnQb/AQRH6vXvMytgSqrlHxtHkzD
         h70TcUOHK8AiwyMKGQ4rWNGQCGG9loec0fHQoUveK6KVnOSviR9fDEx1UaEsiJHKTW4W
         jpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z8VFO5fDFedxk49e6pnimZmOf/PgMrAU78eWgI1ryeY=;
        b=c7eVwSfOcI0Ba7odAnNpuh2hn3u9huFzmIFCjDCC5lgF4AHipv37smCQMGWY++MUhZ
         RawsEcppwLxGfgT8f0hKih2G2T9WNOiMRqZmqakqG6kiuvYpWRZGUlUYMSeLIG+JmomR
         SQZFRa2sULODzMl3KQvMhzw+hK7rL4dlDSelc77ZBbB1JNAWbl6C4oOJ7OWQ9mffZjno
         6Jym55GgFpzwqe0JsLpEI1NSunG8OuDsgXQYsSwROU7a5u5TMAizTrNoV8rhDqkA2lUn
         UJbNtGLEbgMPpFT8Qb6awsiRGuzA6qXAtWIzYp2dB0/x5Dgs3V18g+vlr6oK8ccnT1rn
         LCgg==
X-Gm-Message-State: AOAM531gVk1/9FQdb8K3sBdnPNA6K65Z2xIcH7xVmJUQ/hgW5pLVGuL3
        Mtdx0i/d08V2ntloOIc1ivU=
X-Google-Smtp-Source: ABdhPJxQoGIBv2Nbs+U+y6jq0oWSZvX4bG5a1Qc/uED+RXafebojEjnKMv9IczxvfNsYVepFnhYizw==
X-Received: by 2002:a37:2e83:: with SMTP id u125mr35025808qkh.168.1625788596223;
        Thu, 08 Jul 2021 16:56:36 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id m68sm1733234qkc.109.2021.07.08.16.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 16:56:35 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        charles-antoine.couret@essensium.com
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v1 3/4] iio: adc: ad7949: add support for internal vref
Date:   Thu,  8 Jul 2021 19:56:17 -0400
Message-Id: <20210708235618.1541335-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210708235618.1541335-1-liambeguin@gmail.com>
References: <20210708235618.1541335-1-liambeguin@gmail.com>
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
 drivers/iio/adc/ad7949.c | 84 +++++++++++++++++++++++++++++++++-------
 1 file changed, 69 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index bbc6b56330a3..3c1293922d2e 100644
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
@@ -241,12 +271,28 @@ static int ad7949_spi_read_raw(struct iio_dev *indio_dev,
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
@@ -285,7 +331,7 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
 		FIELD_PREP(AD7949_CFG_BIT_INCC, AD7949_CFG_VAL_INCC_UNIPOLAR_GND) |
 		FIELD_PREP(AD7949_CFG_BIT_INX, ad7949_adc->current_channel) |
 		FIELD_PREP(AD7949_CFG_BIT_BW, AD7949_CFG_VAL_BW_FULL) |
-		FIELD_PREP(AD7949_CFG_BIT_REF, AD7949_REF_EXT_BUF) |
+		FIELD_PREP(AD7949_CFG_BIT_REF, ad7949_adc->refsel) |
 		FIELD_PREP(AD7949_CFG_BIT_SEQ, 0x0) |
 		FIELD_PREP(AD7949_CFG_BIT_RBN, 1);
 
@@ -304,6 +350,7 @@ static int ad7949_spi_init(struct ad7949_adc_chip *ad7949_adc)
 static int ad7949_spi_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
+	struct device_node *np = dev->of_node;
 	const struct ad7949_adc_spec *spec;
 	struct ad7949_adc_chip *ad7949_adc;
 	struct iio_dev *indio_dev;
@@ -315,6 +362,7 @@ static int ad7949_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 	}
 
+	indio_dev->dev.of_node = np;
 	indio_dev->info = &ad7949_spi_info;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -330,16 +378,22 @@ static int ad7949_spi_probe(struct spi_device *spi)
 	ad7949_adc->resolution = spec->resolution;
 	ad7949_set_bits_per_word(ad7949_adc);
 
-	ad7949_adc->vref = devm_regulator_get(dev, "vref");
-	if (IS_ERR(ad7949_adc->vref)) {
-		dev_err(dev, "fail to request regulator\n");
-		return PTR_ERR(ad7949_adc->vref);
-	}
+	/* Set default devicetree parameters */
+	ad7949_adc->refsel = AD7949_REF_EXT_BUF;
+	of_property_read_u32(np, "adi,reference-select", &ad7949_adc->refsel);
 
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

