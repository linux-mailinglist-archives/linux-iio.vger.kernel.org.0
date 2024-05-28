Return-Path: <linux-iio+bounces-5392-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCAA8D1E6D
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 16:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 637E0B222D8
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 14:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA5117082C;
	Tue, 28 May 2024 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QfLXupUr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A10716F905
	for <linux-iio@vger.kernel.org>; Tue, 28 May 2024 14:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906044; cv=none; b=f01LkHfqW3yvHOnGLRad09QYjR92fPmnFzXsGjNRl+xZ8d4dZecYT/r6wG713Bt6Rx1Aiy55j8pjUKRkvMQb6R2a7X4Qu+KaAoku9oZUx8xPpAa8DpsDb4OFPlAqpWmcFwfYcOLZjCoRTb0NKVegpUPe4Bn9BiaGNyTuBf7mI+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906044; c=relaxed/simple;
	bh=GyOt6fap9XtxKOu2kTSLmUnNL+xLHReYGC7Mcyovo7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WhUdTno56D66EcFUdDdQzCC+WDv63j441O8hWitHOP/GZrjJoZw6Bh2qG9e/8c+q7x+JlHgKWp75AEX7wQ1DjTm9Phw2fide6f00xi/xzK83RKFOUdbUltoE0aY4Uf4djD2bH0PPjAekYFxyy3oxXXvyEYY0YwIspUJ8qt2UUw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QfLXupUr; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-354f14bd80cso545938f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 28 May 2024 07:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716906041; x=1717510841; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yckqe26W9iPZGQmV4Ijp5QzBcbOV6EvrsiuvLN1du88=;
        b=QfLXupUr78Y/usbUWypTZ/Nh/H5BXST4qPEMsXlhEbumFfwv1w5BrDTbcCwq2sydpw
         oTuqOGfOeIP4uzfr9iLPrU49AEjzPxbAcMiLm+BtxoGWZfRr/17784ZMzr8gTEiRVETo
         eacZtj79tASTYvlegjVWCvwT3MplFudf8z40TP7EoWZSjOHW88m+GmCTk/QluAIo6F4A
         ZXsoff3ZSbCPHKrdzo1qd1zNbFAcUP7Dt9Uy612i30DjXn/ctLiabvQ9OGnm5yn3pLo5
         jJQchpqJTtiDXDu7U79iIb6hlz5JtKTHyWYNn9BXSECTrc2NcH8hV97/3X2p/oIqfscA
         Se8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716906041; x=1717510841;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yckqe26W9iPZGQmV4Ijp5QzBcbOV6EvrsiuvLN1du88=;
        b=nkzUsvXzIMPV9k0eQCK+demQMAFYozbq9gBFtwWMFJF7ThxOI8ZrZRCaGcdiFT05sj
         EncdIBC0SWIm1zGMKm6ZNO3ahhJuLc7OXjkRqikFEd/awk474wEJoUZl3XS8ID8rwhB0
         +r3Z1A/BL43dLUrjrl/UiEdZKErGjbMXVuXMK0okY6Oa8+KucOwuML3YQqOOfPV6lk8S
         IIDCSY9K/vXyXCcLapEhHpLjIBW8QyQvEkeruew6WWaopC0TgDCFAj41i0nQNOAZaC0p
         fmQyDg528asAIUkiXghvA1hZ9p+j2XT/gPK4OKP+HuFldygEmC5lClxRZZcHu1eQqzpZ
         SRmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNvVzc0n5peXLWFR6kS17xDomr6ENH91B42LzLlR3Ils1eTaSJoT0zMvKImHrMI4wVAGzhlh/YW9YL1MbpN89MM1kPZqtT+E4i
X-Gm-Message-State: AOJu0YwaISIGuyZpbFIH0GaIeMR1kIzCxdCXMhI06h/E4yZt8AKn6faR
	6+QXGmrl+3yxuratdoCWVuqSIeWvD6/BOJdOdFiJ6e49u7Wst//icW5chho1lCJxHQfjkjQ7sfA
	DMeGCX0LM
X-Google-Smtp-Source: AGHT+IHTyeQ5Em7hPe0HI1+coYtjY8PTddP96gBSMgaHxibz5eMPdMm3Jbj/NqYdo2vPYRu5wkiorA==
X-Received: by 2002:a5d:4684:0:b0:354:fc65:39d6 with SMTP id ffacd0b85a97d-35526c70f51mr8614510f8f.26.1716906040857;
        Tue, 28 May 2024 07:20:40 -0700 (PDT)
