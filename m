Return-Path: <linux-iio+bounces-9590-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D719792E1
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 20:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952251C210D5
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 18:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C0F1D2207;
	Sat, 14 Sep 2024 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsK8NbAi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DE71D1F6B;
	Sat, 14 Sep 2024 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726337617; cv=none; b=HJag80gG5otIwDvRLVaJcWQQhep1BH0tExr0Sdp9/36vaWkiiq+9nCjvLLtlYhkpGho9Q+MF8081JR9LthfZ64Moqn4yea13PsfmzTRFyo4qNxmVZb6bQYKTuEG0IOzXRQfLf1yF+q5k5Rn8mJBgCUg2QZMLmO8zpxVAdzEEubM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726337617; c=relaxed/simple;
	bh=pKJJJ8SCewiCk5MYqqk3UIB1n5D/Y4NL2MIcr71rX2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gf0dJv6lkGQay36Wp2yxxEshpYbxDwojJKrNyIa+BN5HTVMjDyVsZS9W/5HGGRZmVJouTwnKxTsMRooQ4l+bzcXXWVsiZ+FlZ1dnfPWf1sC4wiw1BA45rmrZgym6fk855LrfXJ0NJa5yoeyhlpAHfo4OZ135ZcwZCEsYaZ3ZnSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsK8NbAi; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d8881850d9so2628636a91.3;
        Sat, 14 Sep 2024 11:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726337615; x=1726942415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQ/Jft3meKc/ILM6QOHiIcM/QHQgFekSHb0KcpsMFbY=;
        b=TsK8NbAiocmCecSUlmd83MApXygGYRrOyeqHE0EpNazZW5VJLNt3EeZhdwlQrjjgXJ
         yezaPNd8HQmSM/JZet3zRvu2L01N2BfOsgngGAhXMAvCk7pF6VRgyxSMPPZgDYFuWo49
         UEByLva4PNnKitd9OKqXDfZ8p6zeFN5NDDDN5h4A8UqAkrbwEgvSWJ2JzDX42VZy4DE9
         X/OFuu86h471uzWzDeOJXZ+L/I3wJRBROK2vl/tOwWDgHNou1cyRfhwoNHFaj90ICao5
         gjGmKesJFSJFUzHP4TicqcjZP8PkXTWIEXkdtYRk5C3JioQt2zpRt2l/UjbexeC1Unx2
         wQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726337615; x=1726942415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQ/Jft3meKc/ILM6QOHiIcM/QHQgFekSHb0KcpsMFbY=;
        b=j8Jg+MX6re1D9N8q2PeyGX5Y1yLPfAJ9Z4xgdTDwbmcFUxSXbS0ZftuQTx0+T0iIYr
         8ZShutrZTcD91UaHphcsv16QkJGpDUSNXi3wHa/YSLtgrg7GJB+FDK5B87GhH/CmZUuS
         1c1qMr4OLp1fbB9pxuLtK0mhMAzXGEEMS8zMOfd1527f2pPvWs+9RvpjErJPtqNNGhd5
         FTPQYOMFPUntJF4f/+xXnIeVFdhf6Qu8jbpnt/ROUdSPIFt1ddtZ+SHIuOmKdNOv9f9E
         BfilCfNaXmaSf66rPPuLsWrG7EFzGtnIMSumacQohjFgNlW13VG3T2Fava5yvVQMNW5x
         Enag==
X-Forwarded-Encrypted: i=1; AJvYcCUJxUUu78xNLKp/Tm5kOqVUos2q54KcHZZaLx8vIxT/w49O0L16iBDcIUUpP8F2Q0xittO2tHst0aq2AtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0zBrpLMXBXEsOwJELzqw1ATITB05fEHHiQEXZwku5J2FEojLc
	F3mbd9fP4KaQVb1eiwfu3qT6Zdxl3tEj9qtdPn4jdLDuVsuGdV5UiQwPU7ccYvk=
X-Google-Smtp-Source: AGHT+IEKNsEHD8CZGFoCwyQezivIYUotjp9OkV09spmCwPOl5zZIVr3cNOYmEObeFblCn+Q8/fEP9w==
X-Received: by 2002:a17:90b:3686:b0:2d8:82da:2627 with SMTP id 98e67ed59e1d1-2dba0061bc6mr11662235a91.27.1726337614589;
        Sat, 14 Sep 2024 11:13:34 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2dbcfd26f2csm1830870a91.31.2024.09.14.11.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 11:13:34 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v3 1/4] iio: light: ltr390: Added configurable sampling frequency support
