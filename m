Return-Path: <linux-iio+bounces-16278-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0682A4BF41
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 12:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27F1E167FC1
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 11:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D2E20E6E5;
	Mon,  3 Mar 2025 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rLc7SPlv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3F920E00D
	for <linux-iio@vger.kernel.org>; Mon,  3 Mar 2025 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002478; cv=none; b=rVq8UBqqk02+GWH8y8ADLlQXYXLwvJbNWJ+gtNoG0OqSlYj44V4yDkGo+g+E4I5ia3dueX8wcwXNoWoKZjqf55mAKwR34RIOeHhG18Qvgb/v7NXeMR+XPjwJJp08NZWWwLx6/xTSTcfTwJQU/iKYBCo8wCLFZFqfAQDHK/PEn6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002478; c=relaxed/simple;
	bh=cGqPD8/SZrkOEEoS5r71WCJ1/AsMqIH3QA/fWi2qpiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzoXHy7/tAZOHOk1ksfa5U1sD2elaZ3IPgFnLcJfBhh2uveXjGd0gTHoLSuiIDaUnbwSLVGfP1QlYGGaUEHWX5rvCZlx7Om7jXCUhKrk2xEbMADLvKZqTUg/97K6oMiOsX1WvskA63FDl9EMkRwgdyl9PSsqmlJBD9pFurmTLuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rLc7SPlv; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-390e702d481so1774252f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Mar 2025 03:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741002475; x=1741607275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JfuBlnVs+Mi+9z09rt1BKUuKJ56NGKvPoa3JHTdL8U=;
        b=rLc7SPlvITfDKZc0T1DYAS7loPH9CBrtv9OfIEJGGCNNUEBGjA9ZStuDvDfS3ixCbu
         FjvujN+FrzTVScHm7sdbC5HWSktmrqVeka3tpA00C7q4Kh+XPgvwwVQHjh+7JOBwfkg+
         8UEk5MtWkd3SMXkLg0NRPs7ForPFjtoGt09g1e5NBApZfG9A4KyICwtJ5PqoZF6fwF7R
         II+aVR4xw16DvUpXm3bmR2p2I7B9tftr36dwoxT1Ijg0x2CXcThR18mfX/5xJHijpxqe
         myVXhltfEk3cWEvrnWByLyif5p11uUaJkWqqzOAmFPMXbtcOkB8QrVNvwoXPNDwvSI88
         5Rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002475; x=1741607275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JfuBlnVs+Mi+9z09rt1BKUuKJ56NGKvPoa3JHTdL8U=;
        b=g0J7WfQNSb22SNPmebW20REz/8hKwIJV9E2fiL1tPecIa/XAEv9UDFUwKF/ggL5oL/
         56E8Dw5BqgMfp7Im0r1XN50KcN1tcAp/o4qDUEk5Hu/yVZumV9nvIiNfE5jgE8FM+j0f
         M1JJDiTTbt/l80ZfihwqICgmsGU+KjfnQh+z9I5d+NtFoPF1ftCMNPjp/RwpgRmtIflS
         kQ86Y3O9SijNoeXRPdanB+t6a+xpZuyLN0sz/e2j0mndh9gaLMR7LjCfAdpC0tFHfNgB
         F4pb8P7KzSR64uun/PuH9TI7eRQHCyh8pgnMzRa4aNGwug8DFyEA4XxkMs+IJ7f9RwqA
         JQ5w==
X-Forwarded-Encrypted: i=1; AJvYcCXvMTuXIfFU3/wJNLwzWHjg8SLRSmh2CcSbS/GWn86S6Muk0ZKJUbPv/bYZKmOdbh9ffOWoSs94Ejk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXFOCoU/OCs6usDEliNjfTfJHvW0W61mHWwUuETDMb8xLqgPFV
	kO3giebLWsTv/Z6D13NNZcAG3a3upv9sFILjh0g3OewNbeO9CGlTKxIDtvmmfQE=
