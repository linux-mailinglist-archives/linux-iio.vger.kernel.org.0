Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE3C7A9F6C
	for <lists+linux-iio@lfdr.de>; Thu, 21 Sep 2023 22:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjIUUV5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Sep 2023 16:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjIUUVf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 16:21:35 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8C3101B5
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:30:06 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50317080342so2202305e87.2
        for <linux-iio@vger.kernel.org>; Thu, 21 Sep 2023 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695317399; x=1695922199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSzhqtQuH6rCmKnaqNrN1q0TijVTu8SKnjt98b8WvE0=;
        b=0WVWNZEUsJC/IyDOsqcc2vpP86x4fu9BAV2VIe3dVltc2OxW7GwYP/5ZFRjY0HmufQ
         QsEF23O4ws1HQgQgZ+n7xNQ6xSI1EKepGkA3etssvi+MTeav1ruteoAufLLHcQy3znRa
         C88M1KeO+IsN9HmU/GMTtuB6nNNAMStZFO80rbq1OwByY7h8oLoXQ7R8I7Rb9HKB2dnU
         RDA5ljZRtmanrkAsKasqGIQuXm9kAZfYDlP8EqxXNGFL0MVcbyZRP3iOcf7icleSHIX/
         APyMgwc6Cihx2/swHPmVH6hJuo2VDYy+ENix39hmy4dNen95EE6puQO63Jh6TqHCLMdo
         xSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317399; x=1695922199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSzhqtQuH6rCmKnaqNrN1q0TijVTu8SKnjt98b8WvE0=;
        b=HGrWhgiSTEBt76B6qHd4uYxnwt4GbbgTkyhmxjhtd/5sOQ68HRkEgnjGMfgEzCNwey
         HiLMf5hxisyQmUJhkSL2NpJTIN8PXX/XB3OEqs0aWNzZdsMBN70/qtmy8cEdedc4MXRh
         ZHF0JPfcOQUx54hi7Xcn41S9drkCfE3qs2aQg6/6/i6yDDFpfFicU5z/QMz8JjSe3sXh
         Piwk7BV0ZQ3Dmc82uxDSqKPpHoHQUVlVHF+cR1FpGrMwLzM7NCiyovkZ4WPB1JYAHG2N
         30hZoM+6yg4k7S1jvFNeqMoHXTbfDNuv0PtP/XbC5eXzpB3pyjgfqQDtL6J8cnWj0+jH
         poWA==
X-Gm-Message-State: AOJu0Yx7eid3CP6DzO25bk/7rTVF8Hc+MWMY2jr4GbPavEbW28lwE7Lp
        B45fo4K0+qfYvLWHdHGp2fWixI09gfLBLDnvfcnf4zOX
X-Google-Smtp-Source: AGHT+IFQ0sTrKh3A+gVntqh1ExJr1OAgV4DcRjLG5h7bF91pNN2MfZNHke1Xmsy4fIw1aiNlm9pFPg==
X-Received: by 2002:a05:600c:1c28:b0:405:3557:8e49 with SMTP id j40-20020a05600c1c2800b0040535578e49mr1403445wms.40.1695307467567;
        Thu, 21 Sep 2023 07:44:27 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003fe2a40d287sm2125515wmc.1.2023.09.21.07.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:44:27 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 17/19] staging: iio: resolver: ad2s1210: convert resolution to devicetree property
Date:   Thu, 21 Sep 2023 09:43:58 -0500
Message-Id: <20230921144400.62380-18-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921144400.62380-1-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Selecting the resolution was implemented as the `bits` sysfs attribute.
However, the selection of the resolution depends on how the hardware
is wired and the specific application, so this is rather a job for
devicetree to describe.

A new devicetree property `adi,resolution` to specify the resolution
required for each chip is added and the `bits` sysfs attribute is
removed.

Since the resolution is now supplied by a devicetree property, the
resolution-gpios are now optional and we can allow for the case where
the resolution pins on the AD2S1210 are hard-wired instead of requiring
them to be connected to gpios.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 136 +++++++++++-------------
 1 file changed, 61 insertions(+), 75 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 14bec2b20939..71f0913b7e2e 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -65,6 +65,13 @@ enum ad2s1210_mode {
 	MOD_CONFIG = 0b11,
 };
 
