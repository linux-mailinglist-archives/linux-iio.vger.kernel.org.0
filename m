Return-Path: <linux-iio+bounces-26467-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE7BC87048
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 21:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0DE3B2F66
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 20:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3936F33D6EB;
	Tue, 25 Nov 2025 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NtdYM2ZQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A35B33C519
	for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 20:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764102199; cv=none; b=L3bYcvm/Jbdjs0rcdMctA10x2lAgUIQ0H2p74Ti6knc9Gq0ZsOukB8Vt4wSKTSjw5VNsSV/9NM51jik30gh+a0Zxz7Fr6NRDosOtWf885xOW6hoYBP8DwsoS87nHj0NBQ9PR89QZWg+HgNbaUcMnAou+t6HQe7z9BaHTgehrA6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764102199; c=relaxed/simple;
	bh=Hb1zr2alwVQYcp7QMo+P9C4EGA5XkhpF1f4WPadLW7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=adHV5v38E0oDiBkXRvxBk4aLKEln4zHQN5uS1KSp33gH2Snc4pcbrsd53vhQgRX1yGwOWtTUKylTFFr2Y71JQ36K/VF7rf+EN6xVfFVbYNSu5/3IP0G3J+mw97YyghwyLdzIKaBbjwYctuZzgQkmVzRwXTn4zT3ad5vQoof9BBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NtdYM2ZQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b735ce67d1dso930779066b.3
        for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 12:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764102195; x=1764706995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfRpMGSd7y9d0byFFdqTrDp2AlO8u4+9bS6XzrmHfjQ=;
        b=NtdYM2ZQIUvui7ybVr9e2/8ipNxbswDh9k5I4/TX5IXuknLo7PnluOa9FZ0Md9pjhW
         H16iiTRSnqXudV6JVZtsgdvNOLiuBQtJS/xuuC5Qej6DfsotILo19w7Vg+FuycIN6kKc
         wDRcPzoB3IvaqkishWbw8zq9tkr4KJpXdMogq0Z9yrT00qWWHTUO0P+ii8wBC9lXF9jh
         4VVxSlDFeRtrFaRiLP83HVjhcnFCdfLU8gmorpnjjrIA6VRXhSRgRDrMljd+EoY9RQPG
         bKbjuLqIbm1BRnJQFuiz66n2Xn58fbsXqskh6Yyv4AksoPk/C08zOfcfrRJjDwblK8Yg
         QQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764102195; x=1764706995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UfRpMGSd7y9d0byFFdqTrDp2AlO8u4+9bS6XzrmHfjQ=;
        b=HjJlgxq65+rXaLgfYj3Y9myQCSBscPQsroqvW+6r746fcxTQ4LQcqnp+xXpVrZc1p/
         aosfEIPydeySUbHK0ot4nLj6rMgFJF3euZbGZ6LSX+XeYxUZpXAPDXHs91tmqYDBY+6L
         sRxjN3k+Q2aG/62axxwPUED9mYmCG4M3aJJBJwR6bIsA3QVYbaR3bN2emEvLLBWdQ3Yb
         HSj+q1R2Pe6dUYfq/EE5g8ZvC0iZXP0O3BLOUkaGWY9QlEUobgYu7pS9GOa0T96fGYUR
         G4yhQDCGLt1N6Q4gKyP6hRDBMtNLFuqesbRBpuD03YvVOMQvlm4+SX1P7r6fRDadEFDv
         yOHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrsQyTDu3N8tAijIOveUxHbbmaHlxdIKM0sGu0yN59JKU+fQsdYjq7zPo9QpUyzkX5AdzQc5xuvzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy57XP2K6lrxEUAVrSHZbh/LjrPVWsJw0XSdxM2p8pW5sMuD1vf
	ga86VHXkQbmY03xEWOukgntXkPMQsXscIIYy+ztm1R3DerOTHVD8xntGdMz1yh90r+8=
X-Gm-Gg: ASbGncunxcisqQXxUSK7FGwZzoAOFrU1QDfVuGQERGMGX6brqoIm+vL4KRRCYQFRutM
	cBrQCHXq5WW1k34YDaZbGmCju5jkxZG30hp6v775hexUYgkXUzS33rGXYj8IZPGxUo7g7ck+UoS
	SHrQa0sSINXInKBHWdVAh/52Q/CSXeIGcR1eD/QcAFADXBhhECbNpUQSmimnuoLEDDIBFBqKRLT
	aVAnv8tJsHag3cQ9gity3TPAp7G9CP0ULqrhzej0eHMsIR4pvuM6HRHSkwm7DzmLSZebmOAUllk
	3QVuT3e8LPY26FuRqZbk4uCwzSjgALekr7znhJvpZb+N1OlYCLTT2uYqdN9LcvgQVOjxh4fqyVL
	8WvZzm37Fk1DkjzvWoHJHXWTP5n6ZW7hETucTkyvmVvpJT8YdQrBvXj3gP2bXsxYfML+yVzJilm
	lElQ==