Received: from [192.168.1.63] ([2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7db5esm11999275f8f.15.2024.05.28.07.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:20:40 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 May 2024 16:20:31 +0200
Subject: [PATCH v7 4/7] iio: adc: ad7380: add support for
 pseudo-differential parts
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240528-adding-new-ad738x-driver-v7-4-4cd70a4c12c8@baylibre.com>
References: <20240528-adding-new-ad738x-driver-v7-0-4cd70a4c12c8@baylibre.com>
In-Reply-To: <20240528-adding-new-ad738x-driver-v7-0-4cd70a4c12c8@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: kernel test robot <lkp@intel.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.13.0

From: David Lechner <dlechner@baylibre.com>

Add support for AD7383, AD7384 pseudo-differential compatible parts.
Pseudo differential parts require common mode voltage supplies so add
the support for them and add the support of IIO_CHAN_INFO_OFFSET to
retrieve the offset

Signed-off-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 110 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 94 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index dac7e11755ff..4ad283cf970d 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -7,6 +7,7 @@
  *
  * Datasheets of supported parts:
  * ad7380/1 : https://www.analog.com/media/en/technical-documentation/data-sheets/AD7380-7381.pdf
+ * ad7383/4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7383-7384.pdf
  */
 
 #include <linux/bitfield.h>
@@ -66,16 +67,19 @@ struct ad7380_chip_info {
 	const char *name;
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
+	const char * const *vcm_supplies;
+	unsigned int num_vcm_supplies;
 };
 
-#define AD7380_CHANNEL(index, bits) {				\
+#define AD7380_CHANNEL(index, bits, diff) {			\
 	.type = IIO_VOLTAGE,					\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+		((diff) ? 0 : BIT(IIO_CHAN_INFO_OFFSET)),	\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
 	.indexed = 1,						\
-	.differential = 1,					\
-	.channel = 2 * (index),					\
-	.channel2 = 2 * (index) + 1,				\
+	.differential = (diff),					\
+	.channel = (diff) ? (2 * (index)) : (index),		\
+	.channel2 = (diff) ? (2 * (index) + 1) : 0,		\
 	.scan_index = (index),					\
 	.scan_type = {						\
 		.sign = 's',					\
@@ -85,15 +89,23 @@ struct ad7380_chip_info {
 	},							\
 }
 
-#define DEFINE_AD7380_2_CHANNEL(name, bits)	\
-static const struct iio_chan_spec name[] = {	\
-	AD7380_CHANNEL(0, bits),		\
-	AD7380_CHANNEL(1, bits),		\
-	IIO_CHAN_SOFT_TIMESTAMP(2),		\
+#define DEFINE_AD7380_2_CHANNEL(name, bits, diff)	\
+static const struct iio_chan_spec name[] = {		\
+	AD7380_CHANNEL(0, bits, diff),			\
+	AD7380_CHANNEL(1, bits, diff),			\
+	IIO_CHAN_SOFT_TIMESTAMP(2),			\
 }
 
-DEFINE_AD7380_2_CHANNEL(ad7380_channels, 16);
-DEFINE_AD7380_2_CHANNEL(ad7381_channels, 14);
+/* fully differential */
+DEFINE_AD7380_2_CHANNEL(ad7380_channels, 16, 1);
+DEFINE_AD7380_2_CHANNEL(ad7381_channels, 14, 1);
+/* pseudo differential */
+DEFINE_AD7380_2_CHANNEL(ad7383_channels, 16, 0);
+DEFINE_AD7380_2_CHANNEL(ad7384_channels, 14, 0);
+
+static const char * const ad7380_2_channel_vcm_supplies[] = {
+	"aina", "ainb",
+};
 
 /* Since this is simultaneous sampling, we don't allow individual channels. */
 static const unsigned long ad7380_2_channel_scan_masks[] = {
@@ -113,11 +125,28 @@ static const struct ad7380_chip_info ad7381_chip_info = {
 	.num_channels = ARRAY_SIZE(ad7381_channels),
 };
 
+static const struct ad7380_chip_info ad7383_chip_info = {
+	.name = "ad7383",
+	.channels = ad7383_channels,
+	.num_channels = ARRAY_SIZE(ad7383_channels),
+	.vcm_supplies = ad7380_2_channel_vcm_supplies,
+	.num_vcm_supplies = ARRAY_SIZE(ad7380_2_channel_vcm_supplies),
+};
+
+static const struct ad7380_chip_info ad7384_chip_info = {
+	.name = "ad7384",
+	.channels = ad7384_channels,
+	.num_channels = ARRAY_SIZE(ad7384_channels),
+	.vcm_supplies = ad7380_2_channel_vcm_supplies,
+	.num_vcm_supplies = ARRAY_SIZE(ad7380_2_channel_vcm_supplies),
+};
+
 struct ad7380_state {
 	const struct ad7380_chip_info *chip_info;
 	struct spi_device *spi;
 	struct regmap *regmap;
 	unsigned int vref_mv;
+	unsigned int vcm_mv[2];
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -288,13 +317,24 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
 		unreachable();
 	case IIO_CHAN_INFO_SCALE:
 		/*
-		 * According to the datasheet, the LSB size for fully differential ADC is
-		 * (2 × VREF) / 2^N, where N is the ADC resolution (i.e realbits)
+		 * According to the datasheet, the LSB size is:
+		 *    * (2 × VREF) / 2^N, for differential chips
+		 *    * VREF / 2^N, for pseudo-differential chips
+		 * where N is the ADC resolution (i.e realbits)
 		 */
 		*val = st->vref_mv;
-		*val2 = chan->scan_type.realbits - 1;
+		*val2 = chan->scan_type.realbits - chan->differential;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_OFFSET:
+		/*
+		 * According to IIO ABI, offset is applied before scale,
+		 * so offset is: vcm_mv / scale
+		 */
+		*val = st->vcm_mv[chan->channel] * (1 << chan->scan_type.realbits)
+			/ st->vref_mv;
+
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -341,7 +381,7 @@ static int ad7380_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	struct ad7380_state *st;
 	struct regulator *vref;
-	int ret;
+	int ret, i;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
@@ -385,6 +425,40 @@ static int ad7380_probe(struct spi_device *spi)
 		st->vref_mv = AD7380_INTERNAL_REF_MV;
 	}
 
+	if (st->chip_info->num_vcm_supplies > ARRAY_SIZE(st->vcm_mv))
+		return dev_err_probe(&spi->dev, -EINVAL,
+				     "invalid number of VCM supplies\n");
+
+	/*
+	 * pseudo-differential chips have common mode supplies for the negative
+	 * input pin.
+	 */
+	for (i = 0; i < st->chip_info->num_vcm_supplies; i++) {
+		struct regulator *vcm;
+
+		vcm = devm_regulator_get(&spi->dev,
+					 st->chip_info->vcm_supplies[i]);
+		if (IS_ERR(vcm))
+			return dev_err_probe(&spi->dev, PTR_ERR(vcm),
+					     "Failed to get %s regulator\n",
+					     st->chip_info->vcm_supplies[i]);
+
+		ret = regulator_enable(vcm);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(&spi->dev,
+					       ad7380_regulator_disable, vcm);
+		if (ret)
+			return ret;
+
+		ret = regulator_get_voltage(vcm);
+		if (ret < 0)
+			return ret;
+
+		st->vcm_mv[i] = ret / 1000;
+	}
+
 	st->regmap = devm_regmap_init(&spi->dev, NULL, st, &ad7380_regmap_config);
 	if (IS_ERR(st->regmap))
 		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
@@ -413,12 +487,16 @@ static int ad7380_probe(struct spi_device *spi)
 static const struct of_device_id ad7380_of_match_table[] = {
 	{ .compatible = "adi,ad7380", .data = &ad7380_chip_info },
 	{ .compatible = "adi,ad7381", .data = &ad7381_chip_info },
+	{ .compatible = "adi,ad7383", .data = &ad7383_chip_info },
+	{ .compatible = "adi,ad7384", .data = &ad7384_chip_info },
 	{ }
 };
 
 static const struct spi_device_id ad7380_id_table[] = {
 	{ "ad7380", (kernel_ulong_t)&ad7380_chip_info },
 	{ "ad7381", (kernel_ulong_t)&ad7381_chip_info },
+	{ "ad7383", (kernel_ulong_t)&ad7383_chip_info },
+	{ "ad7384", (kernel_ulong_t)&ad7384_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7380_id_table);

-- 
2.44.0