X-Gm-Gg: ASbGncs6HiN0BAgy8MW9ochh74MBlDA2FHq6DxsYMFUGPoqUEvshsGyAcgagOUu7WZE
	NKXKcTJesKBhGRXrxocKtfNRh+n1x8XE9Gk5OILUJCCHUi2wP9hfsUt44ZGg1GxeZ5k8gu1ld0v
	ZIe1978AgRdN2jdu+Chqm4kuQ68RZfZs60LF1YxKvRDfBRctWjTwfuTzv+n2yxm11zQ5nkUFB+L
	e/+6mNbnbNTVSwo3zyo6fB6eg4JF+x7/orfcbLyeO42TlU6OMNWQOo5nZZCf1PNpttBKro0UNlp
	xB8KckM8I0Blnz3ZM5MVK0M60QYhsIWmyUuV78cAL8TTelRxnloH9+9DTPPMZo75DP1GO9zIwZZ
	ie6XK4pdhvwK+oez6QJ1+kHkZvA==
X-Google-Smtp-Source: AGHT+IGkSIxp717Pg3OS71H44ATwH724qKt8I091Xvxo2HPuDyZAhdmwoEbHrejhhauDj7QidAGPPQ==
X-Received: by 2002:a5d:5f4c:0:b0:390:fd7c:98be with SMTP id ffacd0b85a97d-390fd7c9b46mr5721261f8f.19.1741002474987;
        Mon, 03 Mar 2025 03:47:54 -0800 (PST)
Received: from localhost (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d17sm14048575f8f.28.2025.03.03.03.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:47:54 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Guillaume Ranquet <granquet@baylibre.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Michael Walle <michael@walle.cc>,
	Nuno Sa <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/8] iio: adc: ad7124: Implement system calibration
Date: Mon,  3 Mar 2025 12:47:06 +0100
Message-ID: <20250303114659.1672695-18-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250303114659.1672695-10-u.kleine-koenig@baylibre.com>
References: <20250303114659.1672695-10-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5359; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=cGqPD8/SZrkOEEoS5r71WCJ1/AsMqIH3QA/fWi2qpiM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnxZbQQj85GuyCEcT/+/txKbDasve9RcMnzqqly Hw1ZzYSxYWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ8WW0AAKCRCPgPtYfRL+ Tu9CCACvrDJKvuayNJIw8lOaq4cQjCSsgpuDp3xSqYdQ2o0NL/lOdxFoQ4DOFsOhe5DawJVGVaw DBFDkuLlNr/FSXmbtWmojqmMpdi50c0jrtDWW4rSB0N3PBSHol+PQgWEbpx+3WmlNuOf0a4ozOS 4IiTn8pdcBWdPOGENAzLT2G7xVtVuO93XpPDpxQpyba7DNud6doMPUPYC5TUIm2OYQS8FQ+c8Ss fKPaoM03QcH/s5ObNYfDYsm8WVRZbI3a4nvt1SIgYFK7FIZg2OZMGHWly/xl5vKD3COFkNodkZM YoZRbA2e+yL9SuvgxnprI6blsEpMFRVIExfDONzOlcuZgnWr
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Allow triggering both zero-scale and full-scale calibration via sysfs in
the same way as it's done for ad7173.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 153 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 136 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 382f46ff2b51..5ab0d3e48c43 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -4,6 +4,7 @@
  *
  * Copyright 2018 Analog Devices Inc.
  */