X-Google-Smtp-Source: AGHT+IFpxWL3ao3JaYTVxSx1a400xB3QpLjsTSDRGGvMCvwqUEvobLbSlcKVS+FCjQLg3DEwLgmS8g==
X-Received: by 2002:a17:907:2d12:b0:b73:594e:1c47 with SMTP id a640c23a62f3a-b76c540b1d5mr464097466b.26.1764102195433;
        Tue, 25 Nov 2025 12:23:15 -0800 (PST)
Received: from localhost ([151.35.128.119])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd43e2sm1651602666b.39.2025.11.25.12.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 12:23:15 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v3 5/9] iio: imu: st_lsm6dsx: remove event_threshold field from hw struct
Date: Tue, 25 Nov 2025 21:23:03 +0100
Message-Id: <20251125202307.4033346-6-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251125202307.4033346-1-flavra@baylibre.com>
References: <20251125202307.4033346-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2908; i=flavra@baylibre.com; h=from:subject; bh=Hb1zr2alwVQYcp7QMo+P9C4EGA5XkhpF1f4WPadLW7c=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpJhADTjcYUfLEOFcXnMU2lpB8wmZGiiVcFvMuJ mTWraWzVvOJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaSYQAwAKCRDt8TtzzpQ2 X5DJC/9fLgh7q/NyEPEV84dK//ft+taLDfstrh+XkNW62d36awt/NcLdhH6avhxLJs9pxdi1DBd 4bZd3xi8Lu3e9Dmnr4Ru3tjG6AQSX/v68WEhZm3r/FH2bOMe8/RUic0hmqalEFeaWlfnNRQ4rJm +Gy8LKTWfe0mlql63fFpTa1SiHdjgl7+u4N8fAR6pF0OJfP0IrveNeY0vBbT9plFhFzlM6tuJuD JXcfHNnUU0XYhGV9INBHYehsbn5xmXgFnN7wuiZ7sI6gbhLudFLxg4IKwS0IiYbho+kXj5e+hNn 8Qp2ue3MquQZHKAOe5N7R0HWEPu+a3nTom02QRQgFUMIleLJpJH9FeG/0uiiofAiCjqfOsEUU5t fnpTZhO8FRpzOg7gAO7jNVJs3cc7fQBSI/4OLKyq4D1OFrS/zoiRi4QvOMD3qb+xGAlxMgukNaG lQ0FcqYP81xTiC8QrgKvv5fK/05Y2hWZn+R3ujhaGwsz6vLUCz41EJfR7FI71Kw24twDE=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This field is used to store the wakeup event detection threshold value.
When adding support for more event types, some of which may have different
threshold values for different axes, storing all threshold values for all
event sources would be cumbersome. Thus, remove this field altogether, and
read the currently configured value from the sensor when requested by
userspace.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  3 +--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 12 +++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 4200e5231950..b27a833d5107 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -79,6 +79,7 @@ enum st_lsm6dsx_hw_id {
 #define ST_LSM6DSX_MAX_TAGGED_WORD_LEN	((32 / ST_LSM6DSX_TAGGED_SAMPLE_SIZE) \
 					 * ST_LSM6DSX_TAGGED_SAMPLE_SIZE)
 #define ST_LSM6DSX_SHIFT_VAL(val, mask)	(((val) << __ffs(mask)) & (mask))
+#define st_lsm6dsx_field_get(mask, reg)	((reg & mask) >> __ffs(mask))
 
 #define ST_LSM6DSX_CHANNEL_ACC(chan_type, addr, mod, scan_idx)		\
 {									\
@@ -421,7 +422,6 @@ struct st_lsm6dsx_sensor {
  * @sip: Total number of samples (acc/gyro/ts) in a given pattern.
  * @buff: Device read buffer.
  * @irq_routing: pointer to interrupt routing configuration.
- * @event_threshold: wakeup event threshold.
  * @enable_event: enabled event bitmask.
  * @iio_devs: Pointers to acc/gyro iio_dev instances.
  * @settings: Pointer to the specific sensor settings in use.
@@ -445,7 +445,6 @@ struct st_lsm6dsx_hw {
 	u8 sip;
 
 	u8 irq_routing;
-	u8 event_threshold;
 	u8 enable_event;
 
 	u8 *buff;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 828e495c870c..dbdf9bb9e258 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1911,12 +1911,20 @@ static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	struct st_lsm6dsx_hw *hw = sensor->hw;
+	const struct st_lsm6dsx_reg *reg;
+	u8 data;
+	int err;
 
 	if (type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
+	reg = &hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP].value;
+	err = st_lsm6dsx_read_locked(hw, reg->addr, &data, sizeof(data));
+	if (err < 0)
+		return err;
+
 	*val2 = 0;
-	*val = hw->event_threshold;
+	*val = st_lsm6dsx_field_get(reg->mask, data);
 
 	return IIO_VAL_INT;
 }
@@ -1948,8 +1956,6 @@ st_lsm6dsx_write_event(struct iio_dev *iio_dev,
 	if (err < 0)
 		return -EINVAL;
 
-	hw->event_threshold = val;
-
 	return 0;
 }
 
-- 
2.39.5


