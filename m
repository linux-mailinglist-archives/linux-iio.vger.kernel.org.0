Return-Path: <linux-iio+bounces-13771-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 642A49FBB3D
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 10:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943351882807
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 09:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5521B2180;
	Tue, 24 Dec 2024 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TEyu7CRc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9A01940A1
	for <linux-iio@vger.kernel.org>; Tue, 24 Dec 2024 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735032881; cv=none; b=R4X0M/C1tm1xKdP5U2zijtlDYKcz+mSotc8JLIt/3wMTkHI4xb9QReCldatF0mBXglX0NyUmamRu1U67Gwgue325IktpOl4XwsgW2S2W+zTAjE1cVn6KkpML3weVsNJPFa9xmSWuqz04gNZ7AwHnGn48PWPI3qEaqNz90joKYqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735032881; c=relaxed/simple;
	bh=yua/0zbTjMAmf2oFYpIk9LoTXBCtqmeHxVaLSwADFOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=koAdzRraaOtd7maMPk37SIznhNgl6Bdi6wlwLwLTWslzEvWuJz+DiyN6VLGsrlMNd17qzwqzlq/TiSjYkWs+IPOYoqsyv07goTttSEsSRbNzrrAXNSvLyy2RKoGwfRupewc4KLzyddq/M9klsFKJyzd1yQ2ZTH1adwUDfKoLSDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TEyu7CRc; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e2880606so3740511f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 24 Dec 2024 01:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1735032877; x=1735637677; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+u4Jy5PvOQf+0yU+yfEzQNHFYwkap+NBzqGZU1Srk8=;
        b=TEyu7CRcUSamaKAOBgKktJln5RZZJA3bLD19Qzu4x5yLdOW3ZNMvvhJXlDr5xV4sPo
         L8X1So0gEd56Asim7J1yFiRZWf7D7BTI5Jj/gvqO0y25Bhy0CWdMidHJGBUJFt9X3pyR
         6YLxGxlisLiY2btzOlhvXhji7nB7sIyJ91HccKU6hMbIXGWDIg+VksLQB1nMIMHZB5Yl
         geh867C27o0bvC+HPcdi++JP0x3BH0itDXvUrhcv/sTlDlYDoUWyNdEcGIo70TrM6rIT
         Chb2TvCrL3eIlBXi7HMTdD9WA1aebO+LAD3ezC1Bejg9zCmPL4kcU6VZAqBC9W5LtLv1
         vhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735032877; x=1735637677;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+u4Jy5PvOQf+0yU+yfEzQNHFYwkap+NBzqGZU1Srk8=;
        b=efHSRsMj8FrVtsFISLM/AX0uAInwAH+vdGIJwVNADEO7zJduT1E+PKOCrRs8sE4Tfz
         GKBPxgBC8+DFNDZ2njLqYq1YV6MrnbousQWBI0KVKzJ3k7zvPyiM0tLb21vTkmZl5MpB
         gLU4S8q/LjIfO02IXIFBrNM/RLV6266Jaq6+2fIxg1j28vki9bZtpo6IJwyfN/8G8P2w
         jtCRfCgCn3xFnZsRhYqqvwoXPcHTAQvmXtZF6Cv41A/KrpIK2IyJyMfpbf4TZwsozshi
         /PT+lxlskIlPqsZE5OEVR+3jllVgzwzolUgX7zP+Ul4KgTU+t/5ZD1n9tMjx7jHJnFna
         Fg/w==
X-Gm-Message-State: AOJu0YyFRTeCJVPfgjz6/tdNuFLYJOi3Dj+Hsw8btcxq+niufbWFQn6v
	/dZ02f3KY4/MVkgv0QAobBEM+gOa6NnuzbIqx0zNwMxhViqL1ptSnFbGooymNOI=
X-Gm-Gg: ASbGnculJmjK6D3cN4DPIGmq75iDacOyARO13E5vBNPZfqD8NVsVOS4xdeAWUEXPBpY
	X7arUWQGNTklO6O6/Ed8puRu2tJ71Ufn0Id8qeapdcdNMJ24s56L/1HhvjzAoKRqQTKZoxVajC7
	v79TLUlQjinmJuFAkDUpI8hdGyJtINQi8De73rc4nDHMl+PBQbsPItTRft68tvc8Ih0UovsyolJ
	kJU+nTaAqw5778Zb5kGHg9St75LVyq5Xvf1Q13v+lk52P5SzQdA4lm2ZsoNFYncNHkY3u/rnWW1
	Omf56TwgP0nhxzwPDNNUt7fy23oKemizhLwaTk0TPcj/Xfy3ig==