+
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
@@ -181,6 +182,7 @@ struct ad7124_channel {
 	struct ad7124_channel_config cfg;
 	unsigned int ain;
 	unsigned int slot;
+	u8 syscalib_mode;
 };
 
 struct ad7124_state {
@@ -202,23 +204,6 @@ struct ad7124_state {
 	DECLARE_KFIFO(live_cfgs_fifo, struct ad7124_channel_config *, AD7124_MAX_CONFIGS);
 };
 
-static const struct iio_chan_spec ad7124_channel_template = {
-	.type = IIO_VOLTAGE,
-	.indexed = 1,
-	.differential = 1,
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		BIT(IIO_CHAN_INFO_SCALE) |
-		BIT(IIO_CHAN_INFO_OFFSET) |
-		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
-	.scan_type = {
-		.sign = 'u',
-		.realbits = 24,
-		.storagebits = 32,
-		.endianness = IIO_BE,
-	},
-};
-
 static struct ad7124_chip_info ad7124_chip_info_tbl[] = {
 	[ID_AD7124_4] = {
 		.name = "ad7124-4",
@@ -903,6 +888,140 @@ static int ad7124_check_chip_id(struct ad7124_state *st)
 	return 0;
 }
 
+enum {
+	AD7124_SYSCALIB_ZERO_SCALE,
+	AD7124_SYSCALIB_FULL_SCALE,
+};
+
+static int ad7124_syscalib_locked(struct ad7124_state *st, const struct iio_chan_spec *chan)
+{
+	struct device *dev = &st->sd.spi->dev;
+	struct ad7124_channel *ch = &st->channels[chan->channel];
+	int ret;
+
+	if (ch->syscalib_mode == AD7124_SYSCALIB_ZERO_SCALE) {
+		ch->cfg.calibration_offset = 0x800000;
+
+		ret = ad_sd_calibrate(&st->sd, AD7124_MODE_CAL_SYS_ZERO,
+				      chan->address);
+		if (ret < 0)
+			return ret;
+
+		ret = ad_sd_read_reg(&st->sd, AD7124_OFFSET(ch->cfg.cfg_slot), 3,
+				     &ch->cfg.calibration_offset);
+		if (ret < 0)
+			return ret;
+
+		dev_dbg(dev, "offset for channel %d after zero-scale calibration: 0x%x\n",
+			chan->channel, ch->cfg.calibration_offset);
+	} else {
+		ch->cfg.calibration_gain = st->gain_default;
+
+		ret = ad_sd_calibrate(&st->sd, AD7124_MODE_CAL_SYS_FULL,
+				      chan->address);
+		if (ret < 0)
+			return ret;
+
+		ret = ad_sd_read_reg(&st->sd, AD7124_GAIN(ch->cfg.cfg_slot), 3,
+				     &ch->cfg.calibration_gain);
+		if (ret < 0)
+			return ret;
+
+		dev_dbg(dev, "gain for channel %d after full-scale calibration: 0x%x\n",
+			chan->channel, ch->cfg.calibration_gain);
+	}
+
+	return 0;
+}
+
+static ssize_t ad7124_write_syscalib(struct iio_dev *indio_dev,
+				     uintptr_t private,
+				     const struct iio_chan_spec *chan,
+				     const char *buf, size_t len)
+{
+	struct ad7124_state *st = iio_priv(indio_dev);
+	bool sys_calib;
+	int ret;
+
+	ret = kstrtobool(buf, &sys_calib);
+	if (ret)
+		return ret;
+
+	if (!sys_calib)
+		return len;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = ad7124_syscalib_locked(st, chan);
+
+	iio_device_release_direct(indio_dev);
+
+	return ret ?: len;
+}
+
+static const char * const ad7124_syscalib_modes[] = {
+	[AD7124_SYSCALIB_ZERO_SCALE] = "zero_scale",
+	[AD7124_SYSCALIB_FULL_SCALE] = "full_scale",
+};
+
+static int ad7124_set_syscalib_mode(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    unsigned int mode)
+{
+	struct ad7124_state *st = iio_priv(indio_dev);
+
+	st->channels[chan->channel].syscalib_mode = mode;
+
+	return 0;
+}
+
+static int ad7124_get_syscalib_mode(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan)
+{
+	struct ad7124_state *st = iio_priv(indio_dev);
+
+	return st->channels[chan->channel].syscalib_mode;
+}
+
+static const struct iio_enum ad7124_syscalib_mode_enum = {
+	.items = ad7124_syscalib_modes,
+	.num_items = ARRAY_SIZE(ad7124_syscalib_modes),
+	.set = ad7124_set_syscalib_mode,
+	.get = ad7124_get_syscalib_mode
+};
+
+static const struct iio_chan_spec_ext_info ad7124_calibsys_ext_info[] = {
+	{
+		.name = "sys_calibration",
+		.write = ad7124_write_syscalib,
+		.shared = IIO_SEPARATE,
+	},
+	IIO_ENUM("sys_calibration_mode", IIO_SEPARATE,
+		 &ad7124_syscalib_mode_enum),
+	IIO_ENUM_AVAILABLE("sys_calibration_mode", IIO_SHARED_BY_TYPE,
+			   &ad7124_syscalib_mode_enum),
+	{ }
+};
+
+static const struct iio_chan_spec ad7124_channel_template = {
+	.type = IIO_VOLTAGE,
+	.indexed = 1,
+	.differential = 1,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_SCALE) |
+		BIT(IIO_CHAN_INFO_OFFSET) |
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+	.scan_type = {
+		.sign = 'u',
+		.realbits = 24,
+		.storagebits = 32,
+		.endianness = IIO_BE,
+	},
+	.ext_info = ad7124_calibsys_ext_info,
+};
+
 /*
  * Input specifiers 8 - 15 are explicitly reserved for ad7124-4
  * while they are fine for ad7124-8. Values above 31 don't fit
-- 
2.47.1