+enum ad2s1210_resolution {
+	AD2S1210_RES_10 = 0b00,
+	AD2S1210_RES_12 = 0b01,
+	AD2S1210_RES_14 = 0b10,
+	AD2S1210_RES_16 = 0b11,
+};
+
 struct ad2s1210_state {
 	struct mutex lock;
 	struct spi_device *sdev;
@@ -72,13 +79,12 @@ struct ad2s1210_state {
 	struct gpio_desc *sample_gpio;
 	/** GPIO pins connected to A0 and A1 lines. */
 	struct gpio_descs *mode_gpios;
-	/** GPIO pins connected to RES0 and RES1 lines. */
-	struct gpio_descs *resolution_gpios;
 	/** Used to access config registers. */
 	struct regmap *regmap;
 	/** The external oscillator frequency in Hz. */
 	unsigned long fclkin;
-	u8 resolution;
+	/** The selected resolution */
+	enum ad2s1210_resolution resolution;
 	u8 rx[2] __aligned(IIO_DMA_MINALIGN);
 	u8 tx[2];
 };
@@ -205,18 +211,6 @@ static int ad2s1210_set_excitation_frequency(struct ad2s1210_state *st,
 	return regmap_write(st->regmap, AD2S1210_REG_SOFT_RESET, 0);
 }
 
-static int ad2s1210_set_resolution_gpios(struct ad2s1210_state *st,
-					 u8 resolution)
-{
-	struct gpio_descs *gpios = st->resolution_gpios;
-	DECLARE_BITMAP(bitmap, 2);
-
-	bitmap[0] = (resolution - 10) >> 1;
-
-	return gpiod_set_array_value(gpios->ndescs, gpios->desc, gpios->info,
-				     bitmap);
-}
-
 static ssize_t excitation_frequency_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -265,50 +259,6 @@ static ssize_t excitation_frequency_store(struct device *dev,
 	return ret;
 }
 
-static ssize_t ad2s1210_show_resolution(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-
-	return sprintf(buf, "%d\n", st->resolution);
-}
-
-static ssize_t ad2s1210_store_resolution(struct device *dev,
-					 struct device_attribute *attr,
-					 const char *buf, size_t len)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-	unsigned char data;
-	unsigned char udata;
-	int ret;
-
-	ret = kstrtou8(buf, 10, &udata);
-	if (ret || udata < 10 || udata > 16) {
-		dev_err(dev, "ad2s1210: resolution out of range\n");
-		return -EINVAL;
-	}
-
-	data = (udata - 10) >> 1;
-
-	mutex_lock(&st->lock);
-	ret = regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
-				 AD2S1210_SET_RES, data);
-	if (ret < 0)
-		goto error_ret;
-
-	ret = ad2s1210_set_resolution_gpios(st, udata);
-	if (ret < 0)
-		goto error_ret;
-
-	st->resolution = udata;
-	ret = len;
-
-error_ret:
-	mutex_unlock(&st->lock);
-	return ret;
-}
-
 /* read the fault register since last sample */
 static ssize_t ad2s1210_show_fault(struct device *dev,
 				   struct device_attribute *attr, char *buf)
@@ -556,8 +506,6 @@ static int ad2s1210_write_raw(struct iio_dev *indio_dev,
 }
 
 static IIO_DEVICE_ATTR_RW(excitation_frequency, 0);
-static IIO_DEVICE_ATTR(bits, 0644,
-		       ad2s1210_show_resolution, ad2s1210_store_resolution, 0);
 static IIO_DEVICE_ATTR(fault, 0644,
 		       ad2s1210_show_fault, ad2s1210_clear_fault, 0);
 