X-Google-Smtp-Source: AGHT+IHc62hSMXyBCQybh0DW1xl5UpUk+2FH16w/EZk5yE0yHwj0g8JiuD93nhp+FS97ASHVIN8/uQ==
X-Received: by 2002:a05:6000:156f:b0:385:fd31:ca23 with SMTP id ffacd0b85a97d-38a223f8302mr16102917f8f.40.1735032877514;
        Tue, 24 Dec 2024 01:34:37 -0800 (PST)
Received: from [192.168.1.62] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219a7csm160932535e9.24.2024.12.24.01.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 01:34:37 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 24 Dec 2024 10:34:31 +0100
Subject: [PATCH RFC v2 2/4] iio: adc: ad7380: enable regmap cache
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-ad7380-add-alert-support-v2-2-7c89b2bf7cb3@baylibre.com>
References: <20241224-ad7380-add-alert-support-v2-0-7c89b2bf7cb3@baylibre.com>
In-Reply-To: <20241224-ad7380-add-alert-support-v2-0-7c89b2bf7cb3@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

Enable regmap cache, to avoid useless access on spi bus.
Don't store anymore the oversampling ratio in private data structure.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 98 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 84 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 4e26e0e7ac1d5a1c4c67118dbc34f2921fc171a4..b49067c36fdd1bb0e760faf71d7fa0c8c1f610e9 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -582,7 +582,6 @@ struct ad7380_state {
 	const struct ad7380_chip_info *chip_info;
 	struct spi_device *spi;
 	struct regmap *regmap;
-	unsigned int oversampling_ratio;
 	bool resolution_boost_enabled;
 	unsigned int ch;
 	bool seq;
@@ -663,6 +662,20 @@ static int ad7380_regmap_reg_read(void *context, unsigned int reg,
 	return 0;
 }
 