Date: Sat, 14 Sep 2024 23:42:43 +0530
Message-ID: <20240914181246.504450-2-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240914181246.504450-1-abhashkumarjha123@gmail.com>
References: <20240914181246.504450-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provided configurable sampling frequency(Measurement rate) support.
Also exposed the available sampling frequency values using read_avail
callback.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/ltr390.c | 70 +++++++++++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index 7e58b50f3..c50ea31e2 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -39,6 +39,7 @@
 
 #define LTR390_PART_NUMBER_ID		0xb
 #define LTR390_ALS_UVS_GAIN_MASK	0x07
+#define LTR390_ALS_UVS_MEAS_RATE_MASK	GENMASK(2, 0)
 #define LTR390_ALS_UVS_INT_TIME_MASK	0x70
 #define LTR390_ALS_UVS_INT_TIME(x)	FIELD_PREP(LTR390_ALS_UVS_INT_TIME_MASK, (x))
 
@@ -87,6 +88,18 @@ static const struct regmap_config ltr390_regmap_config = {
 	.val_bits = 8,
 };
 
+/* Sampling frequency is in mili Hz and mili Seconds */
+static const int ltr390_samp_freq_table[][2] = {
+		[0] = { 40000, 25 },
+		[1] = { 20000, 50 },
+		[2] = { 10000, 100 },
+		[3] = { 5000, 200 },
+		[4] = { 2000, 500 },
+		[5] = { 1000, 1000 },
+		[6] = { 500, 2000 },
+		[7] = { 500, 2000 },
+};
+
 static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
 {
 	struct device *dev = &data->client->dev;
@@ -135,6 +148,18 @@ static int ltr390_counts_per_uvi(struct ltr390_data *data)
 	return DIV_ROUND_CLOSEST(23 * data->gain * data->int_time_us, 10 * orig_gain * orig_int_time);
 }
 
+static int ltr390_get_samp_freq(struct ltr390_data *data)
+{
+	int ret, value;
+
+	ret = regmap_read(data->regmap, LTR390_ALS_UVS_MEAS_RATE, &value);
+	if (ret < 0)
+		return ret;
+	value = FIELD_GET(LTR390_ALS_UVS_MEAS_RATE_MASK, value);
+
+	return ltr390_samp_freq_table[value][0];
+}
+
 static int ltr390_read_raw(struct iio_dev *iio_device,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
@@ -191,6 +216,10 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 		*val = data->int_time_us;
 		return IIO_VAL_INT;
 
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = ltr390_get_samp_freq(data);
+		return IIO_VAL_INT;
+
 	default:
 		return -EINVAL;
 	}
@@ -199,6 +228,7 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 /* integration time in us */
 static const int ltr390_int_time_map_us[] = { 400000, 200000, 100000, 50000, 25000, 12500 };
 static const int ltr390_gain_map[] = { 1, 3, 6, 9, 18 };
+static const int ltr390_freq_map[] = { 40000, 20000, 10000, 5000, 2000, 1000, 500, 500 };
 
 static const struct iio_chan_spec ltr390_channels[] = {
 	/* UV sensor */
@@ -206,16 +236,20 @@ static const struct iio_chan_spec ltr390_channels[] = {
 		.type = IIO_UVINDEX,
 		.scan_index = 0,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
-		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+							BIT(IIO_CHAN_INFO_SCALE) |
+							BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	},
 	/* ALS sensor */
 	{
 		.type = IIO_LIGHT,
 		.scan_index = 1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
-		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+							BIT(IIO_CHAN_INFO_SCALE) |
+							BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	},
 };
 
@@ -264,6 +298,23 @@ static int ltr390_set_int_time(struct ltr390_data *data, int val)
 	return -EINVAL;
 }
 
+static int ltr390_set_samp_freq(struct ltr390_data *data, int val)
+{
+	int idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(ltr390_samp_freq_table); idx++) {
+		if (ltr390_samp_freq_table[idx][0] != val)
+			continue;
+
+		guard(mutex)(&data->lock);
+		return regmap_update_bits(data->regmap,
+					LTR390_ALS_UVS_MEAS_RATE,
+					LTR390_ALS_UVS_MEAS_RATE_MASK, idx);
+	}
+
+	return -EINVAL;
+}
+
 static int ltr390_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
 				const int **vals, int *type, int *length, long mask)
 {
@@ -278,6 +329,11 @@ static int ltr390_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec con
 		*type = IIO_VAL_INT;
 		*vals = ltr390_int_time_map_us;
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*length = ARRAY_SIZE(ltr390_freq_map);
+		*type = IIO_VAL_INT;
+		*vals = ltr390_freq_map;
+		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
 	}
@@ -301,6 +357,12 @@ static int ltr390_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec cons
 
 		return ltr390_set_int_time(data, val);
 
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val2 != 0)
+			return -EINVAL;
+
+		return ltr390_set_samp_freq(data, val);
+
 	default:
 		return -EINVAL;
 	}
-- 
2.43.0