@@ -604,7 +552,6 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 
 static struct attribute *ad2s1210_attributes[] = {
 	&iio_dev_attr_excitation_frequency.dev_attr.attr,
-	&iio_dev_attr_bits.dev_attr.attr,
 	&iio_dev_attr_fault.dev_attr.attr,
 	&iio_dev_attr_los_thrd.dev_attr.attr,
 	&iio_dev_attr_dos_ovr_thrd.dev_attr.attr,
@@ -626,12 +573,10 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = ad2s1210_set_resolution_gpios(st, st->resolution);
-	if (ret < 0)
-		return ret;
 
 	data = AD2S1210_DEF_CONTROL & ~AD2S1210_SET_RES;
-	data |= (st->resolution - 10) >> 1;
+	data |= st->resolution;
+
 	ret = regmap_write(st->regmap, AD2S1210_REG_CONTROL, data);
 	if (ret < 0)
 		goto error_ret;
@@ -670,6 +615,26 @@ static const struct iio_info ad2s1210_info = {
 	.debugfs_reg_access = &ad2s1210_debugfs_reg_access,
 };
 
+static int ad2s1210_setup_properties(struct ad2s1210_state *st)
+{
+	struct device *dev = &st->sdev->dev;
+	u32 val;
+	int ret;
+
+	ret = device_property_read_u32(dev, "assigned-resolution-bits", &val);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+			"failed to read assigned-resolution-bits property\n");
+
+	if (val < 10 || val > 16)
+		return dev_err_probe(dev, -EINVAL,
+				     "resolution out of range: %u\n", val);
+
+	st->resolution = (val - 10) >> 1;
+
+	return 0;
+}
+
 static int ad2s1210_setup_clocks(struct ad2s1210_state *st)
 {
 	struct device *dev = &st->sdev->dev;
@@ -691,6 +656,9 @@ static int ad2s1210_setup_clocks(struct ad2s1210_state *st)
 static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 {
 	struct device *dev = &st->sdev->dev;
+	struct gpio_descs *resolution_gpios;
+	DECLARE_BITMAP(bitmap, 2);
+	int ret;
 
 	/* should not be sampling on startup */
 	st->sample_gpio = devm_gpiod_get(dev, "sample", GPIOD_OUT_LOW);
@@ -708,16 +676,31 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
 		return dev_err_probe(dev, -EINVAL,
 				     "requires exactly 2 mode-gpios\n");
 
-	/* both pins high means that we start with 16-bit resolution */
-	st->resolution_gpios = devm_gpiod_get_array(dev, "resolution",
-						    GPIOD_OUT_HIGH);
-	if (IS_ERR(st->resolution_gpios))
-		return dev_err_probe(dev, PTR_ERR(st->resolution_gpios),
+	/* If resolution gpios are provided, they get set to the required
+	 * resolution, otherwise it is assumed the RES0 and RES1 pins are
+	 * hard-wired to match the resolution indicated in the devicetree.
+	 */
+	resolution_gpios = devm_gpiod_get_array_optional(dev, "resolution",
+							 GPIOD_ASIS);
+	if (IS_ERR(resolution_gpios))
+		return dev_err_probe(dev, PTR_ERR(resolution_gpios),
 				     "failed to request resolution GPIOs\n");
 
-	if (st->resolution_gpios->ndescs != 2)
-		return dev_err_probe(dev, -EINVAL,
-				     "requires exactly 2 resolution-gpios\n");
+	if (resolution_gpios) {
+		if (resolution_gpios->ndescs != 2)
+			return dev_err_probe(dev, -EINVAL,
+				      "requires exactly 2 resolution-gpios\n");
+
+		bitmap[0] = st->resolution;
+
+		ret = gpiod_set_array_value(resolution_gpios->ndescs,
+					    resolution_gpios->desc,
+					    resolution_gpios->info,
+					    bitmap);
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "failed to set resolution gpios\n");
+	}
 
 	return 0;
 }
@@ -782,7 +765,10 @@ static int ad2s1210_probe(struct spi_device *spi)
 
 	mutex_init(&st->lock);
 	st->sdev = spi;
-	st->resolution = 12;
+
+	ret = ad2s1210_setup_properties(st);
+	if (ret < 0)
+		return ret;
 
 	ret = ad2s1210_setup_clocks(st);
 	if (ret < 0)
-- 
2.34.1