+static const struct reg_default ad7380_reg_defaults[] = {
+	{ AD7380_REG_ADDR_ALERT_LOW_TH, 0x800 },
+	{ AD7380_REG_ADDR_ALERT_HIGH_TH, 0x7FF },
+};
+
+static const struct regmap_range ad7380_volatile_reg_ranges[] = {
+	regmap_reg_range(AD7380_REG_ADDR_CONFIG2, AD7380_REG_ADDR_ALERT),
+};
+
+static const struct regmap_access_table ad7380_volatile_regs = {
+	.yes_ranges = ad7380_volatile_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ad7380_volatile_reg_ranges),
+};
+
 static const struct regmap_config ad7380_regmap_config = {
 	.reg_bits = 3,
 	.val_bits = 12,
@@ -670,6 +683,10 @@ static const struct regmap_config ad7380_regmap_config = {
 	.reg_write = ad7380_regmap_reg_write,
 	.max_register = AD7380_REG_ADDR_ALERT_HIGH_TH,
 	.can_sleep = true,
+	.reg_defaults = ad7380_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(ad7380_reg_defaults),
+	.volatile_table = &ad7380_volatile_regs,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
@@ -692,6 +709,37 @@ static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
 	return ret;
 }
 
+/**
+ * ad7380_regval_to_osr - convert OSR register value to ratio
+ * @regval: register value to check
+ *
+ * Returns: the ratio corresponding to the OSR register. If regval is not in
+ * bound, return 1 (oversampling disabled)
+ *
+ */
+static int ad7380_regval_to_osr(int regval)
+{
+	if (regval < 0 || regval >= ARRAY_SIZE(ad7380_oversampling_ratios))
+		return 1;
+
+	return ad7380_oversampling_ratios[regval];
+}
+
+static int ad7380_get_osr(struct ad7380_state *st, int *val)
+{
+	int tmp;
+	int ret = 0;
+
+	ret = regmap_read(st->regmap, AD7380_REG_ADDR_CONFIG1, &tmp);
+	if (ret)
+		return ret;
+
+	*val = ad7380_regval_to_osr(FIELD_GET(AD7380_CONFIG1_OSR, tmp));
+
+	return 0;
+}
+
+
 /*
  * When switching channel, the ADC require an additional settling time.
  * According to the datasheet, data is value on the third CS low. We already
@@ -707,11 +755,15 @@ static int ad7380_set_ch(struct ad7380_state *st, unsigned int ch)
 			.unit = SPI_DELAY_UNIT_NSECS,
 		}
 	};
-	int ret;
+	int oversampling_ratio, ret;
 
 	if (st->ch == ch)
 		return 0;
 
+	ret = ad7380_get_osr(st, &oversampling_ratio);
+	if (ret)
+		return ret;
+
 	ret = regmap_update_bits(st->regmap,
 				 AD7380_REG_ADDR_CONFIG1,
 				 AD7380_CONFIG1_CH,
@@ -722,9 +774,9 @@ static int ad7380_set_ch(struct ad7380_state *st, unsigned int ch)
 
 	st->ch = ch;
 
-	if (st->oversampling_ratio > 1)
+	if (oversampling_ratio > 1)
 		xfer.delay.value = T_CONVERT_0_NS +
-			T_CONVERT_X_NS * (st->oversampling_ratio - 1) *
+			T_CONVERT_X_NS * (oversampling_ratio - 1) *
 			st->chip_info->num_simult_channels / AD7380_NUM_SDO_LINES;
 
 	return spi_sync_transfer(st->spi, &xfer, 1);
@@ -735,20 +787,25 @@ static int ad7380_set_ch(struct ad7380_state *st, unsigned int ch)
  * @st:		device instance specific state
  * @scan_type:	current scan type
  */
-static void ad7380_update_xfers(struct ad7380_state *st,
+static int ad7380_update_xfers(struct ad7380_state *st,
 				const struct iio_scan_type *scan_type)
 {
 	struct spi_transfer *xfer = st->seq ? st->seq_xfer : st->normal_xfer;
 	unsigned int t_convert = T_CONVERT_NS;
+	int oversampling_ratio, ret;
 
 	/*
 	 * In the case of oversampling, conversion time is higher than in normal
 	 * mode. Technically T_CONVERT_X_NS is lower for some chips, but we use
 	 * the maximum value for simplicity for now.
 	 */
-	if (st->oversampling_ratio > 1)
+	ret = ad7380_get_osr(st, &oversampling_ratio);
+	if (ret)
+		return ret;
+
+	if (oversampling_ratio > 1)
 		t_convert = T_CONVERT_0_NS + T_CONVERT_X_NS *
-			(st->oversampling_ratio - 1) *
+			(oversampling_ratio - 1) *
 			st->chip_info->num_simult_channels / AD7380_NUM_SDO_LINES;
 
 	if (st->seq) {
@@ -761,7 +818,7 @@ static void ad7380_update_xfers(struct ad7380_state *st,
 			st->chip_info->num_simult_channels;
 		xfer[3].rx_buf = xfer[2].rx_buf + xfer[2].len;
 		/* Additional delay required here when oversampling is enabled */
-		if (st->oversampling_ratio > 1)
+		if (oversampling_ratio > 1)
 			xfer[2].delay.value = t_convert;
 		else
 			xfer[2].delay.value = 0;
@@ -773,6 +830,8 @@ static void ad7380_update_xfers(struct ad7380_state *st,
 		xfer[1].len = BITS_TO_BYTES(scan_type->storagebits) *
 			st->chip_info->num_simult_channels;
 	}
+
+	return 0;
 }
 
 static int ad7380_triggered_buffer_preenable(struct iio_dev *indio_dev)
@@ -780,6 +839,7 @@ static int ad7380_triggered_buffer_preenable(struct iio_dev *indio_dev)
 	struct ad7380_state *st = iio_priv(indio_dev);
 	const struct iio_scan_type *scan_type;
 	struct spi_message *msg = &st->normal_msg;
+	int ret;
 
 	/*
 	 * Currently, we always read all channels at the same time. The scan_type
@@ -791,7 +851,6 @@ static int ad7380_triggered_buffer_preenable(struct iio_dev *indio_dev)
 
 	if (st->chip_info->has_mux) {
 		unsigned int index;
-		int ret;
 
 		/*
 		 * Depending on the requested scan_mask and current state,
@@ -822,7 +881,9 @@ static int ad7380_triggered_buffer_preenable(struct iio_dev *indio_dev)
 
 	}
 
-	ad7380_update_xfers(st, scan_type);
+	ret = ad7380_update_xfers(st, scan_type);
+	if (ret)
+		return ret;
 
 	return spi_optimize_message(st->spi, msg);
 }
@@ -895,7 +956,9 @@ static int ad7380_read_direct(struct ad7380_state *st, unsigned int scan_index,
 			return ret;
 	}
 
-	ad7380_update_xfers(st, scan_type);
+	ret = ad7380_update_xfers(st, scan_type);
+	if (ret)
+		return ret;
 
 	ret = spi_sync(st->spi, &st->normal_msg);
 	if (ret < 0)
@@ -973,7 +1036,16 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		*val = st->oversampling_ratio;
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = ad7380_get_osr(st, val);
+
+		iio_device_release_direct_mode(indio_dev);
+
+		if (ret)
+			return ret;
 
 		return IIO_VAL_INT;
 	default:
@@ -1049,7 +1121,6 @@ static int ad7380_write_raw(struct iio_dev *indio_dev,
 		if (ret)
 			goto err;
 
-		st->oversampling_ratio = val;
 		st->resolution_boost_enabled = boost;
 
 		/*
@@ -1109,7 +1180,6 @@ static int ad7380_init(struct ad7380_state *st, bool external_ref_en)
 	}
 
 	/* This is the default value after reset. */
-	st->oversampling_ratio = 1;
 	st->ch = 0;
 	st->seq = false;
 

-- 
2.47.1


