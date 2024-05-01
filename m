Return-Path: <linux-iio+bounces-4727-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CE18B8C46
	for <lists+linux-iio@lfdr.de>; Wed,  1 May 2024 16:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2113C28373E
	for <lists+linux-iio@lfdr.de>; Wed,  1 May 2024 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28DE12FB3C;
	Wed,  1 May 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nc3mPf9I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B14412F59A
	for <linux-iio@vger.kernel.org>; Wed,  1 May 2024 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575356; cv=none; b=npkN2iwfySdtGCCJayFPKx32C1CQjjM84KWxlU9Y014lxkXyEgcqRNOePMemMrV32T0VwKJ0tZ4tqEVBgt5viXTdQzal290RLr7ATfH4wvB/01fueJy0zmvtuCXs+F9kTV5C4FNsbfdpaevQIFxeTta2G5x/7mO27WOX7hS2oXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575356; c=relaxed/simple;
	bh=pkf8/LBRCf3QFRHG5cHQzVuVo0laS5hX0xG0KSpAu9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=akIQTrviaruZeADooOehqaUsyglzYKzbnKl9mGzFGa8epcAnxZ8KRg8e3m7pt1VTAE+ORNXGdN9gjEaTM7mxAga44gcBlzpzLYF56XcrgNoOE+ocMpL1I3GwzvO/qc6QBt52uyWb9ZPHj4a3wKmPCMnn6DpLeEslWToeNXhi5TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nc3mPf9I; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41b794510cdso44214695e9.2
        for <linux-iio@vger.kernel.org>; Wed, 01 May 2024 07:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714575353; x=1715180153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2zQ8GQKC8PPzpOVhoeg1QxOlQu6eFpvStLY4dMmkvU=;
        b=nc3mPf9ItVYKwtVIu3v3fQyya0674yswZqYmKkLoaVQxydT4DakF08WBDLjkfc2dKo
         yrTr2bOEUAJYKJnaBuDi9QRjax6/2hLcjJV6vJShOS+DTKz2jR8qMprpo76loPyA5v0a
         Uxl6F7YtIQMhehrqI73ovXndnKG17AmQA2NZ/SAg4dAuHkjqNjjqOCIcK9iSLsO7qYGq
         wZJd3d9MODW+nkls9x50IHtYwD76WnGat5ysVJqkOWtV9zVP96qJO4LV1Z1C4X7JgnYD
         D6OL4LhIFTfiixlXFLd28PlVRAfU4/6BXxcPcMIhKk6raJvfZ/rzbJgPlIgYWcMBM6m0
         pV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714575353; x=1715180153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2zQ8GQKC8PPzpOVhoeg1QxOlQu6eFpvStLY4dMmkvU=;
        b=kVqhnBFH8OmKs4y2eR3m8txvxSfmtcRk7sqWGcR44Lj/CYeorkjV1D2DEy6y065yYQ
         k+BihWpEPQNpIL7AnHHpx102/t8oraiwDHoAixu3HABKtfwugJEvCPq/e+XSxnS0wgVj
         iX5GxK9RN7nzYCZMktJ1ecX7lJglhb9BrkfG4AMiP5R0L+mPB2dyDylelBlb16sJpnGb
         8JHIaMaSB0bO7Z2VZH5wvP9DBT1GJuarSOlUyXVXbJOHovWltCUzzoxVoGo/0BT28KJy
         dxt8ktyp1L2EdlYOhOV71OfWTmyXwTcgEN11YDzircfPPXgNrcjDUVPgHSRFFV9z/fxX
         b3kw==
X-Forwarded-Encrypted: i=1; AJvYcCVN26cvnNYEZZK3jbLgsCKR+QWAHU8vGINuzI3blYDiyPhCKIpptUswdtqfKPVJkehzeu7nIL15Qf8QBn6eATk9p7/6bNrHW3nB
X-Gm-Message-State: AOJu0YzhrtLQfJ+BN590T+tBRBLjSOugr2UBKfWkez/HAnBOL0kOP38d
	dLuWG03knm1g8dYBbz6wLpvlVQMNOmpom9tfnEes1mNARLJ2QAgCTEBUoOR95lA=
X-Google-Smtp-Source: AGHT+IGBz8W9nhzACKGWf4RlR4Hiqj1BQdAdiHE4fm1+pfhBTIRnjURKhxDOzFO2p/pjRMJ/UFm4bA==
X-Received: by 2002:a05:600c:4fd3:b0:41c:9155:fbe6 with SMTP id o19-20020a05600c4fd300b0041c9155fbe6mr1791507wmq.17.1714575352879;
        Wed, 01 May 2024 07:55:52 -0700 (PDT)
Received: from [192.168.1.61] ([2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id o27-20020a05600c511b00b00418a386c17bsm2422999wms.12.2024.05.01.07.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:55:52 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 01 May 2024 16:55:37 +0200
Subject: [PATCH RFC v6 04/10] iio: adc: ad7380: add support for
 pseudo-differential parts
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240501-adding-new-ad738x-driver-v6-4-3c0741154728@baylibre.com>
References: <20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
In-Reply-To: <20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
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
index a218f59c276e..d6abce6d45d3 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -7,6 +7,7 @@
  *
  * Datasheets of supported parts:
  * ad7380/1 : https://www.analog.com/media/en/technical-documentation/data-sheets/AD7380-7381.pdf
+ * ad7383/4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7383-7384.pdf
  */
 
 #include <linux/bitfield.h>
@@ -68,16 +69,19 @@ struct ad7380_chip_info {
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
@@ -87,15 +91,23 @@ struct ad7380_chip_info {
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
@@ -115,11 +127,28 @@ static const struct ad7380_chip_info ad7381_chip_info = {
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
@@ -293,13 +322,24 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
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
@@ -346,7 +386,7 @@ static int ad7380_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	struct ad7380_state *st;
 	struct regulator *vref;
-	int ret;
+	int ret, i;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
@@ -390,6 +430,40 @@ static int ad7380_probe(struct spi_device *spi)
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
@@ -418,12 +492,16 @@ static int ad7380_probe(struct spi_device *spi)
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


